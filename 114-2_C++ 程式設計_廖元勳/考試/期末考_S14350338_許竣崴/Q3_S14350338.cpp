#include <bits/stdc++.h>
using namespace std;

int main()
{
	int n; 
	int q;
	while (cin >> n >> q and !(n == 0))
	{
		vector<int> list(n + 1);
		for (int i = 1; i <= n; ++i)  { cin >> list[i]; }
		
		while (q--)
		{
			int ai, aj;
			cin >> ai >> aj;
			
			int temp = list[ai];
			int temp_cnt = 1;
			int max_cnt = 1;
			for (int i = ai; i <= aj - 1; ++i)
			{	
				if (list[i + 1] == temp)
				{
					temp_cnt++;
					max_cnt = max(max_cnt, temp_cnt);
				}
				else if (list[i + 1] != temp)
				{
					temp = list[i + 1];
					temp_cnt = 1;
					max_cnt = max(max_cnt, temp_cnt);
				}
			}
			cout << max_cnt << endl;
		}
		cout << endl;
	}
	
	return 0;
}
