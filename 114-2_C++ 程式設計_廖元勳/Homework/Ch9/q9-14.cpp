#include <iostream>
using namespace std;

void square(int *arr)
{
	for (int i = 0; i < 5; ++i)
	{
		// 使用指標算術並解引用
		*(arr + i) = *(arr + i) * *(arr + i);
	}
}

int main()
{
	int arr[5] = {1, 2, 3, 4, 5};
	
	cout << "陣容內容為";
	for (int i = 0; i < 5; ++i)  { cout << " " << arr[i]; }
	cout << "\n";
	
	square(arr);
	
	cout << "將每個元素平方，結果為";
	for (int i = 0; i < 5; ++i)  { cout << " " << arr[i]; }
	cout << "\n";

	return 0;
}
