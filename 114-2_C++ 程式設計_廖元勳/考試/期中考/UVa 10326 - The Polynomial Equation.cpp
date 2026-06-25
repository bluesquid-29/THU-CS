#include <iostream>
#include <array>
#include <vector>
using namespace std;
#define int long long

void Print_Term(int coef, int exp, bool is_first_term)
{
    if (!is_first_term)
    {
        if (coef >= 0)  { cout << " + "; }
        else            { cout << " - "; }
    }

    int val = abs(coef);
    if (exp == 0 or val != 1)  { cout << val; }
    if (exp > 0)
    {
        cout << "x";
        if (exp > 1)  { cout << "^" << exp; }
    }
}

signed main()
{
	int N;
    while (cin >> N)
    {
        vector<int> roots(N);
        for (int i = 0; i < N; ++i)  { cin >> roots[i]; }
	
		vector<vector<int>> dp(N + 1, vector<int>(N + 1, 0));	
		dp[0][0] = 1; // 代表 x^0 = 1 (我們從常數 1 開始乘)
		
		for (int i = 0; i < N; ++i)
		{
		    int r = roots[i];
		    for (int j = 0; j <= i + 1; ++j) 
		    {
		        int term_x = (j > 0) ? dp[i][j - 1] : 0;  // 乘以 x 的部分
		        int term_r = dp[i][j] * -r;               // 乘以 r 的部分
		        
		        dp[i + 1][j] = term_x + term_r;
		    }
		}
		
		// 輸出
	    bool is_first = true;
	    for (int i = N; i >= 0; --i)
	    {
	        if (i > 0 and dp[N][i] == 0)  { continue; }
	        Print_Term(dp[N][i], i, is_first);
	        is_first = false;
	    }
	    cout << " = 0\n";
	}
	
	return 0;
}
