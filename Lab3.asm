	org	100h
section	.data
MSG1: 	db	"Please enter a decimal number: $"
MSG2: 	db	0Dh,0Ah, "The number in octal is:    $"
MSG3: 	db	0Dh,0Ah, "The number in decimal is:    $"

section .text
	mov	ah,9		; print prompt
	mov	dx,MSG1
	int 	21h
	call	dec_in		; read value into bx
	mov	ah,9		; print output label
	mov	dx,MSG2
	int 	21h	
	;call	octout
	mov	ah,9		; print output label
	mov	dx,MSG3
	int 	21h
	call	dec_out		; display the value as decimal
exit:
	mov	ax,4C00h	; exit
	int	21h		

dec_in: 
	push	ax
	push	dx
	
	xor	bx,bx		; bx holds input
	mov	ah,1		; read char
	int	21h		; read it
while1: 
	cmp	al,0Dh		; is char a CR
	je	done		; if so jump
	push	ax		; save character
	mov	ax,10		; multiply
	mul	bx		; multiply
	mov	bx,ax		; put resultin bx
	pop	ax		; restore char
	and	ax,000Fh	; convert '0'-'9' to  0-9
	add	bx,ax		; add value input
	mov	ah,1		; read char
	int	21h		; read into al
	jmp	while1		; loop
done:	
	pop	dx
	pop	ax
	ret
	
dec_out:
	push	ax
	push	bx
	push	cx
	push	dx
		
	xor	cx,cx		; set cx to 0
doagain:
	mov	ax,bx		; divide by 10
	xor	dx,dx		; get dividend
	mov	bx,10		; bx holds divisor
	div	bx		; quotient in ax, remainder in dx
	push	dx		; push
	inc	cx		
	mov	bx,ax		; quotient in bx
	cmp	ax,0		; test if quotient is zero
	jne	doagain		; if not next digit
		
	mov	ah,2		; display character function
for2:				; loop cx times
	pop	dx		; get digit
	or	dl,30h		; convert the digit to ASCII
	int	21h		; display
	loop	for2		; continue untill all digits displayed
		
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	ret
	 	
;octout:
;********************************************************************************************************************************
; I know WHAT to do, just not HOW to implement it. I attempted to take the 16 bit binary number, and shift it to the left by three,
; as an octal number is only three bits. I do it 6 times, because it is a 16 bit number. The I mask out all but the three bits to be
; converted with an and operation. I then use an or operation to convert the 3 digit binary to ascii 0-7 to display. Like I said, I 
; know what to do, just not how to implement it. 
	 ;save registers we will be using
	;push	ax
	;push	cx
	;push	dx
	;mov	ah,2		; display char fcn
	;mov	cx,6		; loop counter init
;for1:				; top of for loop
	;rol	bx,3		; rotate so digit is in lowest 3 bits
	;and	bl,0000000000000111B		;  and mask out all but 3 bits
	;or	dl,0000000000000111B		; convert 0-7 to '0'-'7'
	;jmp	endif1		; get ready to display
;endif: int	21h		; display char
	;loop	for1		; loop until done
	 ;restore registers
	;pop	dx
	;pop	cx
	;pop	ax
	;ret
