;ASSIGNMENT 3

    org 100h

section .data

prompt1 db  0dh, 0ah, 0dh, 0ah, "Please input a signed base-10 integer: $"
prompt2 db  0dh, 0ah, "Your number in binary is: $"
prompt3 db  0dh, 0ah, "Pretty sure that wasn't a number. Please enter a number value. $"
prompt4 db  0dh, 0ah, "Your number in octal is: $"

section .text

START:
    mov ah, 9       ;Display input prompt
    mov dx, prompt1 
    int 21h

    mov bx, 0       ;Get input
    mov ah, 1
    int 21h

DEC_IN: 
    cmp al, 0dh     ;compare input to carriage return; check if user is finished
    je  DEC_OUT     ;if yes, go display the prompt
    cmp al, '0'     ;compare to '0'
    jg  IS_DIGIT    ;jump to IS_DIGIT to confirm that it is a number
    jl  NAN_ERROR   ;if below 0, print error prompt and start over

IS_DIGIT:
    cmp al, '9'     ;confirms digit value
    jl  BIN_CONV    ;if digit, convert to binary
    jg  NAN_ERROR   ;if not, print 'not a number' error message

BIN_CONV:
    and ax,000Fh    ; convert from ASCII to base 10 value
    push    ax      ; and save it on stack
    mov ax,10       ; set up to multiply bx by 10
    imul    bx      ; dx:ax = bx*10
    pop bx      ; saved value in bx
    add bx,ax       ; bx = old bx*10 + new digit 

    mov ah,1        ; input char function
    int 21h     ; read next character
    jmp DEC_IN      ; loop until done



NAN_ERROR:
    mov ah, 9       ;display error message
    mov dx, prompt3
    int 21h

    jmp START       ;Go back to beginning

DEC_OUT:
    mov ah, 9       ;Display the signed decimal value
    mov dx, prompt2
    int 21h

    mov cx, 16
    TOP:    rol bx,1        ; rotate msb into CF
        jc  ONE     ; CF = 1?
        mov dl,'0'      ; no, set up to print a 0
        jmp print       ; now print
    ONE:    mov dl,'1'      ; printing a 1
    print:  mov ah,2        ; print char fcn
        int 21h     ; print it
    loop    TOP     ; loop until done

    mov ah, 2       ;Display decimcal value in bx
    mov dl, bl
    int 21h

    jmp EXIT

EXIT:
    mov ah,04ch     ;DOS function: exit
    mov al,0        ;exit code
    int 21h     ;call DOS, exit