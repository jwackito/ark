.data
        CONTROL:      .word32 0x10000
        DATA:         .word32 0x10008
        color_pelota: .word32 0xFF0000  ; Azul
        color_fondo:  .word32 0xFFFFFF  ; Blanco

.text
        lwu    $s6, CONTROL($0)
        lwu    $s7, DATA($0)
        lwu    $v0, color_pelota($0)
        lwu    $v1, color_fondo($0)

        daddi  $s0, $0, 23      ; Coordenada X de la pelota
        daddi  $s1, $0, 1       ; Coordenada Y de la pelota
        daddi  $s2, $0, 1       ; Direccion X de la pelota
        daddi  $s3, $0, 1       ; Direccion Y de la pelota
        daddi  $s4, $0, 5       ; Comando para dibujar un punto

loop:   sw     $v1, 0($s7)      ; Borra la pelota 
        sb     $s0, 4($s7)
        sb     $s1, 5($s7)
        sd     $s4, 0($s6)

        ; Mueve la pelota en la direccion actual.
        dadd   $s0, $s0, $s2
        dadd   $s1, $s1, $s3

        ; Comprueba que la pelota no esté en la columna de más a la derecha.
        ; Si es así, cambia la dirección en X.
        daddi  $t1, $0, 48
        slt    $t0, $t1, $s0
        dsll   $t0, $t0, 1
        dsub   $s2, $s2, $t0

        ; Comprueba que la pelota no esté en la fila de más arriba.
        ; Si es así, cambia la dirección en Y.
        slt    $t0, $t1, $s1
        dsll   $t0, $t0, 1
        dsub   $s3, $s3, $t0

        ; Comprueba que la pelota no esté en la columna de más a la izquierda.
        ; Si es así, cambia la dirección en X.
        slti   $t0, $s0, 1
        dsll   $t0, $t0, 1
        dadd   $s2, $s2, $t0

        ; Comprueba que la pelota no esté en la fila de más abajo.
        ; Si es así, cambia la dirección en Y.
        slti   $t0, $s1, 1
        dsll   $t0, $t0, 1
        dadd   $s3, $s3, $t0

        ; Dibuja la pelota
        sw     $v0, 0($s7)
        sb     $s0, 4($s7)
        sb     $s1, 5($s7)
        sd     $s4, 0($s6)

        ; Hace una demora para que el rebote no sea tan rápido
        ; Esto genera una infinidad de RAW y BTS pero bue...
        ; hay que hacer tiempo igualmente!
        daddi  $t0, $0, 500
demora: daddi  $t0, $t0, -1 
        bnez   $t0, demora

        j loop

        halt
