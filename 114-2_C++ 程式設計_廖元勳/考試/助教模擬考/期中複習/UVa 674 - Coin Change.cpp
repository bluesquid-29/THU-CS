#include <iostream>
#include <array>
using namespace std;

int const MAX = 7490;

int main()
{
	array<int, MAX> dp = {0};
	array<int, 5> cent = {1, 5, 10, 25, 50};
		
	dp[0] = 1;
	for (int i = 0; i < 5; ++i)
	{
		for (int j = cent[i]; j < MAX; ++j)
		{
			dp[j] = dp[j] + dp[j - cent[i]];	
		}	
	}
	
	int N;
	while (cin >> N)  { cout << dp[N] << "\n"; }
	
	return 0;
}