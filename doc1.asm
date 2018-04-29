; program to do hexadecimal input and output
	org	100h
section	.data
prompt1: db	"Hello, my name is:  Zachary Beardmore. Prepare to enter data $"
prompt2: db	0Dh,0Ah, "Enter a Hex digit:    $"
prompt3: db	0Dh,0Ah, "The number in decimal is:    $"
prompt4: db     "Do you want to do it again Y or N?" 
prompt5: db	"This is not a hex number, try again"

start:
;intro
	mov	ah,9
	mov	dx,prompt1
	int	21h

hex:   
; print user prompt 
     mov    dx,prompt2    ; get message
     mov    ah,9           ; display string function
     int    21h           ; display it
     jmp    input          ; jumps to user input 
input:
; input a hexidecimal number then compare to ASCII
     mov    ah,1        ; keyboard input function
     int    21h         ; character input, copies character into al
     mov    bh,al       ; moves al into bh to avoid al being messed with
     cmp    bh,30       ; compares input to ASCII code for 0
      jl    error       ; if input is less than 0 jump to main
     cmp    bh,39       ; compares input to ASCII code for 9
     jle    print1      ; if input is less than or equal to 9 jump to print
     cmp    bh,41       ; compares input to ASCII code for 'A'
      jl    error       ; if input is less than 'A' jump to main
     cmp    bh,46       ; compares input to ASCII code for 'F'
     jle    convert1    ; if input is less than or equal to 'F' jump to convert1
     cmp    bh,61       ; compares input to ASCII code for 'a'
      jl    error       ; if input is less than 'a' jump to main
     cmp    bh,66       ; compares input to ASCII code for 'f'
     jle    convert2    ; if input is less than of equal to 'f' jump to convert2
      jg    error       ; if input is greater than 'z' jump to main
error:
; displays error message then jumps back
     mov    dx,prompt5    ; moves error message into display string register
     mov    ah,9        ; display string function
     int    21h         ; displays it
     jmp    input      ; jumps back to user input
convert1:
; converts input from hexadecimal A-F to decimal
     sub    bh,16      ; subtracts 0Fh from input to get decimal
     jmp    print2      ; jumps to print
convert2:
; converts input from hexidecimal a-f to decimal
     sub    bh,48      ; subtracts 30h from the input to get 
     jmp    print2      ; jumps to print
print1:
; prints the input in decimal form
     mov    dx,prompt3    ; moves MSG2 into display string register
     mov    ah,09      ; display string function
     int    21h        ; display MSG2 "In decimal it is:"
     mov    dl,bh      ; moves input into display character register
     mov    ah,02      ; display character function
     int    21h        ; display input in decimal form
     jmp    again      ; jumps to again
print2:
;prints the input in decimal form
     mov    dx,prompt3    ; moves MSG2 into display string register
     mov    ah,9        ; display string function
     int    21h         ; display MSG2 "In decimal it is:"
     mov    dl,49       ; will add 10 to the converted ASCII code
     mov    ah,2        ; display character function
     int    21h         ; display 1 in front of input in decimal form
     mov    ah,02       ; display character function
     int    21h         ; displays converted input
     jmp    again       ; jumps to again
again:
; asks if user wants to do it again
     mov    dx,prompt4    ; moves MSG2 into display string register
     mov    ah,09      ; display string function
     int    21          ; display MSG3 "Do you want to do it again?"
     mov    ah,01       ; keyboard input function
     int    21          ; character input, copies into al
     cmp    al,59       ; compares input to ASCII code for 'Y'
      je    hex        ; if input is equal to 'Y' jump to main
      jl    exit        ; if input is less than 'Y' jump to exit
     cmp    al,79      ; compares input to ASCII code for 'y'
      je    hex        ; if input is equal to 'y' jump to main 
     jne    exit        ; if input is not equal to 'y' jump to exit
exit:
;exit to DOS
      mov     ah,04Ch       ; DOS function: Exit program 
      mov     al,0          ; Return exit code value
      int     21h           ; Call DOS. Terminate program 
	
	
