#include <bits/stdc++.h>
using namespace std;

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

        // cost[r][c][d]：到達 (r,c) 且方向為 d 的最少轉彎數
        // d: 0=左, 1=下, 2=右
        vector<vector<array<int, 3>>> cost(n, vector<array<int, 3>>(m, {INT_MAX, INT_MAX, INT_MAX}));

        // 起點 (0, b)，初始朝下 (dir=1)
        cost[0][b][1] = 0;

        deque<tuple<int, int, int>> dq;
        dq.push_back(make_tuple(0, b, 1));

        while (!dq.empty())
        {
            tuple<int, int, int> state = dq.front();
            dq.pop_front();

            int r = get<0>(state);
            int c = get<1>(state);
            int d = get<2>(state);

            int cur = cost[r][c][d];

            // ─────────────────────────────────────
            // 列出所有可以走的 (nr, nc, 新方向, 費用)
            // ─────────────────────────────────────

            if (d == 0)  // 目前朝左
            {
                // 繼續朝左，費用 0
                int nr = r;
                int nc = c - 1;
                int nd = 0;
                int w  = 0;
                if (nr >= 0 && nr < n && nc >= 0 && nc < m && !blocked[nr][nc])
                {
                    if (cur + w < cost[nr][nc][nd])
                    {
                        cost[nr][nc][nd] = cur + w;
                        if (w == 0)  { dq.push_front(make_tuple(nr, nc, nd)); }
                        else         { dq.push_back(make_tuple(nr, nc, nd)); }
                    }
                }

                // 轉成朝下，費用 1
                nr = r + 1;
                nc = c;
                nd = 1;
                w  = 1;
                if (nr >= 0 && nr < n && nc >= 0 && nc < m && !blocked[nr][nc])
                {
                    if (cur + w < cost[nr][nc][nd])
                    {
                        cost[nr][nc][nd] = cur + w;
                        if (w == 0)  { dq.push_front(make_tuple(nr, nc, nd)); }
                        else         { dq.push_back(make_tuple(nr, nc, nd)); }
                    }
                }
            }
            else if (d == 1)  // 目前朝下
            {
                // 繼續朝下，費用 0
                int nr = r + 1;
                int nc = c;
                int nd = 1;
                int w  = 0;
                if (nr >= 0 && nr < n && nc >= 0 && nc < m && !blocked[nr][nc])
                {
                    if (cur + w < cost[nr][nc][nd])
                    {
                        cost[nr][nc][nd] = cur + w;
                        if (w == 0)  { dq.push_front(make_tuple(nr, nc, nd)); }
                        else         { dq.push_back(make_tuple(nr, nc, nd)); }
                    }
                }

                // 轉成朝左，費用 1
                nr = r;
                nc = c - 1;
                nd = 0;
                w  = 1;
                if (nr >= 0 && nr < n && nc >= 0 && nc < m && !blocked[nr][nc])
                {
                    if (cur + w < cost[nr][nc][nd])
                    {
                        cost[nr][nc][nd] = cur + w;
                        if (w == 0)  { dq.push_front(make_tuple(nr, nc, nd)); }
                        else         { dq.push_back(make_tuple(nr, nc, nd)); }
                    }
                }

                // 轉成朝右，費用 1
                nr = r;
                nc = c + 1;
                nd = 2;
                w  = 1;
                if (nr >= 0 && nr < n && nc >= 0 && nc < m && !blocked[nr][nc])
                {
                    if (cur + w < cost[nr][nc][nd])
                    {
                        cost[nr][nc][nd] = cur + w;
                        if (w == 0)  { dq.push_front(make_tuple(nr, nc, nd)); }
                        else         { dq.push_back(make_tuple(nr, nc, nd)); }
                    }
                }
            }
            else  // 目前朝右 (d == 2)
            {
                // 繼續朝右，費用 0
                int nr = r;
                int nc = c + 1;
                int nd = 2;
                int w  = 0;
                if (nr >= 0 && nr < n && nc >= 0 && nc < m && !blocked[nr][nc])
                {
                    if (cur + w < cost[nr][nc][nd])
                    {
                        cost[nr][nc][nd] = cur + w;
                        if (w == 0)  { dq.push_front(make_tuple(nr, nc, nd)); }
                        else         { dq.push_back(make_tuple(nr, nc, nd)); }
                    }
                }

                // 轉成朝下，費用 1
                nr = r + 1;
                nc = c;
                nd = 1;
                w  = 1;
                if (nr >= 0 && nr < n && nc >= 0 && nc < m && !blocked[nr][nc])
                {
                    if (cur + w < cost[nr][nc][nd])
                    {
                        cost[nr][nc][nd] = cur + w;
                        if (w == 0)  { dq.push_front(make_tuple(nr, nc, nd)); }
                        else         { dq.push_back(make_tuple(nr, nc, nd)); }
                    }
                }
            }
        }

        int ans = min(cost[n-1][e][0], min(cost[n-1][e][1], cost[n-1][e][2]));
        cout << ans << '\n';
    }

    return 0;
}