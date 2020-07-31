org 100h
cpuid
cpuid
cpuid
rdtsc
mov  [clk],eax
mov [clk+4],edx
push num1
push num2
push temp
push result
call multi
pop ax
pop ax
pop ax
pop ax
rdtsc

sbb eax,[clk]
sbb edx,[clk+4]
mov  [clk],eax
mov [clk+4],edx
xor eax,eax
xor ecx,ecx
mov ax, 0x4c00
int 21h



shifter:
		mov bx,0
		mov si,[bp+6]
		clc
		pushf
	loopthis:
		popf
		mov ax,[si+bx]
		rcl ax,1
		mov [si+bx],ax
		pushf
		inc bx
		inc bx
		cmp bx,128
	jne loopthis
	popf
ret

addition:
	
	mov bx,0
	mov si,[bp+6]
	clc
	pushf
	loopex:
		popf
		mov ax,[si+bx]
		pushf
		mov si,[bp+4]
		popf
		adc [si+bx],ax
		pushf
		mov si,[bp+6]
		inc bx
		inc bx
		cmp bx,128
	jne loopex
	popf		
ret


multi:
		push bp
		mov bp,sp
		mov cx,32
		xor bx,bx
		here:
			mov si,[bp+10]
			mov ax,[si+bx]
			mov si,[bp+6]
			mov [si+bx],ax
			inc bx		
			inc bx
		loop here
			mov cx,512
	oloop:
			mov bx,64
			mov dx,0
			clc
			mov si,[bp+8]
		loop3:
			mov ax,[si+bx-2]
			rcr ax,1
			mov [si + bx - 2],ax
			dec bx
			dec bx
		jnz loop3

		jnc herey
		
		call addition

		herey:
		
		call shifter

	loop oloop

ret















num1 :dw 0xFFFF,0x0238,0xADE9,0x67EE,0x7675,0xF1E2,0x1D11,0x161C,0xB65C,0x201A,0x6519,0x7237,0x3790,0x6502,0x2013,0x10BA,0x1938,0x1202,0x8362,0xAC72,0x8390,0xCD92,0x2213,0x6675,0x8778,0x4AB9,0xF765,0xD738,0x26AB,0x0000,0x0000,0x0000
num2 :dw 0x9120,0x7210,0x1521,0xEDD6,0x625E,0x6621,0xF723,0xFFFF,0x31FF,0x3726,0x4DE2,0x6125,0x3623,0xBC82,0x8273,0x8273,0x9374,0xBBCC,0x8162,0x9127,0x2830,0x2EF2,0x2517,0xAD71,0x8754,0x5712,0x9ABC,0x2362,0xEDA7,0x8162,0xBCD2,0xA128
temp times 64 dw 0
result times 64 dw 0
clk times 2 dd 0
																				;;;;;;;;;;PROFILE;;;;;;;;;;;;;;;
;;time taken is 0x3929d
;;ie 234141 clk cycles
