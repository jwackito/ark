.data
CTRL: .word32 0x10000
DATA: .word32 0x10008
variable:  .asciiz ""

.code
lwu $s0, DATA($0)
lwu $s1, CTRL($0)
daddi $t1, $0, 9
sd $t1, 0($s1)
lbu $t2, 0($s0)
sb $t2, variable($0)

halt
