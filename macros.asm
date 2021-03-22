ClearScreen macro   ;Clears the screen
  mov  ah, 0
  mov  al, 3
  int  10H
endm
PrintText macro Text    ;Prints "Text"
    mov ax,@data
    mov ds,ax
    mov ah,09h
    lea dx,Text
    int 21h
endm
PrintRegister macro Register    ;Prints "Register"
    xor ax,ax
    mov dl,Register
    mov ah,02h
    int 21h
endm
EnterOption macro   ;Read input for options
    mov ah,01   ;Input mode
    int 21h     ;Input mode
endm
Print16 macro Regis ;Print a 16bit number
    local zero,noz
    mov bx,4
    xor ax,ax
    mov ax,Regis
    mov cx,10
    zero:
        xor dx,dx
        div cx
        push dx
        dec bx
        jnz zero
        xor bx,4
    noz:
        pop dx
        PrintN dl
        dec bx
        jnz noz
endm
PrintN macro Num    ;Print a digit
    xor ax,ax
    mov dl,Num
    add dl,48
    mov ah,02h
    int 21h
endm
ReadText macro buffer   ;Reads input text
    local read  ;Read mode
    local fin   ;End of number
    xor si,si   ;Clear si
    read:
        mov ah,1    ;Input mode
        int 21h     ;Input mode
        cmp al, 13  ;Compare if input is "ENTER"
        je fin   ;If input is "ENTER" go to fin
        mov buffer[si],al   ;Save input into buffer position si
		inc si  ;Increment counter si
        jmp read    ;Read next input
    fin: ;End of number
        mov al,00h
		mov buffer[si],al   ;Save inout into buffer position si
endm
TextToDecimal macro buffer, des ;Converts text to decimal
    Local start
    Local fin
    Local negative
    Local positive
    Local done
    Local negate
	xor ax,ax   ;Clears ax registry
	xor bx,bx   ;Clears bx registry
	xor cx,cx   ;Clears cs registry
	xor di,di   ;Clears di resistry, 0 = Positive, 1 = Negative
	mov bx,10	;Moves 10 into bx
	xor si,si   ;Clears si registry, for counter of position inside buffer
	start:
		mov cl,buffer[si]   ;Move buffer in position si into cl
		cmp cl,45   ;Compares if cl is "-"
		je negative ;If cl is "-" jump to negative
		jmp positive    ;If cl is not "-" jump to positive
	negative:
		inc di  ;Increment di to 1, now the number is negative
		inc si  ;Increment si by 1 to read next value
		mov cl,buffer[si]   ;Move the next value into cl
	positive:
		cmp cl,48   ;Compares if cl is 0
		jl fin  ;Jump to negate
		cmp cl,57   ;Compares if cl is 9
		jg fin  ;Jump to negate
		inc si  ;Increment si to read next value
		sub cl,48	;Substract 48 to cl to get number
		mul bx		;Multiply ax by bx
		add ax,cx	;Add to ax cx
		jmp start   ;Jump to start
	fin:
		cmp di,1    ;Compares if di = 1
		je negate   ;Go to negate to negate ax
		jmp done    ;If di = 0 go to done
	negate:
		neg ax  ;Negates ax
	done:
        mov des,ax  ;Moves register ax into des, which is output
endm
DecimalToText macro entrada, salida ;Converts decimal to text
    Local divide
    Local divide2
    Local make
    Local negative
    Local done
    xor ax,ax   ;Clear ax
    mov ax,entrada  ;Move number into ax
	xor si,si   ;Clear si
	xor cx,cx   ;Clear cx
	xor bx,bx   ;Clear bx
	xor dx,dx   ;Clear dx
	mov bx,0ah  ;Move 10 into bx
	test ax,1000000000000000    ;Compare if ax is negative
	jnz negative    ;If ax is negative go to negative
	jmp divide2 ;if ax is positive go to divide2
	negative:
		neg ax  ;Negate ax to make it positive
		mov salida[si],45   ;Move a "-" at the start of text
		inc si  ;Increment counter si
		jmp divide2    ;Go to divide 2
	divide:
		xor dx,dx   ;Clear dx
	divide2:
		div bx  ;divide ax by bx
		inc cx  ;Increment counter cx
		push dx ;Push dx register into stack
		cmp ax,00h  ;Campre if ax is 0
		je make ;IF ax is 0 go to make
		jmp divide  ;If ax is not 0 go to divide
	make:
		pop ax  ;Take out last register from stack
		add ax,30h  ;Make conversion
		mov salida[si],ax   ;Move ax into salida position si
		inc si  ;Increment counter si
		loop make ;Loop to make
		mov ax,24h  ;Move $ to ax
		mov salida[si],ax   ;Move ax into salida position si
		inc si  ;Increment si
	done:
		;PrintText salida    ;Display result
