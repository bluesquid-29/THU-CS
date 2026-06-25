#include <iostream>
#include <string>
using namespace std;

class CCar 
{
  private:
    string id;
    int quantity;
    int price;
    int sale;

  public:
    // (a) 成員函數 set_data
    void set_data(string i, int q, int p) 
    {
        id = i;
        quantity = q;
        price = p;
        sale = q * p;
    }

    void show() 
    {
        cout << "車款: " << id << ", "
             << "銷售數量 " << quantity << " 台, "
             << "單價=" << price << " 萬元, "
             << "銷售額=" << sale << " 萬元" << endl;
    }
};

int main() 
{
    CCar car1;
    CCar car2;

    car1.set_data("ix M60", 3, 638);
    car2.set_data("x5 M Sport", 5, 392);
    
    car1.show();
    car2.show();

    return 0;
}
