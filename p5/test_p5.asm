addiu	$t2,$zero,-345
ori	$t0,$zero,123
xor	$t0,$t0,$t2
xori	$t1,$t0,234
lui	$t3,456
slti	$t4,$t2,567
slti	$t6,$t2,567
beq	$t4,$t6,lab1
addi	$t5,$t2,345
lab1:
	sw	$t2,($zero)
	nor	$t1,$t1,$t5
	or	$t3,$t1,$t2
	sw	$t3,8($zero)
	andi	$t4,$t2,678
	bne	$t5,$zero,lab2
	sll	$t4,$t3,2
	j	lab2
	lw	$t6,8($zero)
	nop
lab2:
	slt	$t0,$t4,$t6
	srav	$t1,$t3,$t0
	lw	$t5,8($zero)
	subu	$t7,$t5,$t4
	sllv	$s0,$t7,$t3
	srlv	$s1,$s0,$t3
	jal	lab3
	sltu	$t0,$ra,$t5
lab3:
	sw	$t6,16($zero)
	or	$s0,$s0,$s1
	andi	$s1,$s1,555
	sub	$t6,$t6,$t7
	add	$t7,$t0,$t1
	sw	$t7,20($zero)
	xor	$t1,$t6,$t7
	la	$a0,lab4
	nor	$t5,$4,$a0
	jr	$a0
	sub	$t6,$t5,$zero
lab4:
	sltiu	$t6,$t1,-666
	srl	$t0,$t6,3
	sub	$t3,$t6,$zero
	lw	$t5,($zero)
	and	$t2,$t2,$4
	sra	$t7,$t5,4
	add	$t4,$t1,$t5
	sw	$t6,12($zero)
	j	lab5
	sw	$t4,20($zero)
lab5:
	sll	$t4,$t7,8
	la	$a1,exit
	jalr	$t4,$a1
	slti	$t7,$t4,484
exit:
	sw	$t2,32($zero)
	lw	$t4,32($zero)
	sw	$t4,24($zero)
	sw	$t4,40($zero)