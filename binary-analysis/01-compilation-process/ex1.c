#include <stdio.h>
#include <string.h>

int 
factorial(int n){
  int i;
  int r=1;
  for(i=2; i<=n; i++){
    r=r*i;
  }
  return r;
}

int 
main(void){
  int number=5;
  int result;
  printf("%d%s", number, "! is equal to ");
  result=factorial(number);
  printf("%d\n", result);
}

