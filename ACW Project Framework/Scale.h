#pragma once

#include <DirectXMath.h>
#include <memory>
#include <vector>

using namespace DirectX;
using namespace std;

class Scale
{

public:
	Scale(); // Default Constructor
	explicit Scale(const XMFLOAT3& scale);
	Scale(const float x, const float y, const float z);
	explicit Scale(const vector<XMFLOAT3>& scales);
	Scale(const Scale& other); // Copy Constructor
	Scale(Scale&& other) noexcept; // Move Constructor
	~Scale(); // Destructor

	Scale& operator = (const Scale& other); // Copy Assignment Operator
	Scale& operator = (Scale&& other) noexcept; // Move Assignment Operator

	const vector<XMFLOAT3>& GetScales() const;
	const XMFLOAT3& GetScaleAt(const int index) const;

	void AddScaleBack(const XMFLOAT3& scale);
	void AddScaleBack(const float x, const float y, const float z);

	void AddScaleFront(const XMFLOAT3& scale);
	void AddScaleFront(const float x, const float y, const float z);

	void RemoveScaleBack();

	void SetScaleAt(const XMFLOAT3& newScale, const int index);
	void SetScaleAt(const float x, const float y, const float z, const int index);

	void IncreaseAllScales(const XMFLOAT3& scalar);
	void IncreaseAllScales(const float x, const float y, const float z);

	void IncreaseScaleAt(const XMFLOAT3& scalar, const int index);
	void IncreaseScaleAt(const float x, const float y, const float z, const int index);



private:
	vector<XMFLOAT3> m_scales;
};

