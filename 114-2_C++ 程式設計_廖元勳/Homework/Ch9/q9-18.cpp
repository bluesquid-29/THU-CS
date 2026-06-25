#include <iostream>
#include <string>
#include <cctype>
using namespace std;

int main()
{
	cout << "請輸入一個字串：";
	string s;
	getline(cin, s);
	
	// 宣告一個字元指標 p，並指向字串 s 的 第一個字元（index 0）
	char *p = &s[0];
	while (*p != '\0')
	{
		if (*p == ' ')  { *p = '*'; }
		p++;
	}
	
	cout << "替換後的字串 = " << s << "\n";

	return 0;
}
