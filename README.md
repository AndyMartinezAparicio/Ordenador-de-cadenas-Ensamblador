# Ordenador-de-cadenas-Ensamblador

<p align="center">
  <img src="https://img.icons8.com/color/144/assembly.png" width="100">
</p>

### Proyecto Final - Ordenador de Cadenas en Ensamblador

![Language](https://img.shields.io/badge/Language-Free%20Pascal%20%2B%20Assembly-red.svg)
![IDE](https://img.shields.io/badge/IDE-Lazarus-green.svg)
![Paradigm](https://img.shields.io/badge/Paradigm-Low--Level%20Programming-orange.svg)
![Year](https://img.shields.io/badge/Academic%20Year-2nd%20Year-lightgrey.svg)
![Status](https://img.shields.io/badge/Status-Completed-success.svg)

---

## 📌 Sobre el Proyecto

Este proyecto corresponde a la **tarea final de la asignatura Arquitectura de Computadoras**, cursada en **segundo año de Ingeniería Informática**.

Fue desarrollado en **Free Pascal** con **ensamblador en línea (inline assembly)** utilizando **Lazarus** como entorno de desarrollo. El objetivo principal fue aprender los fundamentos del lenguaje ensamblador y su integración con Pascal.

---

## 🛠 Tecnologías Utilizadas

| Componente           | Tecnología                       |
| -------------------- | -------------------------------- |
| Lenguaje             | Free Pascal + Assembly (Intel)  |
| IDE                  | Lazarus                          |
| Tipo de aplicación   | Consola                          |
| Paradigma            | Programación de bajo nivel       |
| Modo asm             | Intel                            |

---

## 🏗 Arquitectura

El proyecto está estructurado en un programa principal que orchestras cinco procedimientos en ensamblador:

* **Programa principal** → Control de flujo, entrada/salida
* **Procedimientos asm** → Lógica de procesamiento de cadenas

---

## 🖥 Funcionamiento del Programa

El programa solicita una frase al usuario y la procesa mediante algoritmos implementados en ensamblador:

```
Ingrese una frase: Hola Mundo
La cadena ordenada es: adhlmnou
```

### 📋 Pipeline de Procesamiento

El texto pasa por **5 etapas** de procesamiento:

1. **Conversión a minúsculas** → Elimina mayúsculas y tildes (á→a, é→e, í→i, ó→o, ú→u, Ñ→ñ)
2. **Validación de letras** → Filtra caracteres que no sean letras minúsculas
3. **Ordenamiento alfabético** → Ordena las letras usando algoritmo de burbuja
4. **Eliminación de duplicados** → Elimina letras repetidas consecutivas
5. **Posicionamiento de la ñ** → Coloca la 'ñ' en su posición correcta (entre 'n' y 'o')

---

## ⚙ Procedimientos Ensamblador

| Procedimiento            | Función                                                                 |
| ----------------------- | ----------------------------------------------------------------------- |
| `levantar_a_minusculas_sin_tildes` | Convierte mayúsculas a minúsculas y elimina tildes |
| `validar_letras`        | Filtra la cadena dejando solo letras válidas                          |
| `ordenar_cadena`        | Ordena las letras alfabéticamente (algoritmo burbuja)                |
| `quitar_dobles`         | Elimina letras duplicadas consecutivas                                |
| `ordenar_ene`           | Posiciona la 'ñ' correctamente en el alfabeto                        |

---

## 🎓 Conocimientos Aplicados

* Manipulación de registros (EAX, EBX, ECX, EDX)
* Operaciones de memoria con direccionamiento directo
* Control de flujo con saltos condicionales (JE, JNE, JG, JGE, JL, JLE)
* Uso de la pila (PUSH/POP)
* Algoritmos de ordenamiento en bajo nivel
* Integración de ensamblador en un lenguaje de alto nivel

---

## 🚀 Compilación y Ejecución

1. Abrir `OrdenadorCadenas.lpi` en **Lazarus**
2. Compilar con **F9** o desde el menú Build
3. Ejecutar el programa compilado

El ejecutable `OrdenadorCadenas.exe` puede correrse directamente en Windows.
