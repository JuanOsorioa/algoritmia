# Tablas de traza

Las trazas se hicieron siguiendo cada algoritmo paso a paso (no se ejecutaron en PSeInt).

---

## 1. CajeroParqueadero

**Patrones:** centinela (`0`), contador (`carros`) y acumulador (`total`), ambos en 0 antes del ciclo.

**Entrada de prueba:** 4000, 8000, 2000, 0

| Vuelta | valor | valor <> 0 | total | carros | lee |
|---|---:|:---:|---:|---:|---:|
| Antes del ciclo | 4000 | — | 0 | 0 | — |
| 1 | 4000 | V | 4000 | 1 | 8000 |
| 2 | 8000 | V | 12000 | 2 | 2000 |
| 3 | 2000 | V | 14000 | 3 | 0 |
| Fin | 0 | F | 14000 | 3 | — |

**Salida:**

```
Carros atendidos: 3
Total recaudado: 14000
```

### Caso borde: la caja se cierra sin atender carros

**Entrada:** 0

| Vuelta | valor | valor <> 0 | total | carros |
|---|---:|:---:|---:|---:|
| Antes del ciclo | 0 | — | 0 | 0 |
| Fin | 0 | F | 0 | 0 |

**Salida:** Carros atendidos: 0 · Total recaudado: 0

### Por qué importa el segundo `Leer valor`

Sin el `Leer valor` dentro del ciclo, `valor` se queda en 4000 y la condición `valor <> 0` siempre es verdadera:

| Vuelta | valor | valor <> 0 | total | carros |
|---|---:|:---:|---:|---:|
| 1 | 4000 | V | 4000 | 1 |
| 2 | 4000 | V | 8000 | 2 |
| 3 | 4000 | V | 12000 | 3 |
| ... | 4000 | V | ... | ... |

Es un ciclo infinito: falta la actualización de la variable de control.

---

## 2. Piramide

**Entrada de prueba:** n = 4

**Fórmulas:** espacios = de 1 hasta `n - fila`; asteriscos = de 1 hasta `2 * fila - 1`.

| fila | n - fila (espacios) | 2 * fila - 1 (asteriscos) | Línea dibujada |
|---:|---:|---:|---|
| 1 | 3 | 1 | `···*` |
| 2 | 2 | 3 | `··***` |
| 3 | 1 | 5 | `·*****` |
| 4 | 0 | 7 | `*******` |

(Los puntos `·` representan los espacios y no se muestran en el programa.)

**Salida:**

```
   *
  ***
 *****
*******
```

### Traza de los ciclos internos

| fila | Ciclo de espacios (`j` de 1 a n - fila) | Ciclo de asteriscos (`j` de 1 a 2 * fila - 1) |
|---:|---|---|
| 1 | j = 1, 2, 3 (3 vueltas) | j = 1 (1 vuelta) |
| 2 | j = 1, 2 (2 vueltas) | j = 1, 2, 3 (3 vueltas) |
| 3 | j = 1 (1 vuelta) | j = 1, 2, 3, 4, 5 (5 vueltas) |
| 4 | ninguna (de 1 hasta 0, 0 vueltas) | j = 1 a 7 (7 vueltas) |

### Casos borde

| Caso | Qué pasa |
|---|---|
| Última fila (fila = n) | `n - fila = 0`: el ciclo de espacios no da ninguna vuelta. Con `Con Paso 1`, PSeInt no cuenta hacia atrás. |
| Con `2 * fila` en vez de `2 * fila - 1` | Salen 2, 4, 6, 8 asteriscos: una escalera, no una pirámide. Es un error por uno. |
| n = 1 | Una sola fila: 0 espacios y 1 asterisco (`*`). |

---

## 3. Árbol de cajas: página de resultados de una tienda en línea

Versión simplificada, hecha a partir de la estructura general de una tienda en línea (como la de Mercado Libre). Lo marcado con `× N` se repite, es decir, es un ciclo.

```
Página de resultados de la tienda
│
├── Encabezado
│   ├── Logo
│   ├── Buscador
│   │   ├── Campo de texto
│   │   └── Botón Buscar
│   ├── Menú de navegación
│   │   └── Enlace de categoría × N          ← ciclo (Ofertas, Ayuda, ...)
│   └── Carrito
│       ├── Ícono
│       └── Contador de productos
│
├── Contenido
│   ├── Filtros laterales
│   │   ├── Título del filtro
│   │   └── Opción de filtro × N             ← ciclo
│   │       ├── Casilla
│   │       └── Etiqueta
│   │
│   ├── Lista de productos
│   │   └── Tarjeta de producto × N          ← ciclo
│   │       ├── Imagen
│   │       ├── Nombre
│   │       ├── Precio
│   │       ├── Calificación
│   │       └── Botón Agregar al carrito
│   │
│   └── Paginación
│       ├── Botón Anterior
│       ├── Número de página × N             ← ciclo
│       └── Botón Siguiente
│
└── Pie de página
    ├── Enlaces de ayuda
    ├── Redes sociales
    └── Derechos de autor
```

### Qué se ve en el árbol

- **Tres cajas grandes:** Encabezado, Contenido y Pie de página.
- **Cuatro ciclos:** enlaces del menú, opciones de filtro, tarjetas de producto y números de página. La tarjeta de producto es el más importante: es la misma caja repetida con datos distintos.
- **Una tarjeta es un subproceso:** se dibuja una vez (`DibujarTarjeta(imagen, nombre, precio)`) y se llama dentro de un ciclo `Para`, igual que `CalcularPorcentaje` en la factura del restaurante.
