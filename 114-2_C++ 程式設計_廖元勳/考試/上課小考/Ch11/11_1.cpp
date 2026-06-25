#include <iostream>
#include <string>
using namespace std;

struct Person 
{
    string ID;
    string name;
    int salary;

    struct Birthday
    {
        int year;
        int month;
        int day;
    } birth;
};

int main()
{
	Person A;
	cout << "身份證號碼：";               cin >> A.ID;
	cout << "姓名：";                    cin >> A.name;
	cout << "薪水：";                    cin >> A.salary;
	cout << "生日（YYYY MM DD）：";       cin >> A.birth.year >> A.birth.month >> A.birth.day;


	cout << A.name << "先生的身份證是 " << A.ID << " ，";
	cout << "薪水是 " << A.salary << " ，";
	cout << "生日是 " << A.birth.year << "/" << A.birth.month << "/" << A.birth.day << "\n";
	
	return 0;
}
