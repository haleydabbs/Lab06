	.cpu arm7tdmi
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 2
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"main.c"
	.text
	.align	2
	.global	initialize
	.arch armv4t
	.syntax unified
	.arm
	.fpu softvfp
	.type	initialize, %function
initialize:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	mov	r3, #256
	ldr	r4, .L4
	mov	r2, #83886080
	mov	r0, #3
	ldr	r1, .L4+4
	mov	lr, pc
	bx	r4
	mov	r2, #100663296
	mov	r0, #3
	ldr	r3, .L4+8
	ldr	r1, .L4+12
	mov	lr, pc
	bx	r4
	mov	r3, #4096
	mov	r0, #3
	ldr	r2, .L4+16
	ldr	r1, .L4+20
	mov	lr, pc
	bx	r4
	mov	r5, #67108864
	mov	r2, #56320
	mov	r3, #16384
	strh	r2, [r5, #8]	@ movhi
	mov	r0, #3
	ldr	r2, .L4+24
	ldr	r1, .L4+28
	mov	lr, pc
	bx	r4
	mov	r0, #3
	ldr	r2, .L4+32
	ldr	r1, .L4+36
	mov	r3, #256
	mov	lr, pc
	bx	r4
	ldr	r3, .L4+40
	mov	lr, pc
	bx	r3
	mov	r3, #4352
	mov	r4, #72
	mov	r1, #3
	mov	r2, #0
	mov	r6, #112
	mov	ip, #16
	mov	r0, #1
	mov	lr, #100
	strh	r3, [r5]	@ movhi
	ldr	r3, .L4+44
	str	r4, [r3]
	ldr	r4, .L4+48
	ldrh	r4, [r4, #48]
	str	r1, [r3, #40]
	ldr	r1, .L4+52
	strh	r4, [r1]	@ movhi
	ldr	r1, .L4+56
	str	r6, [r3, #4]
	stm	r1, {r2, lr}
	str	ip, [r3, #16]
	str	ip, [r3, #20]
	str	r0, [r3, #12]
	str	r0, [r3, #8]
	str	r2, [r3, #24]
	str	r2, [r3, #36]
	str	r2, [r3, #28]
	pop	{r4, r5, r6, lr}
	bx	lr
.L5:
	.align	2
.L4:
	.word	DMANow
	.word	bgPal
	.word	4848
	.word	bgTiles
	.word	100720640
	.word	bgMap
	.word	100728832
	.word	spritesheetTiles
	.word	83886592
	.word	spritesheetPal
	.word	hideSprites
	.word	pikachu
	.word	67109120
	.word	buttons
	.word	.LANCHOR0
	.size	initialize, .-initialize
	.section	.text.startup,"ax",%progbits
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu softvfp
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r3, r4, r5, r6, r7, r8, r9, r10, fp, lr}
	ldr	r6, .L31
	ldr	r3, .L31+4
	mov	r10, r6
	mov	lr, pc
	bx	r3
	ldr	r4, .L31+8
	ldr	r5, .L31+12
	ldr	r9, .L31+16
	ldr	r8, .L31+20
	ldr	r7, .L31+24
	ldr	fp, .L31+28
	b	.L18
.L30:
	mov	r1, #3
	ldr	r2, [r5]
	sub	r0, r2, #1
	str	r0, [r5]
	ldrh	r0, [fp, #48]
	tst	r0, #16
	str	r1, [r4, #28]
	bne	.L16
.L13:
	mov	r1, #2
	str	r2, [r5]
	str	r1, [r4, #28]
.L16:
	ldr	r1, [r4, #36]
	ldr	r2, [r4, #28]
	add	r3, r3, #1
	str	r3, [r4, #24]
	add	r3, r2, r1, lsl #5
.L17:
	ldm	r4, {r1, r2}
	lsl	r3, r3, #1
	orr	r2, r2, #16384
	strh	r3, [r6, #4]	@ movhi
	strh	r2, [r6, #2]	@ movhi
	strh	r1, [r6]	@ movhi
	mov	lr, pc
	bx	r9
	mov	r3, fp
	mov	r2, #117440512
	mov	r1, r10
	mov	r0, #3
	mov	lr, pc
	bx	r8
	mov	r3, #67108864
	ldrh	r1, [r5]
	ldrh	r2, [r5, #4]
	strh	r1, [r3, #16]	@ movhi
	strh	r2, [r3, #18]	@ movhi
.L18:
	ldr	r3, [r4, #28]
	cmp	r3, #4
	movne	r2, #4
	strne	r3, [r4, #32]
	ldr	r3, [r4, #24]
	strne	r2, [r4, #28]
	smull	r2, r1, r7, r3
	asr	r2, r3, #31
	rsb	r2, r2, r1, asr #3
	add	r2, r2, r2, lsl #2
	subs	r2, r3, r2, lsl #2
	bne	.L8
	ldr	r1, [r4, #36]
	cmp	r1, #2
	addne	r2, r1, #1
	str	r2, [r4, #36]
.L8:
	ldrh	r2, [fp, #48]
	tst	r2, #64
	moveq	r1, #1
	ldreq	r2, [r5, #4]
	subeq	r2, r2, #1
	streq	r2, [r5, #4]
	ldrh	r2, [fp, #48]
	streq	r1, [r4, #28]
	movne	r1, #0
	ands	r2, r2, #128
	moveq	r1, #1
	ldreq	r0, [r5, #4]
	streq	r2, [r4, #28]
	ldrh	r2, [fp, #48]
	addeq	r0, r0, r1
	streq	r0, [r5, #4]
	tst	r2, #32
	beq	.L30
	ldrh	r2, [fp, #48]
	tst	r2, #16
	ldreq	r2, [r5]
	addeq	r2, r2, #1
	beq	.L13
.L15:
	cmp	r1, #0
	bne	.L16
	ldr	r3, [r4, #32]
	str	r1, [r4, #36]
	str	r3, [r4, #28]
	b	.L17
.L32:
	.align	2
.L31:
	.word	shadowOAM
	.word	initialize
	.word	pikachu
	.word	.LANCHOR0
	.word	waitForVBlank
	.word	DMANow
	.word	1717986919
	.word	67109120
	.size	main, .-main
	.comm	pikachu,44,4
	.comm	shadowOAM,1024,4
	.global	vOff
	.global	hOff
	.comm	oldButtons,2,2
	.comm	buttons,2,2
	.bss
	.align	2
	.set	.LANCHOR0,. + 0
	.type	hOff, %object
	.size	hOff, 4
hOff:
	.space	4
	.type	vOff, %object
	.size	vOff, 4
vOff:
	.space	4
	.ident	"GCC: (devkitARM release 53) 9.1.0"
