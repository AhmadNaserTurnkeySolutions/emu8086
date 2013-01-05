.model small
.data
	string1	db	10	dup(' '),13,10, '$'

.code

	mov ax, @data
	mov ds, ax
	
	lea si, string1
	
	mov ah, 1
READ_NEXT:
	int 21h
	cmp al, 13
	je NEXT
	mov [si], al
	inc si
	jmp READ_NEXT
	
NEXT:
	mov al, '$'
	mov [si], al
	dec si
	
	lea di, string1
	int 21h
BEG:

	mov al, [di]
	mov bl, [si]
	mov [di], bl
	mov [si], al
	dec si
	inc di
	cmp di, si
	jl BEG
	
	mov ah,9h
	lea dx, string1
	int 21h


mov ax,4c00h
int 21h
	end