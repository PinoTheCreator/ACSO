MAIN:
  jal GETSTDIN
  mv a2, a0 # prendo il valore di ritorno dalla funzione GETSTDIN

  la a3, VECTOR # carico in a3 (argomento in ingresso) l'indirizzo di Vector

  jal VSIGN
  la t0, SIGN
  sd a0, 0(t0)
