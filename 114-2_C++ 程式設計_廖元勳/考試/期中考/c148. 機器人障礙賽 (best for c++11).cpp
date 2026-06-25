#include <iostream>
#include <algorithm>
#include <climits>
#include <array>
#include <vector>
#include <deque>
using namespace std;

enum Direction
{ 
	LEFT = 0,
	DOWN, 
	RIGHT
};

struct State 
{
    int r;  // row
    int c;  // col
    int d;  // direction (0:left, 1:down, 2:right)

    State(int row, int col, int dir) : r(row), c(col), d(dir)
    {
    	
    }
};

int main()
{
    int n, m;
    while (cin >> n >> m) 
    {
        int b, e;
        cin >> b >> e;

        int k;
        cin >> k;

        vector<vector<bool>> blocked(n, vector<bool>(m, false));
        for (int i = 0; i < k; i++)
        {
            int x, y;
            cin >> x >> y;
            blocked[x][y] = true;
        }

        // turn[r][c][d]：到達 (r,c) 且方向為 d 的最少轉彎數
        vector<vector<array<int, 3>>> turn(n, vector<array<int, 3>>(m, {INT_MAX, INT_MAX, INT_MAX}));

        // 起點 (0, b)，初始朝下
        turn[0][b][DOWN] = 0;

        deque<State> dq;
        dq.push_back(State(0, b, 1));

        while (!dq.empty())
        {
            State current = dq.front();
            dq.pop_front();

            int r        = current.r;
            int c        = current.c;
            int d        = current.d;
            int cur_cost = turn[r][c][d];
            
			auto Try_Move = [&](int nr, int nc, int nd, int new_cost)
			{
			    if ((0 <= nr and nr < n) and (0 <= nc and nc < m) and !blocked[nr][nc]) 
			    {
			        if (cur_cost + new_cost < turn[nr][nc][nd]) 
			        {
			            turn[nr][nc][nd] = cur_cost + new_cost;
			            State next(nr, nc, nd);
			            new_cost == 0 ? dq.push_front(next) : dq.push_back(next);
			        }
			    }
			};            

			switch (d) 
			{
			    case LEFT:
			        Try_Move(r    , c - 1, LEFT , 0);
			        Try_Move(r + 1, c    , DOWN , 1);
			        break;
			    case DOWN:
			        Try_Move(r + 1, c    , DOWN , 0);
			        Try_Move(r    , c - 1, LEFT , 1); 
			        Try_Move(r    , c + 1, RIGHT, 1);
			        break;
			    case RIGHT:
			        Try_Move(r    , c + 1, RIGHT, 0);
			        Try_Move(r + 1, c    , DOWN , 1);
			        break;
			}
		}
		
        int ans = min({turn[n-1][e][LEFT], turn[n-1][e][DOWN], turn[n-1][e][RIGHT]});
        cout << ans << "\n";
    }

    return 0;
}
/*          根據當前方向決定可以走的下一步，分別有幾種選擇，如水滲透一般：
            若目前朝左
            	1. 繼續朝左 (費用 0)
            	2. 轉成朝下 (費用 1)
            若目前朝下
                1. 繼續朝下 (費用 0)
                2. 轉成朝左 (費用 1)
                3. 轉成朝右 (費用 1)
            若目前朝右
                1. 繼續朝右 (費用 0)
                2. 轉成朝下 (費用 1)*/