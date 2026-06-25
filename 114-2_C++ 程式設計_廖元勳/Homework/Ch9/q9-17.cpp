#include <iostream>
#include <string>
#include <cctype>
using namespace std;

int main()
{
	cout << "Input source string: ";
	string s;
	getline(cin, s);
	
	cout << "Before process...\n";
	cout << "string = " << s << "\n\n";
	
	// 宣告一個字元指標 p，並指向字串 s 的 第一個字元（index 0）
	char *p = &s[0];
	while (*p != '\0')
	{
		*p = toupper(*p);
		p++;
	}
	
	cout << "After process...\n";
	cout << "string = " << s << "\n";
	
	return 0;
}