endm
;MACROS FOR MODO CALCULADORA***************************************************************
ModoCalculadora macro   ;Enters "Modo Calculadora"
    ;Loops used only in Modo Calculadora
    local operate
    local loop
    local loop2
    local saves
    local saven
    local saven2
    local addition
    local substract
    local multiply
    local divide
    local fin
    local err
    ;Modo Calculadora begins
    ClearScreen
    PrintText calcmenu
    PrintText promptnum
    ReadText number1 ;Save number1
    TextToDecimal number1, number1n
    PrintText promptop
    EnterOption
    mov ch,al   ;Save operand into ch
    PrintText promptnum
    ReadText number2 ;Save number2
    operate:    ;Label to check which operation to perform
        cmp ch,"+"  ;Compare if ch is +
        jne substract   ;If ch is not h jump to substract
        jmp addition    ;Jump to addition
    loop:
        PrintText promptcont
        EnterOption
        mov ch,al
        cmp ch,";"  ;Compare if ch is ;
        jne loop2   ;ch is not ; so jump to loop2
        PrintText mesres   ;ch is ; so it continues
        PrintText resultado
        PrintText messave
        EnterOption
        mov bl,al
        cmp bl,"s"  ;Compare if bl is s
        jne saven   ;bl is not s so jump to saven
        jmp saves   ;bl is s no jump to saves
    loop2:
        PrintText promptnum
        ReadText number2
        jmp operate
    saves:  ;Operation is saved
        ClearScreen
        PrintText messavey
        jmp fin ;Jumps to fin
    saven:  ;Operation is not saved
        cmp bl,"S"  ;Compare if bl is S
        jne saven2  ;bl is not S so jump to saven2
        ClearScreen
        PrintText messavey
        jmp fin ;Jumps to fin
    saven2:
        ClearScreen
        PrintText messaven
        jmp fin ;Jumps to fin
    addition:
        MCAdd
        jmp loop   ;Jumps to loop
    substract:
        cmp ch,"-"  ;Compares if ch is -
        jne multiply    ;ch is not - so jump to multiply
        MCSubstract
        jmp loop   ;Jumps to loop
    multiply:
        cmp ch,"*"  ;Compares if ch is *
        jne divide  ;ch is not * so jumpt to divide
        MCMultiply
        jmp loop    ;Jumps to loop 
    divide:
        cmp ch,"/"  ;Compares if ch is /
        jne err ;ch is not / so jump to err
        MCDivide
        jmp loop    ;Jumps to loop
    err:
        ClearScreen
        PrintText meserr
    fin:    ;Exits Modo Calculadora
endm
MCAdd macro
    TextToDecimal number2, number2n
    mov bx, number2n    ;Move number2n into bx
    add number1n, bx    ;Add bx to number1n
    DecimalToText number1n, resultado
    ;PrintText mesadd
    ;PrintText resultado
endm
MCSubstract macro
    TextToDecimal number2, number2n
    mov bx, number2n    ;Move number2n into bx
    sub number1n, bx    ;Substract bx to number1n
    DecimalToText number1n, resultado
    ;PrintText messub
    ;PrintText resultado
endm
MCMultiply macro
    TextToDecimal number2, number2n
    mov bx, number2n    ;Move number2n into bx
    mov ax, number1n    ;Move number1n into ax
    imul bx ;Multiply ax by bx
    mov number1n, ax    ;Move ax into number1n
    DecimalToText number1n, resultado
    ;PrintText mesmul
    ;PrintText resultado
endm
MCDivide macro
    TextToDecimal number2, number2n
    xor dx,dx   ;Clear dx
    mov bx, number2n    ;Move number2n into bx
    mov ax, number1n    ;Move number1n into ax
    cwd ;Convert word to doubleword
    idiv bx ;Divide ax by bx
    mov number1n, ax    ;Move ax into number1n
    DecimalToText number1n, resultado
    ;PrintText mesdiv
    ;PrintText resultado
endm
;******************************************************************************************