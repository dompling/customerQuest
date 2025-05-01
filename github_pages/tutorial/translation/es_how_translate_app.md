## Cómo Traducir la App a un Nuevo Idioma

Si deseas ayudar a hacer **LoverQuest** más accesible traduciéndola a tu idioma, tendrás que traducir los siguientes archivos.

---

### 🔤 Traduce el Archivo ARB

Este archivo contiene todos los textos de la interfaz de la app. Para traducirlo correctamente, sigue estos pasos:

1. Haz una copia del archivo [`app_en.arb`](https://github.com/H3rz3n/loverquest/blob/main/lib/l10n/app_en.arb) y renómbrala como `app_xx.arb`, donde `xx` es el código del idioma (por ejemplo, `es` para español, `it` para italiano, etc.).
2. Traduce solo el **texto a la derecha** de cada entrada, sin modificar los identificadores únicos a la izquierda.
3. No elimines ni modifiques caracteres especiales como `\n`, que representan saltos de línea.
4. Mantén intacto cualquier texto entre llaves `{}` — este contenido se reemplaza dinámicamente en la app.

---

### 🃏 Traduce los Archivos de Mazos

Estos archivos contienen los **mazos predeterminados**, divididos en dos modos de juego y tres tipos de pareja.

Para traducirlos:

- Sigue la estructura y las convenciones de nombres de los archivos originales en inglés.
  Cada archivo de mazo debe llamarse así:
  `xx_00_game-type_couple-type_difficulty_tools-presence.arb`

- Traduce el contenido conservando la estructura y el formato especial.

🗂️ Puedes encontrar los mazos predeterminados en inglés aquí:

- [Mazos para juego local](https://github.com/H3rz3n/loverquest/tree/main/assets/default_decks/presence/en)
- [Mazos para juego en línea](https://github.com/H3rz3n/loverquest/tree/main/assets/default_decks/distance/en)

---

### 📄 Traduce la Página README de GitHub

Esta es la página de introducción de la app en GitHub.

- Usa la [versión inglesa del README](https://github.com/H3rz3n/loverquest/blob/main/github_pages/readme/en_readme.md) como referencia.
- Guarda el archivo traducido como `xx_readme.md`, donde `xx` es el código de idioma.
- Se añadirá una captura de pantalla localizada una vez que completes la traducción.

---

### 🔐 Traduce la Política de Privacidad de la App

Esta es la política de privacidad de la app.

- Usa la [versión inglesa de la política de privacidad](https://github.com/H3rz3n/loverquest/blob/main/github_pages/privacy_policy/en_privacy_policy.md) como referencia.
- Guarda el archivo traducido como `xx_privacy_policy.md`, donde `xx` es el código de idioma.

---

¡Gracias por ayudarnos a llevar LoverQuest a más personas alrededor del mundo! 🌍
