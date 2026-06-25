for (int i = 1; i <= N; ++i)
	for (int j = 1; j <= M; ++j)
	{
		if (N1[i] == N2[j])  { DP[i][j] = DP[i - 1][j - 1] + 1; }             // green
		else                 { DP[i][j] = max(DP[i - 1][j], DP[i][j - 1]); }  // orange
	}