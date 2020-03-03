#include "stdio.h"
  
unsigned long hash(unsigned char *str)
{
  unsigned long hash = 5381;
  int c;
  while (c = *str++) {
    hash = ((hash << 5) + hash) + c; /* hash * 33 + c */
    printf("%lu\n", hash);
  }

  return hash;
}

int main(int argc, char* argv[])  
{
  unsigned long res;
  res = hash("abc");
  printf("%lu\n", res);
  return 0;
}

