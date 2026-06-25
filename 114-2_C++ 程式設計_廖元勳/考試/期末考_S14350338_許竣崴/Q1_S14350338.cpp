#include <bits/stdc++.h>
using namespace std;

int main()
{
	int L;
	while (cin >> L and (L != 0))
	{
		int n;
		cin >> n;
		
		vector<int> C(n + 2);
		C[0] = 0;
		C[n+1] = L;
		for (int i = 1; i <= n; ++i)  { cin >> C[i]; }
		
		int dp[55][55];
		memset(dp, 0, sizeof(dp));
		
		for (int len = 2; len <= n + 1; len++)
		{
			for (int i = 0; i <= n + 1 - len; ++i)
			{
				int j = i + len;
				int ans = INT_MAX;
				
				for (int k = i + 1; k < j; ++k)
				{
					int temp;
					
					temp = dp[i][k];
					temp = temp + dp[k][j] + (C[j] - C[i]);
					
					ans = min(temp, ans);
				}
				dp[i][j] = ans;
			}
		}
		
		cout << "The minimum cutting is " << dp[0][n + 1] << "." << endl;
	}
	
}
