#include <iostream>
#include <string>
#include <vector>
using namespace std;

struct CD
{
	string ID;
	string head;
	int cost;
};

void printCD(CD const& x) 
{
    cout << "ID: " << x.ID << " | Title: " << x.head << " | Price: $" << x.cost << "\n";
}

int main()
{
	CD input;
	vector<CD> A;
	
	cout << "==== CD 唱片登入作業 ====\n\n";
	for (int i = 0; i < 3; ++i)
	{ 
		cout << "第 " << i+1 << " 張唱片編號：";  cin >> input.ID;
		cout <<             "　　　　 CD抬頭：";  cin >> input.head;
		cout <<             "　　　　 售  價：";  cin >> input.cost;
		cout << "\n";
		A.push_back(input);
	}
	
	int n;
	cout << "1.查詢CD編號 2.單價由小到大排序 3.單價由大到小排序 4.查詢最小單價 5.查詢最大單價：";  cin >> n;
	
	auto cheaper = [](CD const& x, CD const& y) { return x.cost < y.cost; };
	auto pricier = [](CD const& x, CD const& y) { return x.cost > y.cost; };
	
	switch (n)
	{
		case 1: 
		{
            string searchID;
            cout << "請輸入要查詢的編號: "; cin >> searchID;
            bool is_found = false;
            for (auto const& item : A) 
            {
                if (item.ID == searchID) 
                {
                    printCD(item);
                    is_found = true;
                    break;
                }
            }
            if (!is_found)  { cout << "找不到該編號。\n"; }
            
            break;
        }
        case 2:
        {
            sort(A.begin(), A.end(), cheaper);
            for (const auto& item : A) printCD(item);
            
            break;
        }
        case 3:
        {
            sort(A.begin(), A.end(), pricier);
            for (const auto& item : A) printCD(item);
            
            break;
        }
        case 4: 
        {
            auto it = min_element(A.begin(), A.end(), cheaper);
            cout << "最小單價唱片："; printCD(*it);
            
            break;
        }
        case 5: 
        {
            auto it = max_element(A.begin(), A.end(), pricier);
            cout << "最小單價唱片："; printCD(*it);
            
            break;
        }
        default:
            cout << "無效選擇。\n";
	}

	return 0;
}
