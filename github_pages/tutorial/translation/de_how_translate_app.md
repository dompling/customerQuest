## Wie man die App in eine Neue Sprache Übersetzt

Wenn du helfen möchtest, **LoverQuest** zugänglicher zu machen, indem du es in deine Muttersprache übersetzt, musst du die folgenden Dateien übersetzen.

---

### 🔤 Übersetze die ARB-Datei

Diese Datei enthält alle Texte der Benutzeroberfläche der App. Um sie korrekt zu übersetzen, folge bitte diesen Schritten:

1. Erstelle eine Kopie der Datei [`app_en.arb`](https://github.com/H3rz3n/loverquest/blob/main/lib/l10n/app_en.arb) und benenne sie in `app_xx.arb` um, wobei `xx` der Sprachcode ist (z. B. `de` für Deutsch, `it` für Italienisch, usw.).
2. Übersetze nur den **Text auf der rechten Seite** jedes Eintrags, ohne die einzigartigen Bezeichner auf der linken Seite zu verändern.
3. Entferne oder verändere keine Sonderzeichen wie `\n`, die für Zeilenumbrüche stehen.
4. Belasse jeglichen Text in geschweiften Klammern `{}` unverändert — dieser Inhalt wird dynamisch von der App ersetzt.

---

### 🃏 Übersetze die Kartenstapel-Dateien

Diese Dateien enthalten die **Standard-Stapel**, unterteilt in zwei Spielmodi und drei Beziehungstypen.

So übersetzt du die Stapel:

- Folge der Struktur und den Namenskonventionen der englischen Originaldateien.
  Jede Datei sollte so benannt werden:
  `xx_00_game-type_couple-type_difficulty_tools-presence.arb`

- Übersetze den Inhalt und behalte dabei Struktur und Sonderformatierung bei.

🗂️ Du findest die englischen Standardstapel hier:

- [Stapel für lokales Spiel](https://github.com/H3rz3n/loverquest/tree/main/assets/default_decks/presence/en)
- [Stapel für Online-Spiel](https://github.com/H3rz3n/loverquest/tree/main/assets/default_decks/distance/en)

---

### 📄 Übersetze die README-Seite auf GitHub

Dies ist die Einführungsseite der App auf GitHub.

- Nutze die [englische README-Version](https://github.com/H3rz3n/loverquest/blob/main/github_pages/readme/en_readme.md) als Referenz.
- Speichere die übersetzte Datei unter `xx_readme.md`, wobei `xx` dein Sprachcode ist.
- Ein lokalisierter Screenshot wird hinzugefügt, sobald deine Übersetzung abgeschlossen ist.

---

### 🔐 Übersetze die Datenschutzrichtlinie der App

Dies ist die Datenschutzrichtlinie der App.

- Nutze die [englische Version der Datenschutzrichtlinie](https://github.com/H3rz3n/loverquest/blob/main/github_pages/privacy_policy/en_privacy_policy.md) als Referenz.
- Speichere die übersetzte Datei unter `xx_privacy_policy.md`, wobei `xx` dein Sprachcode ist.

---

Vielen Dank, dass du hilfst, LoverQuest in die Welt hinauszutragen! 🌍
