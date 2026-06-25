#include <iostream>
using namespace std;

class Employee 
{
	// 題解程式碼
};

int main() 
{
	int n;  
	cout << "請輸入員工人數：";  cin >> n;
    Employee *A = new Employee[n];
    
    for (int i = 0; i < n; ++i)
    {
    	cout << "第 " << (i + 1) << " 位員工姓名：";
    	cin >> A[i].Ename;
    	
    	cout << "第 " << (i + 1) << " 位員工薪資：";
    	int x;  cin >> x;
    	A[i].SetSalary(x);
    }
    cout << "\n\n";
    
    for (int i = 0; i < n; ++i) 
    { 
    	A[i].PrintData(); 
    }
    delete[] A;
    
    return 0;
}