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
        cout << name << ", age: " << age << "\t";  
    }

    void makeSound()
    {
        cout << "Animal sound" << endl;
    }
};

class Dog : public Animal 
{
  public:
    Dog(string n = "puppy", int a = 0) : Animal(n, a) {}

    void makeSound()
    {
        cout << "Woof!" << endl;
    }
};

class Cat : public Animal 
{
  public:
    Cat(string n = "kitty", int a = 0) : Animal(n, a) {}

    void makeSound()
    {
        cout << "Meow!" << endl;
    }
};

int main()
{
    Animal animal("animal", 1); 
    Dog dog("Dog", 3);
    Cat cat("Cat", 5);

    animal.showInfo();  animal.makeSound();
    dog.showInfo();     dog.makeSound();
    cat.showInfo();     cat.makeSound();
    
    return 0;
}