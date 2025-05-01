## How to Translate the App into a New Language

If you’d like to help make **LoverQuest** more accessible by translating it into your native language, you’ll need to translate the following files.

---

### 🔤 Translate the ARB File

This file contains all the app's UI text. To translate it correctly, please follow these steps:

1. Make a copy of the [`app_en.arb`](https://github.com/H3rz3n/loverquest/blob/main/lib/l10n/app_en.arb) file and rename it to `app_xx.arb`, where `xx` is the language code (e.g., `it` for Italian, `fr` for French, etc.).
2. Translate only the **text on the right** side of each entry, without modifying the unique translation identifiers on the left.
3. Do not remove or alter special characters such as `\n`, which represent line breaks.
4. Keep any text within curly brackets `{}` exactly as it is — this content is dynamically replaced by the app.

---

### 🃏 Translate the Deck Files

These files contain the **default decks**, divided into two game modes and three couple types.

To translate the decks:

- Follow the structure and naming conventions of the original English files. Each deck file should be named like: `xx_00_game-type_couple-type_difficulty_tools-presence.arb`

- Translate the content while preserving the structure and special formatting.
```
{
  "summary": {
    "name": "Novice",                   # CHANGE IT
    "description": "Deck description",  # CHANGE IT
    "couple_type": "hetero",            # DON'T CHANGE IT
    "play_presence": true,              # DON'T CHANGE IT
    "language": "en",                   # CHANGE IT TO YOUR COUNTRY CODE ES. it,fr,es,nl...
    "total_quests": 30,                 # DON'T CHANGE IT
    "required_tools": [],               # DON'T CHANGE IT
    "tags": ["vaginal_sex"]             # DON'T CHANGE IT
  },

  "quests": [

    {
      "moment": "early",                # DON'T CHANGE IT
      "required_tools": [],             # DON'T CHANGE IT
      "player_type": "both",            # DON'T CHANGE IT
      "timer": 2,                       # DON'T CHANGE IT
      "content": "My quest content"     # CHANGE IT
    },
  ]
}
```

🗂️ You can find the English stock decks here:

- [Local play decks](https://github.com/H3rz3n/loverquest/tree/main/assets/default_decks/presence/en)
- [Online play decks](https://github.com/H3rz3n/loverquest/tree/main/assets/default_decks/distance/en)

---

### 📄 Translate the GitHub README Page

This is the app's introduction page on GitHub.

- Use the [English version of the README](https://github.com/H3rz3n/loverquest/blob/main/github_pages/readme/en_readme.md) as a reference.
- Save the translated file as `xx_readme.md`, where `xx` is your language code.
- A localized screenshot will be added once your translation is complete.

---

### 🔐 Translate the App Privacy Policy

This is the app's privacy policy.

- Use the [English version of the privacy policy](https://github.com/H3rz3n/loverquest/blob/main/github_pages/privacy_policy/en_privacy_policy.md) as a reference.
- Save the translated file as `xx_privacy_policy.md`, where `xx` is your language code.

---

Thank you for helping us bring LoverQuest to more people around the world! 🌍
