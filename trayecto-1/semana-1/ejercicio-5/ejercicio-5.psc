Algoritmo calculadoraPropina
	subT<-float
	porcentajePropina <- float
	numeroPersonas<-Integer
	vaolorPropina <- float
	totalPropina <- float
	pagoPorPersona <- float
	Escribir "Ingrese el valor de cuenta: "
	Leer subT
	Escribir "Ingrese el porcentaje de la propina: "
	Leer porcentajePropina
	Escribir "Ingrese el número de personas: "
	Leer numeroPersonas
	valorPropina<-subT*porcentajePropina/100
	totalPropina<-subT+valorPropina
	pagoPorPersona <- totalPropina/cantidadPersonas
	Escribir "El total con propina es: ", totalPropina
	Escribir "El valor de la propina es: " valorPropina
	Escribir "El pago por persona es: ", pagoPorPersona
FinAlgoritmo
