#include <iostream>
using namespace std;

class coord 
{
  private:
    int x;
    int y;

  public:
    // (b) 建構子，預設座標為 (0,0)
    coord(int i = 0, int j = 0) : x(i), y(j) {}

    // (a) 印出座標
    void show() 
    {
        cout << "(" << x << "," << y << ")" << endl;
    }

    // (c) 多載「+」運算子：傳回匿名物件
    coord operator+(coord const& b) 
    {
        return coord(this->x + b.x, this->y + b.y);
    }

    // 多載「-」運算子：傳回新物件 temp
    coord operator-(coord const& b)
    {
        coord temp;
        temp.x = this->x - b.x;
        temp.y = this->y - b.y;
        
        return temp;
    }

    // 多載「=」運算子：為了連鎖賦值，必須傳回 *this 的 reference
    coord& operator=(coord const& b) 
    {
        this->x = b.x;
        this->y = b.y;
        
        return *this; // 傳回自己本人（reference）
    }
};

int main() 
{
    coord c0(1, 1);
    coord c1(2, 2); 
    coord c2;
    coord c3;

    cout << "c0=";     c0.show();
    cout << "c1=";     c1.show();

    c2 = c0 + c1;
    cout << "c0+c1=";  c2.show();

    c3 = c0 - c1;
    cout << "c0-c1=";  c3.show();

    return 0;
}