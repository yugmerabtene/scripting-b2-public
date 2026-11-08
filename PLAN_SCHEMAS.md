# Plan des schémas Mermaid — Scripting Bash et PowerShell

## Règle générale

Chaque jour de formation doit contenir au **minimum 2 diagrammes Mermaid**.
Chaque diagramme comporte une légende **`**Fig N** — Description**` (N = numéro séquentiel dans le fichier), est placé après l'explication théorique correspondante, et reste compact (maximum 15 noeuds).

Les libellés de flèches évitent les parenthèses et les opérateurs `!=` (risque d'erreur de parseur Mermaid : `Parse error`). Utiliser des libellés simples (`|Oui|`, `|Non|`, `|code 0|`, `|code non nul|`). Les valeurs détaillées s'expliquent dans le texte autour du diagramme, pas dans le libellé de la flèche.

## Détail par jour

### Jour 1 — Bash (1/2) — chapitres 1 à 4

| Fig | Type | Emplacement | Description | Noeuds max |
|-----|------|-------------|-------------|------------|
| 1 | `flowchart TD` | Chapitre 1 | Topologie du lab : poste Linux (Bash) et poste Windows (PowerShell) en réseau | 8 |
| 2 | `flowchart LR` | Chapitre 3 | Pipeline d'écriture de script : éditeur → enregistrement → `chmod +x` → exécution → test | 6 |
| 3 | `flowchart TD` | Chapitre 4 | Flux de contrôle : conditions `if`/`case` et boucles `for`/`while` | 10 |

### Jour 2 — Bash (2/2) — chapitres 5 à 8

| Fig | Type | Emplacement | Description | Noeuds max |
|-----|------|-------------|-------------|------------|
| 4 | `flowchart TD` | Chapitre 5 | Topologie du lab : manipulation de fichiers et répertoires sur poste Linux | 8 |
| 5 | `flowchart TD` | Chapitre 6 | Flux de contrôle : gestion des erreurs (`set -e`, codes de retour) | 8 |
| 6 | `sequenceDiagram` | Chapitre 8 | Interaction script/utilisateur : menu interactif avec lecture clavier | 6 |
| 7 | `flowchart TD` | Chapitre 7 | Gestion des processus et des droits : utilisateurs, services, journaux | 10 |
| 8 | `flowchart TD` | Chapitre 7 | Processus d'automatisation : `cron` / tâche planifiée | 8 |

### Jour 3 — PowerShell (1/2) — chapitres 9 à 12

| Fig | Type | Emplacement | Description | Noeuds max |
|-----|------|-------------|-------------|------------|
| 9 | `flowchart LR` | Chapitre 10 | Pipeline PowerShell : cmdlet → objet .NET → formatage (`Format-*`, `Export-Csv`) | 8 |
| 10 | `graph TD` | Chapitre 10 | Approche objet PowerShell VS flux texte Bash | 8 |
| 11 | `flowchart LR` | Chapitre 11 | Pipeline d'écriture de script PowerShell : éditeur → `.ps1` → `Set-ExecutionPolicy` → exécution | 6 |

### Jour 4 — PowerShell (2/2) — chapitres 13 à 16

| Fig | Type | Emplacement | Description | Noeuds max |
|-----|------|-------------|-------------|------------|
| 12 | `flowchart LR` | Chapitre 13 | Pipeline PowerShell : cmdlet → objet → formatage | 8 |
| 13 | `sequenceDiagram` | Chapitre 16 | Interaction script/utilisateur : cas pratique avec menu | 6 |
| 14 | `flowchart TD` | Chapitre 15 | Gestion des processus et des droits : processus, services, ACL | 10 |
| 15 | `flowchart TD` | Chapitre 15 | Processus d'automatisation : tâche planifiée Windows | 8 |

## Total

- Diagrammes planifiés : **15**
- Minimum requis : 2 par jour × 4 jours = **8**

## Fichiers associés

- `generate_diagrams.py` : script de génération des diagrammes (Mermaid CLI `mmdc`, sortie PNG 1200×600 px, fond blanc).
- Les blocs ```mermaid dans chaque fichier `jour-X.md` sont remplacés par les images PNG générées lors de l'export PDF via `generate_pdf.py`.
