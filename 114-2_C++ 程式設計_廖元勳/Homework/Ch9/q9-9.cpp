#include <iostream>
using namespace std;

void Cm_to_Inch(double *p)
{
	*p = (*p) * 0.394;
}

int main()
{
	cout << "請輸入欲轉換的公分數：";
	double x;  cin >> x;
	
	cout << x << " 公分 = ";
	Cm_to_Inch(&x);
	cout << x << " 英吋\n";

	return 0;
}
