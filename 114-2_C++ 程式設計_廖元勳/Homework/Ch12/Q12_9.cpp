#include <iostream>
using namespace std;

class Cal_Rect 
{
private:
    int width;
    int height;
    double weight;

public:
    // (a) 可設定長方形的重量
    void set(double wg) 
    {
        weight = wg;
    }

    // (b) 可設定長方形的寬和高
    void set(int w, int h) 
    {
        width = w;
        height = h;
    }

    // (c) 可設定長方形的重量、寬和高
    void set(double wg, int w, int h) 
    {
        weight = wg;
        width = w;
        height = h;
    }

    // 輸出
    void show(string name) 
    {
        cout << "object " << name   << ":" << "\n";
        cout << "height=" << height        << "\n";
        cout << "width="  << width         << "\n";
        cout << "weight=" << weight        << "\n\n";
    }
};

int main() 
{
    Cal_Rect rectA;

    // 模擬第一次
    rectA.set(5, 3);       // 使用 (b)
    rectA.set(2.6);        // 使用 (a)
    rectA.show("A");

    // 模擬第二次
    rectA.set(3.8, 6, 10); // 使用 (c)
    rectA.show("A");

    return 0;
}