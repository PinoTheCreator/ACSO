# int v[10];
# int *p;
# void foo(int n){
#   int i;
#   p = v;
#   for(i = 0; i < 10; i++){
#     *p = *p + n;
#     p++;
#   }
# }
# void main(){
#   foo(5);
# } 

.data
# 80 = 8*10 (10 elementi), space non inizializza
V: .space 80
P: .dword 0

.text
.global MAIN

MAIN:
  addi a2, zero, 5
  jal ra, FOO

FOO:
  # nello stack: variabile locale
  addi sp, sp, -8
  sd s0, 0(sp)

  # carico perchè il registro non è locale
  la, t0, V
  la t1, P
  
  # carico il contenuto di t0 in t1(P)
  sd t0, 0(t1)

  #ciclo for
  li s0, 0
  li t2, 10

FOR:
  # se non rispetto la condizione, salto 
  bge s0, t2, ENDFOR
  # carica in memoria il contenuto di P in t0
  ld t0, 0(t1)
  # entro nell'indirizzo -> read il valore di P (&V[0]). è nella memoria!
  ld t1, 0 (t0)

  add t1, t1, a2
  sd t1, 0(t0)
  
  # ld t0, P		devo rileggere il contenuto, ma superfluo (non è cambiato)
  
  addi t0, t0, 8
  # salva contenuto di P
  sd t0, 0(t1)
  
  addi s0, s0,
  
  j FOR

ENDFOR:
  #disalloco la memoria
  ld s0, 0(sp)
  addi sp, sp, 8
  jr ra