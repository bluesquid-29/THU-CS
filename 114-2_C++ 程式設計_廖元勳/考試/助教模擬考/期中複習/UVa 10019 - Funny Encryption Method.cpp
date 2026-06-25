#include <iostream>
using namespace std;

int Dec_to_Bin(int n)
{
	int b1 = 0;
	while (n >= 1)
	{
		if (n % 2 == 1)  { b1++; }
		n /= 2;
	}
	
	return b1;
}

int Hex_to_Bin(int n)
{
	int b2 = 0;
	while (n >= 1)
	{
		b2 += Dec_to_Bin(n % 10);
		n /= 10;
	}
	
	return b2;
}

int main()
{
	int T;  cin >> T;
	while (T--)
	{
		int N;  cin >> N;
		cout << Dec_to_Bin(N) << " " << Hex_to_Bin(N) << "\n";
	}
	
	return 0;
}