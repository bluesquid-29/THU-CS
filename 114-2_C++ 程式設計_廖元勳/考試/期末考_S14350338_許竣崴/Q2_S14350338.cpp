#include <bits/stdc++.h>
using namespace std;

// DFS


int main()
{
	int n; 
	while (cin >> n and n != 0)
	{
		int graph[n][n];
		memset(graph, 0, sizeof(graph));
		
		int m;
		cin >> m;
		
		for (int i = 0; i < m; ++i)
		{
			int A, B;
			cin >> A >> B;
			graph[A][B] = graph[B][A] = true;
		}
		
		for (int i = 0; i < n; ++i)
		{
			for (int j = 0; j < n; ++j)
			{
				cout << graph[i][j] << " ";
			}
			cout << endl;
		}
		cout << endl;
		
		
		// int k = 1;
		// for (int i = 0; i < k; ++i)
		// {
// 			
		// }
	}
	
	

	return 0;
}
