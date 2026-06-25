#include <iostream>
using namespace std;

class Calculator 
{
  public:
    int    add(int a, int b)       { return a + b; }
    int    sub(int a, int b)       { return a - b; }
    int    mul(int a, int b)       { return a * b; }
    double div(double a, double b) { return a / b; }
};

int main() 
{
    Calculator cal;
    int a = 3, b = 6;
    
    cout << "a=" << a << ", b=" << b << "\n";
    cout << "二數之和= " << cal.add(a, b) << "\n";
    cout << "二數之差= " << cal.sub(a, b) << "\n";
    cout << "二數之積= " << cal.mul(a, b) << "\n";
    cout << "二數之商= " << cal.div(a, b) << "\n";
    
    return 0;
}