## Comment Traduire l'Application dans une Nouvelle Langue

Si vous souhaitez aider à rendre **LoverQuest** plus accessible en la traduisant dans votre langue maternelle, vous devrez traduire les fichiers suivants.

---

### 🔤 Traduire le Fichier ARB

Ce fichier contient tout le texte de l’interface de l’application. Pour le traduire correctement, veuillez suivre ces étapes :

1. Faites une copie du fichier [`app_en.arb`](https://github.com/H3rz3n/loverquest/blob/main/lib/l10n/app_en.arb) et renommez-la en `app_xx.arb`, où `xx` est le code de langue (ex. `fr` pour français, `it` pour italien, etc.).
2. Traduisez uniquement le **texte à droite** de chaque entrée, sans modifier les identifiants uniques à gauche.
3. Ne supprimez pas et ne modifiez pas les caractères spéciaux comme `\n`, qui représentent des sauts de ligne.
4. Conservez exactement le texte entre accolades `{}` — ce contenu est remplacé dynamiquement par l'application.

---

### 🃏 Traduire les Fichiers de Paquet de Cartes

Ces fichiers contiennent les **paquets par défaut**, divisés en deux modes de jeu et trois types de couple.

Pour les traduire :

- Suivez la structure et la convention de nommage des fichiers originaux en anglais.
  Chaque fichier de paquet doit être nommé ainsi :
  `xx_00_game-type_couple-type_difficulty_tools-presence.arb`

- Traduisez le contenu en conservant la structure et le formatage spécial.

🗂️ Vous pouvez trouver les paquets par défaut en anglais ici :

- [Paquets pour jeu local](https://github.com/H3rz3n/loverquest/tree/main/assets/default_decks/presence/en)
- [Paquets pour jeu en ligne](https://github.com/H3rz3n/loverquest/tree/main/assets/default_decks/distance/en)

---

### 📄 Traduire la Page README sur GitHub

Il s'agit de la page de présentation de l'application sur GitHub.

- Utilisez la [version anglaise du README](https://github.com/H3rz3n/loverquest/blob/main/github_pages/readme/en_readme.md) comme référence.
- Enregistrez le fichier traduit sous le nom `xx_readme.md`, où `xx` est votre code de langue.
- Une capture d'écran localisée sera ajoutée une fois votre traduction terminée.

---

### 🔐 Traduire la Politique de Confidentialité de l'Application

Il s'agit de la politique de confidentialité de l'application.

- Utilisez la [version anglaise de la politique de confidentialité](https://github.com/H3rz3n/loverquest/blob/main/github_pages/privacy_policy/en_privacy_policy.md) comme référence.
- Enregistrez le fichier traduit sous le nom `xx_privacy_policy.md`, où `xx` est votre code de langue.

---

Merci de nous aider à faire découvrir LoverQuest à davantage de personnes dans le monde ! 🌍
