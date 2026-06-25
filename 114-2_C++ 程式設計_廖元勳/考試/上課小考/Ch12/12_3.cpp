#include <iostream>
using namespace std;

class Employee 
{
	// 題解程式碼
};

int main() 
{
	/*
		程式碼第二題 line 11 ~ 24
	*/
    
    string name;
    cout << "請輸入欲搜尋的員工姓名：";  cin >> name;
    cout << "\n\n";
    
    bool is_found = false;
    for (int i = 0; i < n; ++i)
    {
		if (A[i].Ename == name)
		{
			A[i].PrintData();
			is_found = true;
			break;
		}
    }
    if (!is_found)
    {
    	cout << "找不到員工！\n";
    }
    
    delete[] A;

    return 0;
}