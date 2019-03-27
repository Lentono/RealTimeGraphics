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
	matrix instanceWorldMatrix : INSTANCEMATRIX;
};

struct HullInput
{
	float3 position : POSITION;
	float3 posWorld : TEXCOORD1;
	float3 normal : NORMAL;
	float tessellationFactor : TESS;
};

HullInput ReflectionVertexShader(VertexInput input)
{
	HullInput output;

	output.posWorld = input.position;

	output.position = mul(float4(input.position, 1.0f), input.instanceWorldMatrix).xyz;

	output.normal = mul(float4(input.normal, 1.0f), input.instanceWorldMatrix).xyz;

	float distanceToCamera = distance(output.position, cameraPosition);

	float tess = saturate((minTessellationDistance - distanceToCamera) / (minTessellationDistance - maxTessellationDistance));

	output.tessellationFactor = minTessellationFactor + tess * (maxTessellationFactor - minTessellationFactor);

	return output;
}