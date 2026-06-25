#include <iostream>
#include <climits>
using namespace std;

int cuts[] = {0, 4, 5, 7, 8, 10};

int Solve(int l, int r)
{
	if (r - l <= 1)  return 0;
	
	int length = cuts[r] - cuts[l];
	int least = INT_MAX;
    
    for (int k = l + 1; k < r; ++k)
    {
    	int cost = length + Solve(l, k) + Solve(k, r);
        least = min(least, cost);
    }
    
    return least;
}

int main()
{
	cout << Solve(0, 5);
	
	
	return 0;
}
