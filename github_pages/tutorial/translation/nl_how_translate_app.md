## Hoe de App in een Nieuwe Taal te Vertalen

Als je wilt helpen om **LoverQuest** toegankelijker te maken door het naar je moedertaal te vertalen, moet je de volgende bestanden vertalen.

---

### 🔤 Vertaal het ARB-bestand

Dit bestand bevat alle UI-tekst van de app. Volg deze stappen om het correct te vertalen:

1. Maak een kopie van het bestand [`app_en.arb`](https://github.com/H3rz3n/loverquest/blob/main/lib/l10n/app_en.arb) en hernoem het naar `app_xx.arb`, waarbij `xx` de taalcode is (bijv. `nl` voor Nederlands, `fr` voor Frans, enz.).
2. Vertaal alleen de **tekst aan de rechterkant** van elke regel, zonder de unieke identificatie aan de linkerkant te wijzigen.
3. Verwijder of wijzig geen speciale tekens zoals `\n`, die staan voor regeleinden.
4. Laat alle tekst tussen accolades `{}` precies zoals het is — deze inhoud wordt dynamisch vervangen door de app.

---

### 🃏 Vertaal de Kaartenbestanden

Deze bestanden bevatten de **standaard decks**, verdeeld over twee spelmodi en drie soorten koppels.

Om de decks te vertalen:

- Volg de structuur en naamgevingsconventies van de originele Engelse bestanden.
  Elk kaartenbestand moet als volgt worden genoemd:
  `xx_00_game-type_couple-type_difficulty_tools-presence.arb`

- Vertaal de inhoud met behoud van structuur en speciale opmaak.

🗂️ Je vindt de Engelse standaarddecks hier:

- [Decks voor lokaal spel](https://github.com/H3rz3n/loverquest/tree/main/assets/default_decks/presence/en)
- [Decks voor online spel](https://github.com/H3rz3n/loverquest/tree/main/assets/default_decks/distance/en)

---

### 📄 Vertaal de README-pagina op GitHub

Dit is de introductiepagina van de app op GitHub.

- Gebruik de [Engelse versie van de README](https://github.com/H3rz3n/loverquest/blob/main/github_pages/readme/en_readme.md) als referentie.
- Sla het vertaalde bestand op als `xx_readme.md`, waarbij `xx` je taalcode is.
- Een gelokaliseerde screenshot wordt toegevoegd zodra je vertaling is voltooid.

---

### 🔐 Vertaal het Privacybeleid van de App

Dit is het privacybeleid van de app.

- Gebruik de [Engelse versie van het privacybeleid](https://github.com/H3rz3n/loverquest/blob/main/github_pages/privacy_policy/en_privacy_policy.md) als referentie.
- Sla het vertaalde bestand op als `xx_privacy_policy.md`, waarbij `xx` je taalcode is.

---

Bedankt dat je helpt om LoverQuest naar meer mensen over de hele wereld te brengen! 🌍
