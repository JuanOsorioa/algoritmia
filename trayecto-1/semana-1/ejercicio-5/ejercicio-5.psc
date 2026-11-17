Algoritmo calculadoraPropina
	Definir subT, porcentajePropina, valorPropina, totalPropina, pagoPorPersona Como Real
	Definir numeroPersonas Como Entero
	Escribir "Ingrese el valor de la cuenta: "
	Leer subT
	Escribir "Ingrese el porcentaje de la propina: "
	Leer porcentajePropina
	Escribir "Ingrese el número de personas: "
	Leer numeroPersonas
	valorPropina <- subT * porcentajePropina / 100
	totalPropina <- subT + valorPropina
	pagoPorPersona <- totalPropina / numeroPersonas
	Escribir "El total con propina es: ", totalPropina
	Escribir "El valor de la propina es: ", valorPropina
	Escribir "El pago por persona es: ", pagoPorPersona
FinAlgoritmo
