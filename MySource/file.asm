 .MODEL small
.STACK 256
.DATA 

		filename db 'elmo.txt',0	
		handle dw 0   ; will be the file handle. the number that DOS assigns to the open file.
		buffer db 255 DUP ?  ; make a plain buffer (not a strange input one like before).
.CODE 
MOV AX,@DATA 
MOV DS,AX 

		mov ah,3Dh   ; 3Dh of DOS Services opens a file.
		mov al,0   ; 0 - for reading. 1 - for writing. 2 - both
		mov dx,offset filename  ; make a pointer to the filename
		int 21h   ; call DOS
		mov handle,ax   ; Function 3Dh returns the file handle in AX, here we save it for later use.

	;'DOS Service Function number 3Fh reads from a file.

		mov ah,3Fh
		mov cx,255   ; I will assume ELMO.TXT has atleast 4 bytes in it. CX is how many bytes to read.
		mov dx,offset buffer  ; DOS Functions like DX having pointers for some reason.
		mov bx,handle    ; BX needs the file handle.
		int 21h   ; call DOS

	;Here we will put a $ after 4 bytes in the buffer and print the data read:

		mov dx,offset buffer
		add dx,ax    ; Function 3Fh returns the actual amount of bytes read in AX (should be 4 if
				; nothing went wrong.
		mov bx,dx
		mov byte [bx],'$'   ; byte pointer so we don't mess with the whole word (a word is 16bits).
            
               mov cl,20
               mov bl,1
            lea si,buffer
            label:  
            mov al,[si] 
            mov dl,al
            mov ah,2h
            int 21h
            call moving1      
            cmp al,'a'
            jge changeLetter
           
           inc si 
           dec cl
           
           
           jnz label
                jz Print
           ;;;;;;;;;;;;;;;;;
           changeLetter:
           cmp bl,1
           je changefirst  
            inc si 
           dec cl
           jnz label
           ;;;;;;;;;;;;;;;;       
		             
		   changefirst:
		   inc si  
		 
		   mov al,[si]
		   sub al,32d  
		   mov [si],al
		   mov bl,0
		   
		   dec si 
		    inc si 
           dec cl
		   jnz label       
		     ;ret                
		     
	Print:

		mov dx,offset buffer  ; put the pointer back in DX.
		mov ah,9
		int 21h    ; call DOS Function 9 (Print String).
		mov ah,4Ch
		int 21h      ; Function 4Ch (Exit Program)               
		  
moving1: 
cmp al,' '

je increment
 ret
increment:
mov bl,1  

   ret
		end