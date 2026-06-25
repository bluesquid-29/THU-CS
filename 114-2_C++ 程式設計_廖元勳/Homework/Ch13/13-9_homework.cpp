#include <iostream>
using namespace std;

class CSale 
{
  private:
    char id;
    int quantity;
    int price;
    int sale;
    
  public:
    // 建構子
    CSale(char i, int q, int p) : id(i), quantity(q), price(p), sale(q * p) 
    {
    	// 沒有其他的事要做，空白
    }
    
    char Get_id()     { return id; }

    // (a) 印出產品資訊
    void show() 
    {
        cout << "產品 " << id << ": "
             << "銷售數量=" << quantity << " 個, "
             << "單價=" << price << " 元, "
             << "銷售額=" << sale << " 元" << endl;
    }

    // (b) compare() 函數：已指向物件的指標為引數，印出銷售額較高的產品。
    void compare(CSale* other)
    {
    	if (this->sale > other->sale) { cout << "產品 " << this->id  << " 的銷售額較高" << endl;} 
        else                          { cout << "產品 " << other->id << " 的銷售額較高" << endl;}
    }

    // (c) few() 函數：該函數的傳回值是指向銷售額較少物件之參照
    CSale& few(CSale& other) 
    {
        if (sale < other.sale)  { return *this; } 
        else                    { return other; }
    }
};

int main() 
{
    CSale a('A', 10, 34699);
    CSale b('B', 12, 40400);

    cout << "(a)" << endl;
    a.show();
    b.show();

    cout << "\n(b)" << endl;
    a.compare(&b);

    cout << "\n(c)" << endl;
    cout << "產品 " << (a.few(b)).Get_id() << " 的銷售額較少" << endl;

    return 0;
}