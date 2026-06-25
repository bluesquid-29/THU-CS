#include <iostream>
using namespace std;

class CWin 
{
  private:
    char id;
    int width, height;

  public:
    CWin(char i, int w, int h) : id(i), width(w), height(h) {}

    int area()
    {
    	return width * height; 
    }

    // 1.
    bool operator<(CWin& win) 
    {
        return this->area() < win.area();
    }

    // 2. and 3.
    bool operator<(const int& x) 
    {
        return this->area() < x;
    }
};

int main() 
{
    CWin win1('A', 70, 80);  // area = 5600
    CWin win2('B', 60, 90);  // area = 5400

    // 1.
    if (win1 < win2)  { cout << "win2 is larger than win1" << endl;  }
    else              { cout << "win1 is larger than win2" << endl;  }

    // 2.
    if (win1 < 7000)  { cout << "win1 is smaller than 7000" << endl; }
    else              { cout << "win1 is larger than 7000" << endl;  }

    // 3.
    if (win2 < 4500)  { cout << "win2 is smaller than 4500" << endl; }
    else              { cout << "win2 is larger than 4500" << endl;  }

    return 0;
}