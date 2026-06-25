#include <iostream>
using namespace std;

struct Info
{
	string name;
	int ID;
	int gender;
	union
	{
		bool has_served;
		int typing_speed;
	};
};

int main()
{
    Info employee;
      
    cout << "姓名: ";             getline(cin, employee.name);
    cout << "人事代號: ";          cin >> employee.ID;
    cout << "性別 (1)男 (2)女: ";  cin >> employee.gender;
	if      (employee.gender == 1) { cout << "是否役畢 (1)是 (0)否: ";    cin >> employee.has_served;   }
	else if (employee.gender == 2) { cout << "每分鐘中打速度: ";          cin >> employee.typing_speed; }
	
	cout << "姓名: " << employee.name << "\n";    
	cout << "人事代號: " << employee.ID << "\n";    
	if      (employee.gender == 1) { cout << "是否服役: "      << employee.has_served << "\n";   }
	else if (employee.gender == 2) { cout << "每分鐘中打速度: " << employee.typing_speed << "\n"; }
	
    return 0;
}
