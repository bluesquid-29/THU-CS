#include <iostream>
#include <vector>
using namespace std;

int GCD(int a, int b)
{
	if (a == 0)  { return b; }
	if (b == 0)  { return a; }
	
	return GCD (b, a % b);
}

int main()
{
	int first;
	while (cin >> first and first != 0)
	{
		vector<int> A;  A.push_back(first);
		
		int n;
		while (cin >> n and n != 0)  { A.push_back(n); }
		
		vector<int> B;
		for (int i = 1; i < A.size(); ++i)  { B.push_back(abs(A[i] - A[i-1])); }
		
		int ans = B[0];
		for (int i = 1; i < B.size(); ++i)  { ans = GCD(B[i], ans); }
		
		cout << ans << "\n";
	}
	
	return 0;
}
