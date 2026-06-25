#include <iostream>
using namespace std;

enum Month 
{
    Jan = 1, 
    Feb, 
    Mar, 
    Apr, 
    May, 
    Jun,
    Jul, 
    Aug, 
    Sep, 
    Oct, 
    Nov, 
    Dec
};

int main()
{
    cout << "請輸入欲查詢的月份(1~12): ";
    int n;  cin >> n;

    switch (n) 
    {
        case Jan:  cout << Jan << "月 = January";   break;
        case Feb:  cout << n << "月 = February";  break;
        case Mar:  cout << n << "月 = March";     break;
        case Apr:  cout << n << "月 = April";     break;
        case May:  cout << n << "月 = May";       break;
        case Jun:  cout << n << "月 = June";      break;
        case Jul:  cout << n << "月 = July";      break;
        case Aug:  cout << n << "月 = August";    break;
        case Sep:  cout << n << "月 = September"; break;
        case Oct:  cout << n << "月 = October";   break;
        case Nov:  cout << n << "月 = November";  break;
        case Dec:  cout << n << "月 = December";  break;
        default:   cout << "Error";              break;
    }
    cout << endl;

    return 0;
}
