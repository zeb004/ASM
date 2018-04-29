org 100h
section .data
MSG1    dw  "Enter a base 10 number: ", '$'
MSG2    dw  "The number is: ", '$'
EMSG    dw  "The octal number is", '$'

section .text
main:
; print user prompt 
mov     dx, MSG1    ; get message
mov     ah, 09h     ; display string function
int     21h         ; display it
jmp     DEC_IN

DEC_IN:
CLD	;Incrementing direction
; input character from keyboard, converts ASCII to appropriate binary, stores into respective memory location
mov     ah, 01h     ; keyboard input function
int     21h         ; character input, copies character into al
cmp     al, 0Dh             ;Did he hit the return key ?
je      DEC_OUT          ;Yes, now we can go on
Stosb			 ; put byte in the buffer
jne DEC_IN    ;He's not done, so keep on



DEC_OUT:
mov	bh, al
sub	bh, '0'
mov	ah, 09h
mov	dx, MSG2
int	21h
mov	dl, bh
mov	ah, 09h
int	21h
jmp	exit
         
 exit:
 mov     ah, 04Ch      ; DOS function: Exit program 
  mov     al, 0         ; Return exit code value
 int     21h           ; Call DOS. Terminate program 



