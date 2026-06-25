#include <iostream>
#include <algorithm>
#include <vector>
using namespace std;

int main()
{
    int n;  
    while (cin >> n and n != 0)
    {
	    vector<int> v(n);
	    for (int i = 0; i < n; ++i)  { cin >> v[i]; }
    	
    	sort(v.begin(), v.end(), less<int>());
	    for (int i = 0; i <= n - 2; ++i)  { cout << v[i] << " "; }
	    cout << v[n-1] << "\n";
    }

    return 0;
}