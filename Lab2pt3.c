#include <stdio.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h> /* for fork */
#include <sys/types.h> /* for pid_t */
#include <sys/wait.h> /* for wait */
#define max 500
main() {
int c;
int i;
int j;
int ch;
int cz;
FILE *f = fopen("opcode.asm", "r");
FILE *f2 = fopen("operand.asm", "r");
FILE *f3 = fopen("operandFormat.asm", "r");
FILE *f4 = fopen("RUNME.asm", "w");
unsigned char buffer[17];
unsigned char buffer2[17];
        int read=0;
        while((read=fread(&buffer,16,1,f2)) >0)
        {

            for(i=0; i < 16; i++)
            {
                fprintf(f3,"%c", buffer[i]);
            }

           
            
            fprintf(f3,"\n");
        }
while((read=fread(&buffer,16,1,f)) >0 && (read=fread(&buffer2,16,1,f3)>0))
        {

            for(i=0; i < 16; i++)
            {
                fprintf(f4,"%c%c", buffer[i],buffer2[i]);
            }

           
            
            fprintf(f4,"\n");
        }
   
 
    fclose(f);

}
