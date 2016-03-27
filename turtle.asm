section	.text

global  turtle
turtle:
	push	ebp
	mov	ebp, esp
	push	ebx
	mov  	eax, [ebp+8] ;odczytuje pierwszy argument funkcji i sprawdzam co to jest za komenda
	mov 	ecx, 	1
	cmp	eax, 	ecx
	je	ustaw
	mov 	ecx, 	2
	cmp	eax, 	ecx
	je	podnies
	mov	ecx,	3
	cmp	eax,	ecx
	je	opusc
	mov	ecx,	4
	cmp	eax,	ecx
	je	naprzod
	mov	ecx,	5
	cmp	eax,	ecx
	je	obrot
	jmp	koniec2
ustaw:
	mov eax,	[ebp+12] ;biore x1
	mov ecx,	[ebp+20] ;podaje do rejestru wskaznik na strukture
	mov [ecx+8],	eax
	mov	eax,	[ebp+16] ;biore y1
	mov	[ecx+12],	eax
	jmp	koniec1
podnies:
	mov	eax,	255 ;bialy kolor
	mov	ecx,	[ebp+20] ;podaje do rejestru wskaznik na strukture
	mov	[ecx+16],	eax
	jmp	koniec1
opusc:
	mov	eax,	0 ;czarny kolor
	mov	ecx,	[ebp+20] ;podaje do rejestru wskaznik na strukture
	mov	[ecx+16],	eax
	jmp	koniec1
naprzod:
	mov 	eax, [ebp+12]
	CVTSI2SD	xmm0,	eax ;zapisuje dlugosc odcinka
	mov	eax,	[ebp+20] ;podaje do rejestru wskaznik na strukture
	MOVHPD	xmm1,	[eax+20] ;zapisuje wartosc sinusa
	MOVLPD	xmm1,	[eax+28] ;i cosinusa
	MOVDDUP	xmm3,	xmm0 ;kopiuje do rejestru podwojna dlugosc
	MULPD		xmm1,	xmm3 ;mnoze dlugosc prze sinus i cosinus
	CVTPD2DQ	xmm4,	xmm1 ;zaoraglam double do int
	MOVD		ecx,	xmm4
	MOVSHDUP	xmm5,	xmm4
	MOVD		edx,	xmm5
	add	ecx,	[eax+8]
	add	edx,	[eax+12]
	mov	ebx,	[eax+0]
	push	ebx
	mov	ebx,	[eax+16]
	push	ebx
	push	edx
	push	ecx
	mov	ebx,	[eax+12]
	push	ebx
	mov	ebx,	[eax+8]
	push	ebx
	call	WriteLine
	add	esp,	8
	pop    ecx
	pop    edx
	add esp,    8
	mov	eax,	[ebp+20]
	mov	[eax+8],	ecx
	mov	[eax+12],	edx
	jmp	koniec1
obrot:
	mov	eax,	[ebp+12]
	mov	ecx,	[ebp+20] ;podaje do rejestru wskaznik na strukture
	mov	[ecx+4],	eax
koniec1:
	mov	eax, 0
	pop	ebx
	pop	ebp
	ret
koniec2:
	mov	eax, 1
	pop	ebx
	pop	ebp
	ret

global	WriteLine
WriteLine:
	enter	40,0
	push	ebx
	mov	ebx,	0
	mov	[ebp-4],	ebx
	mov	[ebp-8],	ebx
	mov	[ebp-12],	ebx
	mov	[ebp-16],	ebx
	mov	[ebp-20],	ebx
	mov	[ebp-24],	ebx
	mov	[ebp-28],	ebx
	mov	[ebp-32],	ebx
	mov	[ebp-36],	ebx
	mov	[ebp-40],	ebx
	mov	eax,	[ebp+20]
    mov ecx,    [ebp+12]
	sub	eax,	ecx
	mov	[ebp-4],	eax
	mov	eax,	[ebp+8]
	mov ecx,    [ebp+16]
	sub	eax,	ecx
	mov	[ebp-8],	eax
	mov	eax,	[ebp-4]
	cmp	eax,	0
	jg	modulA
	neg	eax
	mov	[ebp-32],	eax
    jmp modul
