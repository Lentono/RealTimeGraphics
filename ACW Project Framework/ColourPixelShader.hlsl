
//Type definitions
struct PixelInput
{
	float4 positionH : SV_POSITION;
	float3 positionW : POSITION;
	float4 colour : COLOR;
};

float4 ColourPixelShader(PixelInput input) : SV_TARGET
{
	return input.colour;
}