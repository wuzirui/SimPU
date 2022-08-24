.data

.text
main:
	lui	$t0,	0x00000064
	addiu	$t1,	$t0,	0x0000ffff
	addiu	$t2,	$t0,	0x00000001
	addu	$t0,	$t1,	$t2
	sw	$t0,	0x10010100($zero)
	lw	$t1,	0x10010100($zero)