modulA:
    mov eax,    [ebp-4]
    mov [ebp-32],   eax
modul:
	mov	eax,	[ebp-8]
	cmp	eax,	0
	jg	modulB
	neg	eax
	mov	[ebp-36],	eax
	jmp next
modulB:
    mov eax,    [ebp-8]
    mov [ebp-36],   eax
next:
	mov	eax,	[ebp-32]
	mov	ecx,	[ebp-36]
	cmp	eax,	ecx
	jg	AgreaterB
	jmp	BgreaterA
AgreaterB:
	mov	eax,	1
	mov	[ebp-12],	eax
	jmp	next1
BgreaterA:
	mov	eax,	-1
	mov	[ebp-12],	eax
next1:
	mov	eax,	[ebp-4]
	mov	ecx,	0
	cmp	eax,	ecx
	jl	Alesszero
	jmp	Agreaterzero
Alesszero:
	mov	eax,	-1
	mov	[ebp-24],	eax
	jmp	next2
Agreaterzero:
	mov	eax,	1
	mov	[ebp-24],	eax
next2:
	mov	eax,	[ebp-8]
	mov	ecx,0
	cmp	eax,	ecx
	jl	Blesszero
	jmp	Bgreaterzero
Blesszero:
	mov	eax,	-1
	mov	[ebp-28],	eax
	jmp	next3
Bgreaterzero:
	mov	eax,	1
	mov	[ebp-28],	eax
next3:
	mov	eax,	[ebp-16]
	mov	ecx,	[ebp+8]
	add	eax,	ecx
	mov	[ebp-16],	eax
	mov	eax,	[ebp-20]
	mov	ecx,	[ebp+12]
	add	eax,	ecx
	mov	[ebp-20],	eax
	mov	ebx,	[ebp+28]
	push	ebx
	mov	ebx,	[ebp+24]
	push	ebx
	mov	ebx,	[ebp-20]
	push	ebx
	mov	ebx,	[ebp-16]
	push	ebx
	call	coloring
	add	esp,	16
	mov	eax,	0
	mov	[ebp-32],	eax
	mov	[ebp-36],	eax
	mov	ecx,	[ebp-4]
	cmp	ecx,	eax
	je	Aeqzero
	mov	ecx,	[ebp-8]
	cmp	ecx,	eax
	je	Beqzero
	mov	eax,	-1
	mov	ecx,	[ebp-12]
	cmp	ecx,	eax
	je	sgnisone
	jmp	isnot
sgnisone:
	mov	eax,	[ebp-16]
	mov	ecx,	[ebp+16]
	cmp	eax,	ecx
	je	koniec
	mov	eax,	[ebp-20]
	mov	ecx,	[ebp+20]
	cmp	eax,	ecx
	je	koniec
	mov	eax,	[ebp-4]
	mov	ecx,	[ebp-24]
	imul	eax,	ecx
	mov	[ebp-32],	eax
	mov	eax,	[ebp-40]
	mov	ecx,	[ebp-32]
	add	eax,	ecx
	mov	[ebp-40],	eax
	mov	eax,	0
	mov	ecx,	[ebp-40]
	cmp	ecx,	eax
	jg	Errgreaterzero
	jmp	Errlesszero
Errgreaterzero:
	mov	eax,	[ebp-8]
	mov	ecx,	[ebp-28]
	imul	eax,	ecx
	mov	[ebp-36],	eax
	mov	eax,	[ebp-40]
	mov	ecx,	[ebp-36]
	sub	eax,	ecx
	mov	[ebp-40],	eax
	mov	eax,	[ebp-20]
	mov	ecx,	[ebp-24]
	add	eax,	ecx
	mov	[ebp-20],	eax
Errlesszero:
	mov	eax,	[ebp-16]
	mov	ecx,	[ebp-28]
	sub	eax,	ecx
	mov	[ebp-16],	eax
	mov	ebx,	[ebp+28]
	push	ebx
	mov	ebx,	[ebp+24]
	push	ebx
	mov	ebx,	[ebp-20]
	push	ebx
	mov	ebx,	[ebp-16]
	push	ebx
	call	coloring
	add	esp,	16
	jmp	sgnisone
