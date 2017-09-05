li	$t0,-123
sb	$t0,5($zero)
lb	$t1,5($zero)
addi	$t2,$t1,234
lbu	$t3,5($zero)
and	$t4,$t2,$t3
li	$s0,-123
sw	$s0,36($zero)
lw	$t5,36($zero)
sub	$t0,$t5,$zero
bltz	$t0,label1
lui	$t0,946
label1:
	or	$t1,$t4,$t0
	mult	$t1,$t0
	mfhi	$t6
	mflo	$t7
	div	$t5,$t2
	mfhi	$t6
	mflo	$t7
	andi	$t6,$t6,345
	mtlo	$t6
	mflo	$t7
	ori	$ra,$t7,456
	jal	label2
	addiu	$ra,$ra,567
label2:
	subu	$t2,$ra,$t6
	li	$t3,678
	divu	$t2,$t3
	mult	$t3,$zero
	mfhi	$ra
	mtlo	$t2
	mflo	$s1
	xori	$s0,$s1,345
	la	$s0,label3
	jr	$s0
	add	$s0,$s0,4
label3:
	sll	$s2,$s1,6
	sll	$s2,$s1,7
	sllv	$s3,$s2,$s0
	nor	$s0,$s3,$s2
	addu	$s4,$s0,$s2
	li	$s5,-1
	mult	$s4,$s5
	mflo	$s6
	sh	$s6,10($zero)
	slti	$t5,$s2,-678
	lhu	$s7,10($zero)
	bgtz	$s7,label4
	srl	$t5,$t5,8
label4:
	sltiu	$t8,$t5,-789
	lw	$t9,8($zero)
	sb	$t9,13($zero)
	sw	$t9,16($zero)
	sh	$t9,22($zero)
	sltu	$at,$t8,$t9
	addiu	$t8,$t8,1472583690
	subu	$t9,$t8,$t9
	mult	$t8,$t9
	mfhi	$t8
	mflo	$t9
	divu	$t8,$t9
	j	label5
	mthi	$zero
label5:
	mfhi	$t4
	sra	$t9,$t4,8
	srlv	$at,$at,$t9
	xor	$v0,$at,$t9
	lw	$v1,16($zero)
	slt	$k0,$v0,$v1
	sub	$k0,$zero,655357
	bgez	$k0,label6
	la	$fp,label6
	jalr	$k1,$fp
	or	$k0,$k0,$fp
label6:
	srav	$ra,$k0,$k1
	beq	$ra,$ra,label7
	addi	$a0,$ra,7426
label7:
	sh	$a0,170($zero)
	ori	$a1,$a0,467982
	bne	$a1,$zero,label8
	lh	$a2,170($zero)
label8:
	xor	$a3,$a2,$a0
	mtlo	$a3
	sub	$t7,$a3,$a1
	mfhi	$t8
	mflo	$s0
	sw	$t7,148($zero)
	bgtz	$zero,label9
	sra	$t0,$t7,3
label9:
	li	$v0,-1406
	blez	$v0,exit
	addi	$v0,$v0,1423
	li	$k0,985
	sub	$s5,$v0,$k0
	blez	$s5,exit
exit:
	sw	$k0,68($zero)
	sw	$s5,($zero)
	