Algoritmo Semaforo
	Definir unidades Como Entero
	Escribir "Ingrese las unidades en inventario: "
	Leer unidades
	Si unidades < 0 Entonces
		Escribir "Error: unidades negativas"
	SiNo
		Si unidades = 0 Entonces
			Escribir "Rojo: agotado"
		SiNo
			Si unidades <= 10 Entonces
				Escribir "Amarillo: hay que pedir"
			SiNo
				Escribir "Verde: todo bien"
			FinSi
		FinSi
	FinSi
FinAlgoritmo
