.intel_syntax noprefix

.text

_start:
	jmp _start

.align 4

.rept 506
	.byte 0
.endr

.byte 0x55
.byte 0xAA


.end
