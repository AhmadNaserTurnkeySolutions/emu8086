 .MODEL small
.STACK 100
.DATA 

		filename db 'input.txt',0	
		handle dw 0 
		buffer db 255 DUP ?  
.CODE 
MOV AX,@DATA 
MOV DS,AX 

		mov ah,3Dh  
		mov al,0  
		mov dx,offset filename  ; make a pointer to the filename
		int 21h 
		mov handle,ax 

	

		mov ah,3Fh
		mov cx,255  
		mov dx,offset buffer 
		mov bx,handle  
		int 21h  



		mov dx,offset buffer
		add dx,ax  
			
		mov bx,dx
		mov byte [bx],'$'  
            
               mov cl,20
               mov bl,1   
               
            
                   call TL
            return:  
        
            lea si,buffer 
            
              

           set:  
            mov al,[si] 

            call moving1      
            cmp al,'a'
            jge changeLetter

           inc si 
           dec cl
           

           
           jnz set      
        
                jz endpro

           changeLetter:
           cmp bl,1
           je changeMe 
            inc si 
             
           dec cl 
          
           jnz set
             
		             
		   changeMe:
		 
		 
		   mov al,[si]
		   sub al,32d  
		   mov [si],al
		   mov bl,0

		    inc si 
         
		   jnz set      
		    
		     
	         
		  
moving1: 
cmp al,' '

je incr
 ret
incr:
mov bl,1  

   ret
		  
		
		

   
TL:
lea si,buffer

lower:
mov al,[si]
cmp al,60h
jg inc_di_lo
cmp al,40h
jl inc_di_lo
add al,20h
mov [si],al
inc si
jmp lower
inc_di_lo:
inc si
cmp al,'$'
je return
jmp lower    
  
 
 
 endpro:

		mov dx,offset buffer  ; put the pointer back in DX.
		mov ah,9
		int 21h    ; call DOS Function 9 (Print String).
		mov ah,4Ch
		int 21h      ; Function 4Ch (Exit Program)      
   
		end