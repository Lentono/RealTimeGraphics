#pragma once

#include <DirectXMath.h>
#include <memory>

using namespace DirectX;
using namespace std;

class Light
{
public:
	Light(); // Default Constructor
	//Light(const Light& other); // Copy Constructor
	//Light(Light&& other) noexcept; // Move Constructor
	virtual ~Light(); // Destructor

	//Light& operator = (const Light& other); // Copy Assignment Operator
	//Light& operator = (Light&& other) noexcept; // Move Assignment Operator

	void SetLightOrbit(const bool orbit);
	void SetDirectionalLight(const bool directionalLight);

	void SetLightPosition(const float x, const float y, const float z);
	void SetLightPosition(const XMFLOAT3& lightPosition);
	void SetLightPointPosition(const float x, const float y, const float z);
	void SetLightPointPosition(const XMFLOAT3& lightPointPosition);

	void SetAmbientColour(const float red, const float green, const float blue, const float alpha);
	void SetAmbientColour(const XMFLOAT4& ambientColour);
	void SetDiffuseColour(const float red, const float green, const float blue, const float alpha);
	void SetDiffuseColour(const XMFLOAT4& diffuseColour);
	void SetSpecularColour(const float red, const float green, const float blue, const float alpha);
	void SetSpecularColour(const XMFLOAT4& specularColour);

	void SetSpecularPower(const float specularPower);

	void GenerateLightProjectionMatrix(const float width, const float length, const float screenNear, const float screenDepth);

	const bool GetIsDirectionalLight() const;

	const XMFLOAT3& GetLightPosition() const;
	//const XMFLOAT3& GetLightDirection() const;

	const XMFLOAT4& GetAmbientColour() const;
	const XMFLOAT4& GetDiffuseColour() const;
	const XMFLOAT4& GetSpecularColour() const;

	float GetSpecularPower() const;

	const XMMATRIX GetLightViewMatrix() const;
	const XMMATRIX GetLightProjectionMatrix() const;

	void SetLightOrbitDirection();
	void UpdateLightVariables(const float dt);

private:
	void UpdateLightDirection();
	void UpdateLightViewMatrix(const float dt);

	bool m_orbit;
	bool m_directionalLight;

	XMFLOAT3 m_lightPosition;
	XMFLOAT3 m_lightRotation;
	XMFLOAT3 m_lightPointPosition;
	XMFLOAT3 m_lightOrbitDirection;
	XMFLOAT3 m_lightDirection;

	XMFLOAT4 m_ambientColour;
	XMFLOAT4 m_diffuseColour;
	XMFLOAT4 m_specularColour;

	float m_specularPower;

	XMFLOAT4X4 m_lightViewMatrix;
	XMFLOAT4X4 m_lightProjectionMatrix;
};