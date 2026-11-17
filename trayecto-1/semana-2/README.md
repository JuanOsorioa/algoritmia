# Tablas de verdad / decisión y pruebas de escritorio

Las pruebas de escritorio se hicieron siguiendo cada algoritmo paso a paso.

---

## 1. ValidarRegistro

**Regla:** se registra si `edad >= 14` Y acepta los términos.

### Tabla de verdad

| edad >= 14 | acepta (S) | Resultado |
|:---:|:---:|---|
| V | V | Registro exitoso |
| V | F | No puedes registrarte |
| F | V | No puedes registrarte |
| F | F | No puedes registrarte |

### Pruebas de escritorio

| # | edad | respuesta | Mayusculas | edad >= 14 | = "S" | Salida |
|---|:---:|:---:|:---:|:---:|:---:|---|
| 1 | 14 | `s` | `S` | V | V | Registro exitoso |
| 2 | 13 | `S` | `S` | F | V | No puedes registrarte |
| 3 | 20 | `N` | `N` | V | F | No puedes registrarte |
| 4 | 10 | `n` | `N` | F | F | No puedes registrarte |

Casos borde: 14 (justo el mínimo) y 13 (justo debajo), y la `s` minúscula, que sin `Mayusculas` se rechazaría por error.

---

## 2. EdadValida (De Morgan)

**Edad inválida:** `edad < 0 O edad > 120`.
**Edad válida (negación por De Morgan):** `edad >= 0 Y edad <= 120`.

### Tabla de verdad

| edad < 0 | edad > 120 | Resultado |
|:---:|:---:|---|
| V | F | Edad inválida |
| F | V | Edad inválida |
| F | F | Edad válida |
| V | V | Imposible (nadie es menor que 0 y mayor que 120) |

### Pruebas de escritorio

| # | edad | edad < 0 | edad > 120 | Salida |
|---|:---:|:---:|:---:|---|
| 1 | -1 | V | F | Edad inválida |
| 2 | 0 | F | F | Edad válida |
| 3 | 120 | F | F | Edad válida |
| 4 | 121 | F | V | Edad inválida |

---

## 3. Calculadora de propinas (arreglada)

### Tabla de decisión

| Regla | numeroPersonas | Resultado |
|---|---|---|
| R1 | 0 o menos | "El número de personas debe ser mayor que cero" (no calcula) |
| R2 | Más de 0 | Calcula propina, total y pago por persona |

### Pruebas de escritorio

| # | subT | % | personas | Proceso | Salida |
|---|---:|---:|---:|---|---|
| 1 | 100000 | 10 | 0 | personas <= 0 → V | El número de personas debe ser mayor que cero |
| 2 | 100000 | 10 | -2 | personas <= 0 → V | El número de personas debe ser mayor que cero |
| 3 | 80000 | 10 | 1 | propina = 8000; total = 88000; 88000 / 1 | Total 88000 · Propina 8000 · Por persona 88000 |
| 4 | 100000 | 10 | 4 | propina = 10000; total = 110000; 110000 / 4 | Total 110000 · Propina 10000 · Por persona 27500 |

---

## 4. Parqueadero

### Tabla de decisión

| Regla | Tipo | Minutos | Factura | Resultado |
|---|---|---|---|---|
| R1 | Cualquiera | Menos de 0 | Cualquiera | Error: minutos negativos |
| R2 | Ni 1 ni 2 | 0 o más | Cualquiera | Error: tipo no válido |
| R3 | Carro o moto | De 0 a 15 | Cualquiera | Gratis |
| R4 | Carro o moto | Más de 15 | No | Horas × tarifa, máximo $30.000 |
| R5 | Carro o moto | Más de 15 | Sí | Lo mismo que R4, dividido entre 2 |

Tarifas: carro (1) = $4.000 por hora o fracción; moto (2) = $2.000.
Horas: `trunc((minutos + 59) / 60)`. Orden de cálculo: valor → tope de $30.000 → descuento por factura.

### Pruebas de escritorio

