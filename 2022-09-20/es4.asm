# long int sums(long int n, long int m) {
#   return n * m + 17;
# }
# long int big_fun(long int a, long int b, long int c, long int d, long int e) {
#   return c + sums(d, g) + a * b + f + e;
# }
# void main() {
#   int a = 1, b = 2, c = 3, d = 4, e = 5, f = 6, g = 7, res;
#   res = big_fun(a, b, c, d, e, f, g);
# }

.text
.globl MAIN

MAIN:
  # s0 = a, s1 = b, s2 = c, s3 = d, s4 = e, s5 = f, s6 = g, s7 = res
  li s0, 1
  li s1, 2
  li s2, 3
  li s3, 4
  li s4, 5
  li s5, 6
  li s6, 7
  # inizializza registry parametri BIG_FUN
  mv a2, s0
  mv a3, s1
  mv a4, s2
  mv a5, s3
  mv a6, s4
  mv a7, s5
  # passa quinto parametron su stack
  addi sp, sp, -8
  sd s6, 0(sp)
  jal BIG_FUN # chiama BIG_FUN
  addi sp, sp, 8 # libera spazio sullo stack
  mv s7, a0
# per terminare l’esecuzione tramite exit
  li a0, 0
  li a7, 93
  ecall

BIG_FUN:
  # backup PC ritorno e registry parametri
  addi sp, sp, -16
  sd fp, 8(sp) # salva fp precedente
  addi fp, sp, 8 # fp punta all’inizio del record di attivazione di BIG_FUN
  sd ra, 0(sp) 
  # backup a2 - a7, potevo salvare solo quelle che mi servono
  addi sp, sp, -48
  sd a2, 40(sp)
  sd a3, 32(sp)
  sd a4, 24(sp)
  sd a5, 16(sp)
  sd a6, 8(sp)
  sd a7, 0(sp)
  # prepara registry a per chiamata a SUMS
  mv a2, a5
  ld a3, 8(fp) # leggi il parametro “g” dallo stack (il fp sta sotto g)
  jal SUMS #chiama SUMS
  # ripristina a2 - a7
  ld a2, 40(sp)
  ld a3, 32(sp)
  ld a4, 24(sp)
  ld a5, 16(sp)
  ld a6, 8(sp)
  ld a7, 0(sp)
  addi sp, sp, 48
  # procedi con l’espressione
  add t0, a0, a4
  mul t1, a2, a3
  add t2, t1, t0
  add t3, t2, a7
  add a0, t3, a6
  ld ra, -8(fp) # ripristina ra dallo stack tramite fp
  addi sp, fp, 8 # ripristina valore iniziale di sp usando fp
  ld fp, 0(fp) # ripristina fp dallo stack tramite fp
  jr ra
SUMS:
  addi sp, sp, 8 # alloca spazio sullo stack
  sd fp, 0(sp) # salva fp precedente
  mv fp, sp # fp punta all’inizio del record di attivazione di SUM
  # calcola espressione
  mul t0, a0, a1
  addi a0, t0, 17
  addi sp, fp, 8 # ripristina valore iniziale di fp usando fp
  lw fp, 0(fp) # ripristina fp dallo stack tramite fp
  jr ra
