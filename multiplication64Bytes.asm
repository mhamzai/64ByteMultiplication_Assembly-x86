org 0x100
cpuid
cpuid
cpuid
rdtsc
mov  [clk],eax
mov [clk+4],edx

clc

xor eax,eax
xor edx,edx
xor bx,bx
xor cx,cx
outloop:
	mov edx,[num2+bx]
	push bx
	mov si,0
	mov bx,cx
			
	add cx,4
	here:
		clc
		mov eax,[num1+si]
		push edx
		mul edx
		add [result+bx],eax
		adc [result+bx+4],edx		
		pop edx
		add bx,4
		add si,4
		cmp si,64
	jne here

		jnc skip
		pushf
		mov di,bx
		adder:
			add di,4
			popf
			adc dword[result + di + 4],0
			pushf
			
			cmp di,60
		jne adder
		popf
		skip:

	pop bx
	add bx,4
	cmp bx,64
jne outloop
rdtsc

sbb eax,[clk]
sbb edx,[clk+4]
mov  [clk],eax
mov [clk+4],edx
xor eax,eax
mov ax, 4c00h
int 21h

num1 :dw 0xFFFF,0x0238,0xADE9,0x67EE,0x7675,0xF1E2,0x1D11,0x161C,0xB65C,0x201A,0x6519,0x7237,0x3790,0x6502,0x2013,0x10BA,0x1938,0x1202,0x8362,0xAC72,0x8390,0xCD92,0x2213,0x6675,0x8778,0x4AB9,0xF765,0xD738,0x26AB,0x0000,0x0000,0x0000
num2 :dw 0x9120,0x7210,0x1521,0xEDD6,0x625E,0x6621,0xF723,0xFFFF,0x31FF,0x3726,0x4DE2,0x6125,0x3623,0xBC82,0x8273,0x8273,0x9374,0xBBCC,0x8162,0x9127,0x2830,0x2EF2,0x2517,0xAD71,0x8754,0x5712,0x9ABC,0x2362,0xEDA7,0x8162,0xBCD2,0xA128
result times 64 dw 0
clk times 2 dd 0
                                      ;;;;;;;;;;;;;;;;;;;;PROFILE;;;;;;;;;;;;;;;;;
;;clk CYCLES TAKEN are 0x0ba8 ie 2984 cycles