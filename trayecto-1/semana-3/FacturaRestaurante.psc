Funcion subtotal <- LeerPedido()
	Definir cantidadBandejas, precioBandeja, cantidadAjiaco, precioAjiaco, subtotal Como Real
	Escribir "Cantidad de bandejas: "
	Leer cantidadBandejas
	Escribir "Precio de la bandeja: "
	Leer precioBandeja
	Escribir "Cantidad de ajiacos: "
	Leer cantidadAjiaco
	Escribir "Precio del ajiaco: "
	Leer precioAjiaco
	subtotal <- cantidadBandejas * precioBandeja + cantidadAjiaco * precioAjiaco
FinFuncion

Funcion resultado <- CalcularPorcentaje(base, porcentaje)
	Definir resultado Como Real
	resultado <- base * porcentaje / 100
FinFuncion

SubProceso ImprimirFactura(subtotal, impuesto, propina)
	Escribir "Subtotal: ", subtotal
	Escribir "Impuesto al consumo (8%): ", impuesto
	Escribir "Propina sugerida (10%): ", propina
	Escribir "Total a pagar: ", subtotal + impuesto + propina
FinSubProceso

Algoritmo FacturaRestaurante
	Definir subtotal, impuesto, propina Como Real
	subtotal <- LeerPedido()
	impuesto <- CalcularPorcentaje(subtotal, 8)
	propina <- CalcularPorcentaje(subtotal, 10)
	ImprimirFactura(subtotal, impuesto, propina)
FinAlgoritmo
