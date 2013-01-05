.model small
.stack 100h
.data
original db "elmo.txt",0
result db "result.txt",0
handler dw ?
original_text db 250 dup('$') 
result_text db 250 dup('$')
lowerMSG db 0dh,0ah,'PROGRAM FOR CONVERT UPPER & LOWER CASE ..$'
    upperMSG db 0dh,0ah,'Do you want to LOWER(1) or UPPER(2) CASE ? : $'
;lowerMSG db 10,13,' to convert the text into lower case',10,13,'$'
;upperMSG db 10,13,'2: to convert the text into upper case',10,13,'$'
inMSG db 10,13,'Converting data from original.text file',10,13,'$'
successMSG db 10,13,'Converting done succesfully',10,13,'You can see the results in "result.txt" file$'
len dw 0
.code 
 
 
mov ax,@data 
mov ds,ax 
 
mov ah,3dh ; read a file 
mov al,02 
lea dx,original ; the address of file name should be in dx 
int 21h 
mov handler,ax    ;file handle is returned in ax 
 
mov si,0 
mov bx,handler
start:
mov ah,3fh         ; the file handle 
mov cx,1         ; number of bytes to be read 
lea dx,original_text+si     ; the address of data to be read 
int 21h 
cmp ax,0 
je print_option
inc si 
jmp start 
 
 
print_option:
mov len,si
mov ah,09h
lea dx,inMSG
int 21h
 
lea dx,lowerMSG
int 21h
 
lea dx,upperMSG
int 21h
 
option:
mov ah,1
int 21h 
mov bl,al
mov ah,2
mov dl,10
int 21h
 
cmp bl,'1'
je to_lower
cmp bl,'2'
je to_upper
jmp option
 
 
to_lower:
lea dx,result_text
mov di,0
mov si,0
lea bx,original_text
mov ah,2
lower:
mov dl,[bx+di]
cmp dl,'$'
je write_to_file
cmp dl,60h
jg inc_di_lo
cmp dl,40h
jl inc_di_lo
add dl,20h
mov [result_text+si],dl
inc di
inc si
jmp lower
inc_di_lo:
mov [result_text+si],dl
inc di
inc si
mov dl,[bx+di]
cmp dl,'$'
je write_to_file
jmp lower  
 
 
to_upper:
lea dx,result_text
mov di,0
mov si,0
lea bx,original_text
upper:
mov dl,[bx+di]
cmp dl,60h
jg inc_di_up
mov [result_text+si],dl
inc di
inc si
mov al,'$'
cmp al,[bx+di]
jne upper
jmp write_to_file
inc_di_up:
sub dl,20h
mov [result_text+si],dl
inc di
inc si
mov al,'$'
cmp al,[bx+di]
jne upper
jmp write_to_file 
 
write_to_file:
mov ah,3ch ; create a file
mov cx,0 ; normal attributes
lea dx,result ; the address of file name should be in dx
int 21h
mov handler,ax ;file handle is returned in ax , store it we need it later
mov ah,40h ; write to file
mov bx,handler ; the file handle
mov cx,len ; number of bytes to be written
 
lea dx,result_text ; the address of data to be written should be in dx
int 21h
 
mov ah,3eh
int 21h
 
exit:
mov ah,09h
lea dx,successMSG
int 21h
mov ah,4ch
int 21h
end