isnot:
	mov	eax,	[ebp-16]
	mov	ecx,	[ebp+16]
	cmp	eax,	ecx
	je	koniec
	mov	eax,	[ebp-20]
	mov	ecx,	[ebp+20]
	cmp	eax,	ecx
	je	koniec
	mov	eax,	[ebp-8]
	mov	ecx,	[ebp-28]
	imul	eax,	ecx
	mov	[ebp-32],	eax
	mov	eax,	[ebp-40]
	mov	ecx,	[ebp-32]
	add	eax,	ecx
	mov	[ebp-40],	eax
	mov	eax,	0
	mov	ecx,	[ebp-40]
	cmp	ecx,	eax
	jg	Err
	jmp	notErr
Err:
	mov	eax,	[ebp-4]
	mov	ecx,	[ebp-24]
	imul	eax,	ecx
	mov	[ebp-36],	eax
	mov	eax,	[ebp-40]
	mov	ecx,	[ebp-36]
	sub	eax,	ecx
	mov	[ebp-40],	eax
	mov	eax,	[ebp-16]
	mov	ecx,	[ebp-28]
	sub	eax,	ecx
	mov	[ebp-16],	eax
notErr:
	mov	eax,	[ebp-20]
	mov	ecx,	[ebp-24]
	add	eax,	ecx
	mov	[ebp-20],	eax
	mov	ebx,	[ebp+28]
	push	ebx
	mov	ebx,	[ebp+24]
	push	ebx
	mov	ebx,	[ebp-20]
	push	ebx
	mov	ebx,	[ebp-16]
	push	ebx
	call	coloring
	add	esp,	16
	jmp	isnot
Aeqzero:
	mov	eax,	[ebp-16]
	mov	ecx,	[ebp+16]
	cmp	eax,	ecx
	je	koniec
	mov	eax,	[ebp-8]
	mov	ecx,	0
	cmp	eax,	ecx
	jg	ifBl
	mov eax,    [ebp-16]
	add eax,    1
	mov [ebp-16],   eax
	jmp	ifnotB
ifBl:
	mov	eax,	[ebp-16]
	add	eax,    -1
	mov	[ebp-16],	eax
ifnotB:
	mov	ebx,	[ebp+28]
	push	ebx
	mov	ebx,	[ebp+24]
	push	ebx
	mov	ebx,	[ebp-20]
	push	ebx
	mov	ebx,	[ebp-16]
	push	ebx
	call	coloring
	add	esp,	16
	jmp	Aeqzero
Beqzero:
	mov	eax,	[ebp-20]
	mov	ecx,	[ebp+20]
	cmp	eax,	ecx
	je	koniec
	mov	eax,	0
	mov	ecx,	[ebp-4]
	cmp	ecx,	eax
	jl	ifA
	mov	eax,	[ebp-20]
	add	eax,	1
	mov [ebp-20],   eax
	jmp	ifnotA
ifA:
	mov	eax,	[ebp-20]
	add	eax,	-1
	mov [ebp-20],   eax
ifnotA:
	mov	ebx,	[ebp+28]
	push	ebx
	mov	ebx,	[ebp+24]
	push	ebx
	mov	ebx,	[ebp-20]
	push	ebx
	mov	ebx,	[ebp-16]
	push	ebx
	call	coloring
	add	esp,	16
	jmp	Beqzero
koniec:
	pop	ebx
	leave
	ret

global	coloring
coloring:
	enter	8,0
	push	ebx
	mov	ebx,	0
	mov	[ebp-4],	ebx
	mov	[ebp-8],	ebx
	mov	eax,	[ebp+12]
	mov	ecx,	480
	imul	eax,	ecx
	mov	[ebp-4],	eax
	mov	eax,	[ebp+8]
	mov	ecx,	3
	imul	eax,	ecx
	mov	[ebp-8],	eax
	mov	eax,	[ebp-4]
	mov	ecx,	[ebp-8]
	add	eax,	ecx
	mov	[ebp-4],	eax
	mov	eax,	[ebp+20]
	mov	ebx,	[ebp-4]
	mov	ecx,	[ebp+16]
	mov	[eax+ebx],	cl
	mov	[eax+ebx+1],	cl
	mov	[eax+ebx+2],	cl
	pop	ebx
	leave
	ret
