#include <iostream>
#include <algorithm>
#include <vector>
using namespace std;

int main()
{
    int m;  cin >> m;
    vector<int> v(m);
    for (int i = 0; i < m; ++i)  { cin >> v[i]; }
    
    sort(v.begin(), v.end(), greater<int>());
    int a = v[0];
    int b = v[1];
    for (int i = 2; i < m; ++i)
    {
        if (a <= b)
        {
            a *= 10;
            a += v[i];
        }
        else
        {
            b *= 10;
            b += v[i];
        }
    }

    cout << a * b << "\n";

    return 0;
}