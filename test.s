
.data 0x10000000

.text 0x00400000
.globl  main
main:
        addi    $v0, $zero, 0x5
        addi    $v1, $zero, 0xc
        addi    $a3, $v1, -9
        or      $a0, $a3, $v0
        and     $a1, $v1, $a0
        add     $a1, $a1, $a0
        beq     $a1, $a3, branch2
        slt     $a0, $v1, $a0
        beq     $a0, $zero, branch1
        addi    $a1, $zero, 0
branch1:
        slt     $a0, $a3, $v0
        add     $a3, $a0, $a1
        sub     $a3, $a3, $v0
        la      $s0, 0x10000000
        la      $s1, 0x1000000c
        sw      $a3, 0x44($s1)
        lw      $v0, 0x50($s0)
        j       branch2
        addi    $v0, $zero, 0x1
branch2:
        sw      $v0, 0x54($s0)
