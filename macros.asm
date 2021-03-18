Imprimir macro Cadena ;Macro para imprimir "Cadena" en la pantalla
    mov ax,@data
    mov ds,ax
    mov ah,09h
    lea dx,Cadena
    int 21h
endm
ClearScreen macro ;Macro para limpiar pantalla
  mov  ah, 0
  mov  al, 3
  int  10H
endm
EntradaTeclado macro ;Macro para entradas en el teclado
    mov ah,01
    int 21h
endm
ReadInteger macro;Leer un numero
    mov ah,1    ;Modo entrada
    int 21h     ;Modo entrada
endm
PrintRegistro macro Num ;Macro para imprimir un registro
    xor ax,ax
    mov dl,Num
    mov ah,02h
    int 21h
endm
ModoCalculadora macro ;Macro para modo calculadora
    Imprimir menucalc
    Imprimir ingnum;Ingresar numero
    ReadInteger
    mov bl,al;Almacenar el primer valor
    Imprimir ingop;Ingresar operacion
    EntradaTeclado
    mov ch,al;Almacenar el operador
    Imprimir ingnum;Ingresar segundo numero
    ReadInteger
    mov cl,al;Alamcenar el segundo valor
    operar:;Realizar operacion
        cmp ch,"+"
        jne resta
        jmp suma
    ciclo:
        Imprimir ingopfin
        EntradaTeclado
        mov ch,al
        cmp ch,";"
        jne ciclo2
        Imprimir menres
        Imprimir mensave
        EntradaTeclado
        mov bl,al
        cmp bl,"s"
        jne saven
        jmp saves
    ciclo2:
        Imprimir ingnum
        ReadInteger
        mov cl,al;Alamcenar el segundo valor
        jmp operar
    saves:;Se guarda la operacion
        ClearScreen
        Imprimir mensaves
        jmp fin
    saven:;No se guarda la operacion
        ClearScreen
        Imprimir mensaven
        jmp fin
    suma:;El operador es una suma
        add al,bl
        mov ah,0
        aaa
        mov bx,ax
        add bh,48
        add bl,48
        Imprimir mensum
        mov ah,2
        mov dl,bh
        int 21h;Imprime el primer digito
        mov ah,2
        mov dl,bl
        int 21h;Imprime el segundo digito
        jmp ciclo
    resta:;El operador es una resa
        cmp ch,"-"
        jne mult
        Imprimir menresta
        jmp ciclo
    mult:;El operador es una multiplicacion
        cmp ch,"*"
        jne division
        Imprimir menmul
        jmp ciclo
    division:;El operador es una division
        cmp ch,"/"
        jne err
        Imprimir mendiv
        jmp ciclo
    err:
        ClearScreen
        Imprimir menerror
    fin:;finaliza el modo calculadora

endm