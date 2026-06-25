#include <iostream>
#include <vector>
#include <string>
#include <set>
#include <algorithm>

using namespace std;

// 使用 set 自動去重並排序結果
set<string> allLCS;

void findAllLCS(int i, int j, string& s1, string& s2, vector<vector<int>>& DP, string current) {
    // 當其中一個字串索引回到 0，表示找到一個組合
    if (i == 0 || j == 0) {
        reverse(current.begin(), current.end());
        allLCS.insert(current);
        return;
    }

    // 1. 若字元相同，此字元必在 LCS 中，往左上方回溯
    if (s1[i - 1] == s2[j - 1]) {
        findAllLCS(i - 1, j - 1, s1, s2, DP, current + s1[i - 1]);
    } 
    else {
        // 2. 若不同，檢查上方格子的值是否等於目前格子的值
        if (DP[i - 1][j] == DP[i][j]) {
            findAllLCS(i - 1, j, s1, s2, DP, current);
        }
        // 3. 檢查左方格子的值是否等於目前格子的值
        if (DP[i][j - 1] == DP[i][j]) {
            findAllLCS(i, j - 1, s1, s2, DP, current);
        }
    }
}

int main() {
    string N1 = "ORANGES";
    string N2 = "GARDENS";
    int N = N1.length();
    int M = N2.length();

    // 初始化 DP 表
    vector<vector<int>> DP(N + 1, vector<int>(M + 1, 0));

    // 你的核心 DP 邏輯
    for (int i = 1; i <= N; ++i) {
        for (int j = 1; j <= M; ++j) {
            if (N1[i - 1] == N2[j - 1]) { 
                DP[i][j] = DP[i - 1][j - 1] + 1; 
            } else { 
                DP[i][j] = max(DP[i - 1][j], DP[i][j - 1]); 
            }
        }
    }

    // 開始回溯找出所有字串
    findAllLCS(N, M, N1, N2, DP, "");

    // 輸出結果
    cout << "LCS 長度: " << DP[N][M] << endl;
    cout << "所有可能的 LCS 組合:" << endl;
    for (const string& s : allLCS) {
        if (!s.empty()) cout << "- " << s << endl;
    }

    return 0;
}
