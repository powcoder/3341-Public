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

long squareroot(long x) {
  long i;
  for (i = 0; ; i++) {
    if (i * i > x) {
      break;
    }
  }
  return i - 1;
}

int main(int argc, char** argv) {
  
  long x = atol(argv[1]);

  cout << x << " " << squareroot(x) << endl;

  return 0;
}

