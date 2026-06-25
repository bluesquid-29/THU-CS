#include <iostream>
using namespace std;

class Student
{
  public:
  	string name;
  	int chinese;
	int english;
  	int math;
  	
  	Student(string s, int c, int e, int m)
  	: name(s), chinese(c), english(e), math(m){}
  	
	void swapWith(Student* other) 
	{
	    // 暫存對方的成績
	    int temp1 = other->chinese;
	    int temp2 = other->english; 
	    int temp3 = other->math;
	    
	    // 把自己的給對方
	    other->chinese = this->chinese;
	    other->english = this->english;
	    other->math    = this->math;
	    
	    // 把暫存的給自己
	    this->chinese = temp1;
	    this->english = temp2;
	    this->math    = temp3;
	}
	
	void printScore()
	{
		cout << name << "的國文、英文、數學成績依序為" 
		     << chinese << ", " << english << ", " << math << endl;
	}
  	
};

int main()
{	
	Student A("彼得", 100, 58, 81);
	Student B("瑪莉", 53, 78, 99);
	
	A.printScore();
	B.printScore();
	
	A.swapWith(&B);
	cout << "\n彼得與瑪莉的成績互換後：\n" << endl;
	
	A.printScore();
	B.printScore();
	
	return 0;
}