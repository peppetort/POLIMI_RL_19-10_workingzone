# WorkingZone
Progetto di Reti Logiche 2020

Nel file working_zone c'è il prototipo funzionante che passa i test e di cui dobbiamo chiedere al tutorato riguardante l'attesa.

Nel file working_zone_with_more_state_(Not_sure_work) ho provato a fare un test:
Ho diviso il momento in cui legge le working zone dal momento in cui legge input e poi scriverà l'output
Le working zone verrano lette appena arriverà un reset
N.B.  Non so se funziona correttamente in tutti i casi, ma in questo momento mi sembra di si,
N.B.2.La parte strana è dalla riga è nel secondo case mem_counter is (dalla riga 112 alla 123) nel quale ha un doppio sfalsamento,
      cioè io pensavo di accorpare il caso 9 e 10, ma in case 9 (riga 116) viene preso il valore della wz7, anche se
      nel ciclo precendente, con il debug, si vede che ho settato l'indirizzo della ram alla posizione 8 (nostro input).
      Questo problema devo rivederlo.

