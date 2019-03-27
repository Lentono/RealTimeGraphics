cbuffer MatrixBuffer : register(b0)
{
	matrix worldInverseMatrix;
	matrix texTransform;
};

cbuffer TessellationBuffer : register(b1)
{
	float maxTessellationDistance;
	float minTessellationDistance;
	float maxTessellationFactor;
	float minTessellationFactor;
};

cbuffer CameraBuffer : register(b2)
{
	float3 cameraPosition;
	float padding;
};

//Type definitions
struct VertexInput
{
	float3 position : POSITION;
	float2 tex : TEXCOORD0;
	float3 normal : NORMAL;
	float3 tangent : TANGENT;
	float3 binormal : BINORMAL;
	matrix instanceWorldMatrix : INSTANCEMATRIX;
};

struct HullInput
{
	float3 position : POSITION;
	float2 tex : TEXCOORD0;
	float3 normal : NORMAL;
	float3 tangent : TANGENT;
	float3 binormal : BINORMAL;
	float tessellationFactor : TESS;
};

HullInput TextureNormalSpecularVS(VertexInput input)
{
	HullInput output;

	//Calculate the position of the vertex against the matrices
	output.position = mul(float4(input.position, 1.0f), input.instanceWorldMatrix).xyz;

	output.tex = input.tex;

	//Calculate the normal, tangent and binormal against world and normalize it
	output.normal = normalize(mul(input.normal, (float3x3)input.instanceWorldMatrix));
	output.tangent = normalize(mul(input.tangent, (float3x3)input.instanceWorldMatrix));
	output.binormal = normalize(mul(input.binormal, (float3x3)input.instanceWorldMatrix));

	float distanceToCamera = distance(output.position, cameraPosition);

	float tess = saturate((minTessellationDistance - distanceToCamera) / (minTessellationDistance - maxTessellationDistance));

	output.tessellationFactor = minTessellationFactor + tess * (maxTessellationFactor - minTessellationFactor);

	return output;
}