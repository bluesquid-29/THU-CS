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
    // (b) 宣告友誼函數與多載
    friend void set_data(CCar& car, string i, int q, int p);

    void show() 
    {
        cout << "車款: " << id << ", "
             << "銷售數量 " << quantity << " 台, "
             << "單價=" << price << " 萬元, "
             << "銷售額=" << sale << " 萬元" << endl;
    }
};

void set_data(CCar& car, string i, int q, int p)
{
    car.id = i;
    car.quantity = q;
    car.price = p;
    car.sale = q * p;
}

int main() 
{
    CCar car1, car2;

    set_data(car1, "ix M60", 3, 638);
    set_data(car2, "x5 M Sport", 5, 392);
    
    car1.show();
    car2.show();

    return 0;
}
