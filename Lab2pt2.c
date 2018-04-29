#include <stdio.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h> /* for fork */
#include <sys/types.h> /* for pid_t */
#include <sys/wait.h> /* for wait */
#define max 500
main() {
 char str[max];
  int c;
int y;
char op[50]=" ";
char *d=NULL;
  int i = 0;
int p=0;
FILE *file = fopen("operands.txt", "r");
FILE *f = fopen("opcode.asm", "w");
if (file) {
    while ((c = getc(file)) != EOF)
if(c=='=') {
fprintf(f,"00000000000");
fprintf(f,"01001\r");
p++;
} else if (c=='+'){
fprintf(f,"00000000000");
fprintf(f,"00001\n");
p++;
}
else if (c=='-'){
fprintf(f,"00000000000");
fprintf(f,"00010\n");
p++;
}
else if (c=='/'){
fprintf(f,"00000000000");
fprintf(f,"00100\n");
p++;
}
else if (c=='*'){
fprintf(f,"00000000000");
fprintf(f,"00011\n");
p++;
}
else if (c=='>'){
fprintf(f,"00000000000");
fprintf(f,"01010\n");
p++;
}
else if (c=='>='){
fprintf(f,"00000000000");
fprintf(f,"01011\n");
p++;
}
else if (c=='<'){
fprintf(f,"00000000000");
fprintf(f,"01100\n");
p++;
}
else if (c=='<='){
fprintf(f,"00000000000");
fprintf(f,"01101\n");
p++;
}
else if (c==':='){
fprintf(f,"00000000000");
fprintf(f,"01110\n");
p++;
}
else if (c=='&&'){
fprintf(f,"00000000000");
fprintf(f,"01000\n");
p++;
}
else if (c=='||'){
fprintf(f,"00000000000");
fprintf(f,"00111\n");
p++;
}
else if (c=='!='){
fprintf(f,"00000000000");
fprintf(f,"00110\n");
p++;
}
else if (c=='%'){
fprintf(f,"00000000000");
 fprintf(f,"00101\n");
op[p]=c;
p++;
}
else {
op[p]=c;
p++;
}
}
int h;
printf("%s\n",op);
FILE *file1 = fopen("arguments.txt", "r");
FILE *f2 = fopen("operand.asm", "w");
if (file1) {
 while ((c = getc(file1)) != EOF)
 for(h=8;h>=0;h--) {
  y=c>>h;
if(y&1) 
fprintf(f2,"1");
else
 fprintf(f2,"0");
}
fprintf(f2,"\n");


}


fclose(file1);
fclose(f);
}

