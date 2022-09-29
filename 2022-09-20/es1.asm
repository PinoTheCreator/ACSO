# int sum(int a, int b){
#   int d;
#   d = a + b;
#   return d;
# }
# void main(){
#   int a, b, c;
#   a = 5;
#   b = 3;
#   c = sum(a, b);
#   return;
# } 

.text
.global MAIN
# .eqv N 5

# a = s0, b = s1, c = s2
MAIN: 
  # pseudoistruzione: li, s0, 5
  addi s0, zero, 5 
  addi s1, zero, 3
  
  # carico i parametri per la funzione
  mv a2, s0
  mv a3, s1
  
  # chiamo SUM
  jal ra, SUM  

  # copia valore restituito
  # pseudoistruzione: mv s2, a0
  add s2, zero, a0 

  # fine programma : non necessario per l'esame
  li a0, 0
  li a7, 93
  ecall

SUM:  
  # alloco spazio nello stack pointer (sp)
  addi sp, sp, -8 
  sd s0, 0(sp)
  add s0, a2, a3
  mv a0, s0

  # inizio ritorno al chiamante
  ld s0, 0(sp)
  addi sp, sp 8
  jalr zero, 0(ra)
  
