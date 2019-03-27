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
	matrix instanceWorldMatrix : INSTANCEMATRIX;
};

struct HullInput
{
	float3 position : POSITION;
	float3 tex : TEXCOORD0;
	float tessellationFactor : TESS;
};

HullInput TextureCubeVertexShader(VertexInput input)
{
	HullInput output;

	//Calculate the position of the vertex against the matrices
	output.position = mul(float4(input.position, 1.0f), input.instanceWorldMatrix).xyz;

	//Pass colour as is to pixel shader
	output.tex = input.position;

	float distanceToCamera = distance(output.position, cameraPosition);

	float tess = saturate((minTessellationDistance - distanceToCamera) / (minTessellationDistance - maxTessellationDistance));

	output.tessellationFactor = minTessellationFactor + tess * (maxTessellationFactor - minTessellationFactor);

	return output;
}