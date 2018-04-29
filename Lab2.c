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
char op[50]=" ";
char *d=NULL;
  int i = 0;
int p=0;
pid_t pid, pid2, pid3;
 pid=fork();
 if (pid==0) { /* child process */
        static char *argv[]={"a.out",NULL};
        execv("a.out",argv);
        exit(127); /* only if execv fails */
    }
    else { /* pid!=0; parent process */
        waitpid(pid,0,0); /* wait for child to exit */
    }
FILE *file;
FILE *f = fopen("arguments.txt", "w");
FILE *u = fopen("operands.txt" ,"w");
file = fopen("dash.c", "r");
if (file) {
    while ((c = getc(file)) != EOF)
if(c=='=') {
putchar('\t');
fprintf(u,"=");
} else if (c=='+'){
 putchar('\t');
fprintf(u,"+");
}
else if (c=='-'){
 putchar('\t');
fprintf(u,"-");
}
else if (c=='/'){
putchar('\t');
fprintf(u,"/");
}
else if (c=='*'){
putchar('\t');
fprintf(u,"*");
}
else if (c=='>'){
 putchar('\t');
fprintf(u,">");
}
else if (c=='>='){
 putchar('\t');
fprintf(u,">=");
}
else if (c=='<'){
putchar('\t');
fprintf(u,"<");
}
else if (c=='<='){
 putchar('\t');
fprintf(u,"<=");
}
else if (c==':='){
 putchar('\t');
fprintf(u,":=");
}
else if (c=='&&'){
 putchar('\t');
fprintf(u,"&&");
}
else if (c=='||'){
 putchar('\t');
fprintf(u,"||");
}
else if (c=='!='){
 putchar('\t');
fprintf(u,"!=");
}
else if (c=='%'){
 putchar('\t');
fprintf(u,"%");
}
else {
putchar(c);
op[p]=c;
p++;
}
fprintf(f,"%s\n",op);

    fclose(file);
fclose(f);
fclose(u);
  
}
//Pass 2(Convert to Bin, output asm file)
pid2=fork();
 if (pid2==0) { /* child process */
        static char *argv[]={"Lab2pt2.c",NULL};
        execv("Lab2pt2.c",argv);
        exit(127); /* only if execv fails */
    }
    else { /* pid!=0; parent process */
        waitpid(pid,0,0); /* wait for child to exit */
    }
pid3=fork();
 if (pid3==0) { /* child process */
        static char *argv[]={"Lab2pt3.c",NULL};
        execv("Lab2pt3.c",argv);
        exit(127); /* only if execv fails */
    }
    else { /* pid!=0; parent process */
        waitpid(pid,0,0); /* wait for child to exit */
    }

}