| # | Tipo | Min | Factura | Regla | Proceso | Salida | Esperado |
|---|:---:|---:|:---:|:---:|---|---:|---:|
| 1 | Carro | 15 | No | R3 | 15 <= 15 → gratis | 0 | 0 ✔ |
| 2 | Carro | 16 | No | R4 | horas = trunc(75/60) = 1; 1 × 4000 | 4.000 | 4.000 ✔ |
| 3 | Carro | 60 | No | R4 | horas = trunc(119/60) = 1; 1 × 4000 | 4.000 | 4.000 ✔ |
| 4 | Carro | 61 | No | R4 | horas = trunc(120/60) = 2; 2 × 4000 | 8.000 | 8.000 ✔ |
| 5 | Moto | 61 | Sí | R5 | tarifa 2000; horas = 2; valor 4000; sin tope; 4000 / 2 | 2.000 | 2.000 ✔ |
| 6 | Carro | 600 | No | R4 | horas = trunc(659/60) = 10; valor 40000; tope → 30000 | 30.000 | 30.000 ✔ |
| 7 | Carro | 600 | Sí | R5 | horas 10; valor 40000; tope 30000; 30000 / 2 | 15.000 | 15.000 ✔ |
| 8 | 3 | 30 | No | R2 | tarifa = 0 (De Otro Modo) | Error: tipo no válido | Tipo no válido ✔ |
| 9 | Carro | -5 | No | R1 | minutos < 0 | Error: minutos negativos | Minutos negativos ✔ |

Nota sobre el caso 7: si el descuento se aplicara antes del tope, daría 40000 / 2 = 20000 y luego tope 30000 = 20000, es decir, un resultado distinto. Por eso el tope va primero.

Nota sobre el caso 1: la condición debe ser `minutos <= 15`; con `minutos < 15` los 15 minutos exactos se cobrarían $4.000.

---

## 5. Semáforo de inventario

### Tabla de decisión

| Regla | Unidades | Resultado |
|---|---|---|
| R1 | Menos de 0 | Error: unidades negativas |
| R2 | 0 | Rojo: agotado |
| R3 | De 1 a 10 | Amarillo: hay que pedir |
| R4 | Más de 10 | Verde: todo bien |

### Pruebas de escritorio (casos borde)

| # | unidades | < 0 | = 0 | <= 10 | Salida |
|---|---:|:---:|:---:|:---:|---|
| 1 | -1 | V | | | Error: unidades negativas |
| 2 | 0 | F | V | | Rojo: agotado |
| 3 | 1 | F | F | V | Amarillo: hay que pedir |
| 4 | 10 | F | F | V | Amarillo: hay que pedir |
| 5 | 11 | F | F | F | Verde: todo bien |

---

## 6. Bisiesto

**Condición:** `(anio MOD 4 = 0 Y anio MOD 100 <> 0) O anio MOD 400 = 0`

### Tabla de verdad

| Divisible entre 4 | Divisible entre 100 | Divisible entre 400 | Resultado |
|:---:|:---:|:---:|---|
| F | F | F | No es bisiesto |
| V | F | F | Es bisiesto |
| V | V | F | No es bisiesto |
| V | V | V | Es bisiesto |

(Las demás combinaciones no existen: todo múltiplo de 400 lo es de 100, y todo múltiplo de 100 lo es de 4.)

### Pruebas de escritorio

| # | anio | MOD 4 | MOD 100 | MOD 400 | (MOD 4 = 0 Y MOD 100 <> 0) | MOD 400 = 0 | Salida |
|---|---:|---:|---:|---:|:---:|:---:|---|
| 1 | 2026 | 2 | 26 | 26 | F | F | 2026 no es bisiesto |
| 2 | 2024 | 0 | 24 | 24 | V | F | 2024 es bisiesto |
| 3 | 1900 | 0 | 0 | 300 | F | F | 1900 no es bisiesto |
| 4 | 2000 | 0 | 0 | 0 | F | V | 2000 es bisiesto |
