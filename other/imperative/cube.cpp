https://powcoder.com
代写代考加微信 powcoder
Assignment Project Exam Help
Add WeChat powcoder
https://powcoder.com
代写代考加微信 powcoder
Assignment Project Exam Help
Add WeChat powcoder
#include <iostream>
using namespace std;

int cube(int* p, int n) {
  *p = (n - 1) * (n - 1) * (n - 1);
  return n * n * n;
}

int main() {
  int input;
  cin >> input;
  int result2;
  int result1 = cube(&result2, input);
  cout << result1 << " " << result2 << endl;
  return 0;
}
