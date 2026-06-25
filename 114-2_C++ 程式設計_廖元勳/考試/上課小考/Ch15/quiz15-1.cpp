#include <iostream>
using namespace std;

class Point 
{
  private:
    int x;
    int y;

  public:
    Point(int i = 0, int j = 0) : x(i), y(j) {}
    
    void show() 
    {
        cout << "座標->x座標: " << x << "\t y座標:" << y << endl;
    }


    Point operator+(Point const& b) 
    {
        return Point(this->x + b.x, this->y + b.y);
    }
    
    Point operator+(int const& b) 
    {
        return Point(this->x + b, this->y + b);
    }
    
    Point& operator++() 
    {
        this->x += 1;
        this->y += 1;
        
        return *this;
    }

    Point& operator=(Point const& b) 
    {
        this->x = b.x;
        this->y = b.y;
        
        return *this;
    }
};

int main() 
{
    Point p1(10, 20);
    Point p2(15, 23); 
    Point p3; 

	cout << "obj1"; p1.show();
	cout << "obj2"; p2.show();
	cout << "obj3"; p3.show();
	

    p3 = p1 + p2;
    cout << "\n" << "p1+p2=p3" << endl;
    cout << "p3"; p3.show();
    
    p3 = p3 + 6;
    cout << "\n" << "p3+6" << endl;
    cout << "p3"; p3.show();
    
    ++p3;
    cout << "\n" << "++p3" << endl;
    cout << "p3"; p3.show();

    return 0;
}