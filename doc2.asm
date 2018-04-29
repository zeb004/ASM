 org 100h
; hexadecimal to base 10 conversion
section .data
    prompt0    dw  "Hello, my name is:  Zachary Beardmore. Prepeare to enter data", '$'
    prompt1    dw  " Enter a hex digit ", '$'
    prompt2    dw  " The number in decimal is: ", '$'
    prompt3    dw  " Do you want to do it again? y or n", '$'
    prompt4    dw  " Not a hex character, try again: ", '$'
section .text

intro: 
;print intro
     mov     ah,09h	; display string function
     mov     dx,prompt0	   ; moves prompt0 for display
     int     21h        ; display prompt0
     jmp     main
main:   
; print prompt 
     mov    ah,09h      ; display string function
     mov    dx,prompt1    ; get prompt1 for display
     int    21h         ; display prompt1
     jmp    uinput      ; jumps to uinput
uinput:
; input a hex number then compare to ASCII
     mov    ah,01h     ; keyboard input function
     int    21h        ; copies character into al
     mov    bh,al      ; moves al into bh 
     cmp    bh,30h     ; compares input to 0
      jl    error      ; if input is less jump to main
     cmp    bh,39h     ; compares input to 9
     jle    print1     ; if input is less than or equal to jump to print
     cmp    bh,41h     ; compares input to 'A'
      jl    error      ; if input is less than jump to main
     cmp    bh,46h     ; compares input to 'F'
     jle    convert1   ; if input is less than or equal to jump to convert1
     cmp    bh,61h     ; compares input to 'a'
      jl    error      ; if input is less than jump to main
     cmp    bh,66h     ; compares input to 'f'
     jle    convert2   ; if input is less than or equal jump to convert2
      jg    error      ; if input is greater jump to main
error:
; display error
     mov    ah,09h      ; display string function
     mov    dx,prompt4    ; moves prompt4 for display
     int    21h         ; display prompt4
     jmp    uinput      ; jump to uinput
convert1:
; convert to decimal
     sub    bh,16      ; get decimal
     jmp    print2      ; jumps to print
convert2:
; convert to decimal
     sub    bh,48      ; subtracts 30h from the input
     jmp    print2      ; jumps to print
print1:
; print in decimal
     mov    ah,09h     ; display string function
     mov    dx,prompt2    ; moves prompt2 to display
     int    21h        ; display prompt2
     mov    dl,bh      ; moves input into display register
     mov    ah,02h     ; display character function
     int    21h        ; display input in decimal
     jmp    do_again       ; jumps to do_again
print2:
;print in decimal
     mov    ah,09h     ; display string function
     mov    dx,prompt2    ; moves prompt2 to display
     int    21h        ; display prompt2
     mov    dl,49      ; will add 10 to ASCII code
     mov    ah,02h     ; display character function
     int    21h        ; display character
     mov    dl,bh      ; moves converted input to display
     mov    ah,02h     ; display character function
     int    21h        ; displays converted input
     jmp    do_again       ; jumps to do_again
do_again:
; ask is again
     mov    ah,09h     ; display string function
     mov    dx,prompt3    ; moves prompt3 to display
     int    21h        ; display prompt3 
     mov    ah,01h     ; keyboard input function
     int    21h        ; character input, copies into al
     cmp    al,59h     ; compares input to 'Y'
      je    main       ; if equal to jump to main
      jl    exit       ; if less than jump to exit
     cmp    al,79h     ; compares input to 'y'
      je    main       ; if equal jump to main 
     jne    exit       ; if not equal jump to exit
exit:
;exit
      mov     ah,04Ch      ; DOS function: Exit program 
      mov     al,0         ; Return exit code value
      int     21h           ; Call DOS