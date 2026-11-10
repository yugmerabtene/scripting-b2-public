# 🖥️ Scripting Bash & PowerShell — Cours public pour étudiants

> Formation complète de 4 jours + module complémentaire (Python & Cryptographie) destinée à l'administration système Linux/Windows.

[![GitHub](https://img.shields.io/badge/GitHub-yugmerabtene-blue?logo=github)](https://github.com/yugmerabtene)
[![Licence MIT](https://img.shields.io/badge/Licence-MIT-green.svg)](LICENSE)
[![Bash](https://img.shields.io/badge/Bash-5.x-green?logo=gnubash)](https://www.gnu.org/software/bash/)
[![PowerShell](https://img.shields.io/badge/PowerShell-7.x-blue?logo=powershell)](https://learn.microsoft.com/powershell/)
[![Python](https://img.shields.io/badge/Python-3.x-blue?logo=python)](https://www.python.org/)

---

## 📚 Sommaire — Navigation rapide

| Jour | Thème | Environnement | Fichier |
|:----:|-------|---------------|---------|
| **[Jour 1](./jour-1.md)** | Bash (1/2) — Shell, variables, structures de contrôle | Linux / Bash | [`jour-1.md`](./jour-1.md) |
| **[Jour 2](./jour-2.md)** | Bash (2/2) — Automatisation, admin, cron, scripts interactifs | Linux / Bash | [`jour-2.md`](./jour-2.md) |
| **[Jour 3](./jour-3.md)** | PowerShell (1/2) + Python initiation | Windows / Linux | [`jour-3.md`](./jour-3.md) |
| **[Jour 4](./jour-4.md)** | PowerShell (2/2) — Fichiers, objets, cas pratique | Windows / PowerShell | [`jour-4.md`](./jour-4.md) |
| **[Module Extra](./extra.md)** | Python admin système + Cryptographie symétrique/asymétrique & PKI | Linux / Python | [`extra.md`](./extra.md) |

### Données d'exercice
Dossier [`donnees_fictives/`](./donnees_fictives/) — fichiers de test (CSV, logs, listes) utilisés dans les travaux pratiques.

---

## 🎯 Présentation de la formation

Ce cours progresse du **shell Bash sous Linux** (Jours 1–2) vers **PowerShell sous Windows** (Jours 3–4), avec un module complémentaire couvrant l'**administration système en Python** et la **cryptographie** (symétrique, asymétrique, PKI/OpenSSL).

### Objectifs généraux

- Maîtriser l'écriture de scripts d'automatisation système fiables et maintenables
- Comprendre la différence de paradigme : flux de texte (Bash) vs objets .NET (PowerShell)
- Automatiser l'administration utilisateurs, services, fichiers, processus et journaux
- Mettre en œuvre des tâches planifiées (cron, tâches planifiées Windows)
- Appliquer les bonnes pratiques : gestion des erreurs, droits, documentation, sécurité
- Découvrir Python comme langage complémentaire pour l'administration système
- Mettre en œuvre une PKI et des signatures numériques avec OpenSSL

---

## 📅 Planning détaillé

### Jour 1 — Bash (1/2)
**Linux / Bash** | [`Voir le détail →`](./jour-1.md)

- Environnement du shell et variables d'environnement
- Syntaxe de base : variables, types, commandes, redirections
- Créer, rendre exécutable et exécuter un premier script
- Structures de contrôle : `if`, `case`, boucles `for` et `while`

### Jour 2 — Bash (2/2)
**Linux / Bash** | [`Voir le détail →`](./jour-2.md)

- Manipulation de fichiers et répertoires
- Gestion des erreurs et codes de sortie
- Administration : utilisateurs, services, journaux (`journalctl`, logs)
- Tâches planifiées avec `cron`
- Scripts interactifs, processus, droits d'accès, bonnes pratiques

### Jour 3 — PowerShell (1/2) + Python initiation
**Windows / PowerShell + Linux / Python** | [`Voir le détail →`](./jour-3.md)

- Environnement PowerShell, cmdlets, politique d'exécution
- Modèle objet .NET vs flux de texte Bash
- Structures de contrôle PowerShell
- Initiation à Python : installation, premier script, administration système

### Jour 4 — PowerShell (2/2)
**Windows / PowerShell** | [`Voir le détail →`](./jour-4.md)

- Manipulation de fichiers/dossiers : `New-Item`, `Copy-Item`, `Remove-Item`, `Get-ChildItem`...
- Modèle objet : `Get-Member`, `Select-Object`, `Where-Object`, `ForEach-Object`
- Export/import : `Export-Csv`, `ConvertTo-Json`
- Cas pratique complet

### Module Extra — Python & Cryptographie
**Linux / Python + OpenSSL** | [`Voir le détail →`](./extra.md)

- Scripts d'administration système en Python (fichiers, processus, environnement)
- Cryptographie symétrique et asymérique
- Mise en pratique avec OpenSSL et Python
- PKI, certificats et signatures numériques

---

## 🗂️ Données fictives (`donnees_fictives/`)

Fichiers mis à disposition pour les travaux pratiques :

| Fichier | Description |
|---------|-------------|
| [`employes.csv`](./donnees_fictives/employes.csv) | Liste d'employés (CSV) |
| [`system.log`](./donnees_fictives/system.log) | Journal système d'exemple |
| [`noms.txt`](./donnees_fictives/noms.txt) | Liste de noms |
| [`services.txt`](./donnees_fictives/services.txt) | Liste de services |
| [`reseau.txt`](./donnees_fictives/reseau.txt) | Informations réseau |
| [`doublons.txt`](./donnees_fictives/doublons.txt) | Fichier contenant des doublons |

---

## 🚀 Prérequis

| Environnement | Outil requis |
|---------------|--------------|
| Linux | Bash 4+, `cron`, `sudo`, `openssl` |
| Windows | PowerShell 5.1+ ou PowerShell 7+ |
| Python (Extra) | Python 3.x |

Vérifier son shell :
```bash
echo $SHELL          # Linux / Bash
pwsh -v              # PowerShell
python3 --version    # Python
```

---

## 📖 Utilisation

Chaque jour est un fichier Markdown autonome contenant : objectifs, planning horaire, contenu théorique, exemples de code et travaux pratiques.

1. Ouvrir le fichier du jour souhaité (liens dans le sommaire ci-dessus).
2. Suivre l'ordre des chapitres et exécuter les exemples dans un terminal adapté.
3. Réutiliser les fichiers de `donnees_fictives/` pour les exercices.

Exemple d'exécution d'un script Bash :
```bash
chmod +x mon_script.sh
./mon_script.sh
```

---

## 🤝 Contribution

Les contributions sont les bienvenues ! Ouvrez une issue ou soumettez une pull request.

---

## 📄 Licence

Ce projet est sous licence [MIT](./LICENSE).

---

<p align="center">
  <b>Formation Scripting Bash & PowerShell</b> — <a href="https://github.com/yugmerabtene">Youghourta Merabtène</a>
</p>
