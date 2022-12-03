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

int fac(int n) {
  int result = n;
  if (n >= 2) {
    result = n * fac(n - 1);
  }
  return result;
}

int main() {
  int n = 7;
  int result = fac(n);
  cout << n << "! = " << result << endl;
  return 0;
}

