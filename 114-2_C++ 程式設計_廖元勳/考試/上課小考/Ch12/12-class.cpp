class Employee 
{
  private:
	int _salary;

  public:
    string Ename;
    
    void SetSalary(int x)
    {
    	if      (x < 20000)  {_salary = 20000; }
    	else if (x > 40000)  {_salary = 40000; }
    	else                 {_salary = x;     }
    }
    
    int GetSalary()
    {
    	return _salary;
    }
        
    void PrintData()
    {
    	cout << Ename << " 薪水 " << GetSalary() << "\n";
    }
};