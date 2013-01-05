.model small
.stack 100
.data
   my_arr db 4, 2, 8, 9, 1, 7, 3, 0, 4, 6
    arr_idx db 1 0
    size db 10
   ; ----------------------------
   ; | bubble_sort
   ; |     sort an array whose pointer pointed by arr_idx
   ; | modifies:
   ; |     none
   ; | algorithm outline:  (when size = 10)
   ; |     for i = 0 to 8
   ; |        for j = i+1 to 9
   ; |            if arr_idx[i]>arr_idx[j] then swap(arr_idx[i], arr_idx[j]);
   ; |
   ; |  i is mapped to SI
   ; |  j is mapped to DI
   ; |  bx hold the base array index
   ; |  ah, al is to aid processing
   ; |  cx is to hold the size
   ; ----------------------------    
   .code
   mov ax,@data
   mov ds,ax
         
         
         
 

   mov  dx, offset my_arr   
   ;mov ah,9h
  ; int 21h
   call bubble_sort    
   
 ;  mov dx,offset my_arr   
   

   ; After this call, the array my_arr is sorted

   mov  ax, 4c00h
   int  21h      
         
   proc bubble_sort
        pusha     ; save all registers
        mov bx,0
        mov   cx, 10
        dec   cx          ; because maximum index bound is always one less than
                          ; the size (i.e. when size is 10, the index is 0..9, not 1..10)
        sub   si, si
        sub   di, di

   @@loop_i:
    
        mov   di, si
        inc   di           ; j = i + 1  
               
        call printout      
       
        @@loop_j:
             mov   ah, [bx+si]  ; AH = arr_idx[i]
             mov   al, [bx+di]  ; AL = arr_idx[j]

             cmp   ah, al       ; if (arr_idx[i] <= arr_idx[j]) then no swap
             jle no_swap

             mov   [bx+si], al  ; else swap
             mov   [bx+di], ah   


       no_swap: 

             inc   di        ; (increase j)
             cmp   di, cx    ; (compare with bound)
             jbe   @@loop_j  ; if below or equal, then go to @@loop_j

        ; end of loop j

        inc  si        ; increment i
        cmp  si, cx    ; compare with bound  
             
        jb   @@loop_i  ; if below, then loop to @@loop_i


        popa      ; restore all registers
        ret
   endp
  
  proc printout
 mov al,[si-1]
                     add al,030h  
             mov dl,al
            ; sub al,48
Mov Ah,2
INT 21h 
ret
endp
   
end