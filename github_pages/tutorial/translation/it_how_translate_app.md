## Come Tradurre l'App in una Nuova Lingua

Se vuoi aiutare a rendere **LoverQuest** più accessibile traducendola nella tua lingua madre, dovrai tradurre i seguenti file.

---

### 🔤 Traduci il File ARB

Questo file contiene tutto il testo dell'interfaccia dell'app. Per tradurlo correttamente, segui questi passaggi:

1. Fai una copia del file [`app_en.arb`](https://github.com/H3rz3n/loverquest/blob/main/lib/l10n/app_en.arb) e rinominalo in `app_xx.arb`, dove `xx` è il codice della lingua (es. `it` per italiano, `fr` per francese, ecc.).
2. Traduci solo il **testo a destra** di ogni voce, senza modificare gli identificatori univoci sulla sinistra.
3. Non rimuovere né modificare i caratteri speciali come `\n`, che rappresentano interruzioni di riga.
4. Mantieni invariato qualsiasi testo racchiuso tra parentesi graffe `{}` — questo contenuto viene sostituito dinamicamente dall'app.

---

### 🃏 Traduci i File dei Mazzi

Questi file contengono i **mazzi predefiniti**, divisi in due modalità di gioco e tre tipi di coppia.

Per tradurre i mazzi:

- Segui la struttura e le convenzioni di denominazione dei file originali in inglese.
  Ogni file mazzo deve essere chiamato così:
  `xx_00_game-type_couple-type_difficulty_tools-presence.arb`

- Traduci il contenuto mantenendo la struttura e la formattazione speciale.

🗂️ Puoi trovare i mazzi predefiniti in inglese qui:

- [Mazzi per gioco locale](https://github.com/H3rz3n/loverquest/tree/main/assets/default_decks/presence/en)
- [Mazzi per gioco online](https://github.com/H3rz3n/loverquest/tree/main/assets/default_decks/distance/en)

---

### 📄 Traduci la Pagina README su GitHub

Questa è la pagina introduttiva dell'app su GitHub.

- Usa la [versione inglese del README](https://github.com/H3rz3n/loverquest/blob/main/github_pages/readme/en_readme.md) come riferimento.
- Salva il file tradotto come `xx_readme.md`, dove `xx` è il codice della lingua.
- Uno screenshot localizzato sarà aggiunto una volta completata la traduzione.

---

### 🔐 Traduci la Privacy Policy dell'App

Questa è l'informativa sulla privacy dell'app.

- Usa la [versione inglese della privacy policy](https://github.com/H3rz3n/loverquest/blob/main/github_pages/privacy_policy/en_privacy_policy.md) come riferimento.
- Salva il file tradotto come `xx_privacy_policy.md`, dove `xx` è il codice della lingua.

---

Grazie per aiutarci a portare LoverQuest a più persone nel mondo! 🌍
