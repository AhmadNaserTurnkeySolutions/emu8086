
        .MODEL SMALL
        .DATA

                MSG  DB 13,10, ' ENTER THE STRING :-----> :  $'
                MSG2 DB 13,10, ' YOUR STRING IS  :-----> :  $'
                STR1 DB  255 DUP('$')
               ; ONE  DB ?
               ; TWO  DB ?
          .CODE

BEGIN:
          MOV AX,@DATA
          MOV DS,AX

          LEA DX,MSG
          MOV AH,09H
          INT 21H

          LEA SI,STR1
          MOV AH,01H

READ proc
          INT 21H
          MOV [SI],AL
          INC SI
          CMP AL,13;;;;;;;;;;;cariage return = 0dh
        ;  JNE READ
        call READ
        ret
      READ  endp

;DISPLAY:

;          MOV AL,'$'
;          MOV [SI],AL

          LEA DX,MSG2
          MOV AH,09H
          INT 21H

          LEA DX,STR1
          MOV AH,09H
          INT 21H



;          MOV AH,4CH
;          INT 21h

        .EXIT  
END BEGIN 

;*************************************OUTPUT***************************

;ENTER THE STRING :-----> : SAMIR B PATEL

;YOUR STRING IS  :-----> : SAMIR B PATEL