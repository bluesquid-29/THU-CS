#include <iostream>
#include <algorithm>
#include <vector>
using namespace std;

int main()
{
	int N, M;
	int testcase = 1;
	
	while (cin >> N >> M and (N != 0 and M != 0))
	{
		vector<int> N1(N + 1);
		for (int i = 1; i <= N; ++i)  { cin >> N1[i]; }
		vector<int> N2(M + 1);
		for (int i = 1; i <= M; ++i)  { cin >> N2[i]; }
		vector<vector<int>> DP(N + 1, vector<int>(M + 1, 0));
		
		// LCS algorithm
		for (int i = 1; i <= N; ++i)
			for (int j = 1; j <= M; ++j)
			{
				if (N1[i] == N2[j])  { DP[i][j] = DP[i - 1][j - 1] + 1; }
				else                 { DP[i][j] = max(DP[i - 1][j], DP[i][j - 1]); }
			}
			
		cout << "Twin Towers #" << testcase++ << "\n";
		cout << "Number of Tiles : " << DP[N][M] << "\n\n";
	}
	
	return 0;
}