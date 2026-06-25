#include <iostream>
#include <iomanip>
using namespace std;

struct Date
{
	int year;
	int month;
	int day;
};

int main()
{
    Date input;
    cout << "輸入年份 yyyy: ";  cin >> input.year;
    cout << "輸入月份 mm: ";    cin >> input.month;
    cout << "輸入日期 dd: ";    cin >> input.day;

	cout << setfill('0') << setw(2) << input.month << "/"
     	 << setfill('0') << setw(2) << input.day   << "/"
    	 << setfill('0') << setw(4) << input.year  << "\n";
	
    return 0;
}
