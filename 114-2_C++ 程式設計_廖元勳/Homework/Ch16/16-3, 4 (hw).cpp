#include <iostream>
#include <string>
using namespace std;

class Animal 
{
  private:
    string name;
    int age;

  public:
    Animal(string n = "animal", int a = 0) : name(n), age(a) {}

    void showInfo()
    {
        cout << name << ", age: " << age << endl;
    }
};

class Dog : public Animal 
{
  public:
    Dog(string n = "puppy", int a = 0) : Animal(n, a) {}
};

class Cat : public Animal 
{
  public:
    Cat(string n = "kitty", int a = 0) : Animal(n, a) {}
};


int main()
 {
    Animal animal("animal", 1); 
    Dog dog("Dog", 3);
    Dog mydog;
    Cat cat("Cat", 5);

	animal.showInfo();
    dog.showInfo();
    mydog.showInfo();
    cat.showInfo();
    
    return 0;
}