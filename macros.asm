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

ModoCalculadora macro ;Macro para modo calculadora
    Imprimir menucalc
    Imprimir ingnum
    EntradaTeclado
    Imprimir ingop
    EntradaTeclado
    ciclo:
        Imprimir ingnum
        EntradaTeclado
        Imprimir ingopfin
        EntradaTeclado
        mov bl,al
        cmp bl,";"
        jne ciclo
        Imprimir menres
        Imprimir mensave
        EntradaTeclado
        mov bl,al
        cmp bl,"s"
        jne saven
        ClearScreen
        Imprimir mensaves
        jmp fin
    saven:
        ClearScreen
        Imprimir mensaven
    fin:

endm