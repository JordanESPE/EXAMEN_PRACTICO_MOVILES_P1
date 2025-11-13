# Calculadora de Árboles - Criadero

Aplicación Flutter para calcular el precio total de compra de árboles (Paltos, Limones y Chirimoyos) con sistema de descuentos por cantidad e IVA.

## 📋 Descripción del Problema

Un criadero de árboles comercializa paltos, limones y chirimoyos con la siguiente tabla de precios y descuentos:

| Tipo de árbol | Precio unitario | Rebaja 100-300 árboles | Rebaja > 300 árboles |
|--------------|----------------|----------------------|-------------------|
| Paltos | $1,200 | 10% | 18% |
| Limones | $1,000 | 12.5% | 20% |
| Chirimoyos | $980 | 14.5% | 19% |

**Descuento adicional:** Si el total de árboles supera 1,000 unidades, se aplica un 15% adicional.

**IVA:** Se aplica 12% de IVA sobre el monto con descuentos.

## 🏗️ Arquitectura

### MVC (Model-View-Controller)

```
lib/
├── models/              # Modelos de datos
│   ├── arbol_model.dart
│   └── compra_model.dart
├── controllers/         # Lógica de negocio
│   └── arbol_controller.dart
├── views/              # Pantallas
│   ├── pantalla_inicio_view.dart
│   ├── calculadora_arboles_view.dart
│   └── detalles_compra_view.dart
├── widgets/            # Componentes UI (Atomic Design)
│   ├── atoms/
│   │   ├── boton_atomo.dart
│   │   ├── campo_texto_atomo.dart
│   │   ├── dropdown_atomo.dart
│   │   └── texto_resultado_atomo.dart
│   └── molecules/
│       ├── formulario_compra_molecula.dart
│       ├── lista_compras_molecula.dart
│       └── tarjeta_resumen_molecula.dart
├── config/             # Configuración
│   ├── theme.dart
│   └── routes.dart
└── main.dart
```

### Atomic Design

- **Átomos:** Componentes básicos (TextField, Button, Text, Dropdown)
- **Moléculas:** Combinación de átomos (Formulario de compra, Tarjeta de resumen)
- **Organismos:** Pantallas completas que combinan moléculas

## 🎨 Características

### Funcionalidades

✅ Selección de tipo de árbol (Paltos, Limones, Chirimoyos)
✅ Ingreso de cantidad con validación
✅ Múltiples compras en una sola orden
✅ Cálculo automático de descuentos por cantidad
✅ Descuento adicional del 15% si supera 1,000 árboles
✅ Cálculo de IVA (12%)
✅ Resumen detallado de la compra
✅ Vista de detalles con parámetros de ruta

### Validaciones

- ✓ Cantidad debe ser un número válido
- ✓ Cantidad no puede ser negativa
- ✓ Cantidad debe ser mayor a 0
- ✓ No se puede calcular sin compras agregadas

### Tema Personalizado

- 🎨 Colores inspirados en naturaleza (verde bosque)
- 🎨 Diseño limpio y humanizado
- 🎨 Componentes con bordes redondeados
- 🎨 Gradientes suaves
- 🎨 Iconografía relacionada con árboles y naturaleza

### Rutas con Parámetros

- `/` - Pantalla de inicio
- `/calculadora` - Calculadora principal
- `/detalles` - Detalles con parámetros de resumen

## 🚀 Cómo Ejecutar

### Requisitos

- Flutter SDK >= 3.0.0
- Dart >= 3.0.0

### Instalación

1. Instalar dependencias:
```bash
flutter pub get
```

2. Ejecutar la aplicación:
```bash
flutter run
```

## 📱 Uso de la Aplicación

1. **Pantalla de Inicio:** Presenta información del criadero y precios
2. **Seleccionar Árbol:** Elegir tipo de árbol del dropdown
3. **Ingresar Cantidad:** Escribir la cantidad deseada
4. **Agregar:** Presionar botón para agregar a la compra
5. **Repetir:** Agregar más tipos de árboles si es necesario
6. **Calcular:** Presionar "Calcular Total" para ver el resumen
7. **Ver Detalles:** Presionar "Ver Detalles" para pantalla completa

## 🧮 Lógica de Cálculo

### Proceso de Cálculo

1. **Subtotal:** Precio unitario × Cantidad
2. **Descuento por tipo:** Según la cantidad de cada tipo de árbol
3. **Descuento adicional:** 15% si el total de árboles > 1,000
4. **Subtotal con descuentos:** Subtotal - Descuentos
5. **IVA:** 12% sobre subtotal con descuentos
6. **Total Final:** Subtotal con descuentos + IVA

### Ejemplo

**Compra:**
- 500 Paltos × $1,200 = $600,000
- 600 Limones × $1,000 = $600,000

**Cálculos:**
- Subtotal: $1,200,000
- Descuento Paltos (18%): $108,000
- Descuento Limones (20%): $120,000
- Subtotal con descuentos: $972,000
- Descuento adicional (15%): $145,800 (porque 1,100 > 1,000)
- Subtotal final: $826,200
- IVA (12%): $99,144
- **Total a pagar: $925,344**

## 🎯 Cumplimiento de Requisitos

### Modelo (Model)
✅ Clase `ArbolModel` con atributos y métodos
✅ `calcularSubtotal()`, `aplicarDescuentos()`, `calcularIVA()`, `totalFinal()`

### Controlador (Controller)
✅ `ArbolController` con lógica de negocio
✅ Validaciones de entrada
✅ Control de múltiples compras
✅ Cálculo de descuento adicional

### Vista (View)
✅ Interfaz para seleccionar tipo y cantidad
✅ Resumen con desglose completo
✅ Navegación entre pantallas

### Atomic Design
✅ Átomos: TextField, DropdownButton, Button, Text
✅ Moléculas: Formulario de compra, Tarjeta de resumen
✅ Organismos: Pantallas completas

### Validaciones
✅ Entradas numéricas
✅ No valores negativos
✅ IVA sobre monto con descuentos
✅ Rebaja del 15% si supera 1,000 árboles

### Diseño y Funcionalidad
✅ Rutas con parámetros
✅ Atomic design implementado
✅ Tema personalizado humanizado

## 📝 Autor

Jordan Guaman - Examen Práctico Móviles P1
