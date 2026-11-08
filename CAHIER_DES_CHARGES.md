# Cahier des charges — Extensions du cours « Scripting Bash et PowerShell »

## 1. Objet

Le présent document définit les spécifications officielles des extensions à apporter au cours existant (4 jours, 16 chapitres Bash + PowerShell, plus le module `extra.md` couvrant Python et cryptographie). Ces extensions visent à ajouter :

- Un module avancé de traitement de texte (grep, awk, sed, cut, sort, uniq, find)
- Un catalogue centralisé des commandes extraites des livres de référence
- Un module unifié de cryptographie, sauvegarde et restauration (y compris MinIO S3)
- Une continuité pédagogique avec jeux de logs standardisés
- Une validation par tests automatisés (green-build)

## 2. Périmètre et livrables

### 2.1 Module avancé : Commandes Linux & Traitement de Texte

**Objectif :** rédiger une partie dédiée et approfondie aux commandes de filtrage et de manipulation de données.

**Outils couverts :** `grep`, `awk`, `sed`, `cut`, `sort`, `uniq`, `find`.

**Contenu attendu :**
- Expressions régulières (regex) : syntaxe, optimisation, pièges
- Pipelines : chaînage, efficacité, redirections
- Cas d'usage réels d'administration système
- Intégration dans les labs existants (Jours 1-2, Bash)

**Livrable :** sections ajoutées dans `jour-1.md` à `jour-2.md` ou nouveau fichier `jour-2b.md` selon décision de l'orchestrateur.

### 2.2 Extraction Globale & Intégration des Commandes

**Objectif :** extraire l'intégralité des commandes, outils et snippets de code des livres ingérés dans `books/`.

**Contenu attendu :**
- Catalogue centralisé des commandes (fichier à définir, ex. `CATALOGUE_COMMANDES.md`)
- Référencement livre + page pour chaque commande (via RAG `books`)
- Intégration cohérente dans les travaux pratiques et exercices

**Livrable :** `CATALOGUE_COMMANDES.md` + mise à jour des fichiers `jour-X.md` concernés.

### 2.3 Module Unifié : Cryptographie, Sauvegarde & Restauration

**Objectif :** intégrer un chapitre structuré couvrant :

- Cryptographie symétrique (AES, modes de chiffrement)
- Cryptographie asymétrique (RSA, gestion des clés publiques/privées)
- Hachage & intégrité (SHA-256, HMAC)
- Sauvegarde et restauration sécurisées (chiffrement des archives à la volée, vérification d'intégrité, gestion et rotation)

**Implémentations requises :**
- Bash / Shell Linux (OpenSSL, tar, gpg, sha256sum, etc.)
- PowerShell (cmdlets .NET cryptographie, etc.)
- Python (cryptography, hashlib, hmac, etc.)
- **MinIO S3 :** installation préalable, sauvegarde et restauration vers/un bucket MinIO

**Livrable :** sections dans `extra.md` (chapitres 21-24 existants à étendre) ou nouveau fichier dédié.

### 2.4 Continuité Pédagogique, Jeux de Données (Logs) & Tests

**Objectif :** assurer une suite logique entre les exercices et valider techniquement tous les scripts.

**Contenu attendu :**
- Réutilisation des mêmes fichiers et jeux de données d'un exercice à l'autre
- Fichiers de logs réels et standardisés (référencés depuis des dépôts publics ou fournis)
- Tous les scripts (Bash, PowerShell, Python) exécutés et testés dans le dépôt
- Objectif : 0 erreur, 0 échec sur l'ensemble de la suite de tests

**Livrable :** répertoire `tests/` ou `labs/donnees/` avec jeux de logs, suite de tests automatisés, rapport de validation `code-tester`.

## 3. Contraintes éditoriales et de format

Tous les contenus ajoutés doivent respecter `.opencode/CONTEXT.md` :

- Français académique, accentuation complète et correcte
- Style livre de référence (théorie, exemples, labs complets, corrections démontrées)
- Structure obligatoire par section (8 étapes d'enchaînement)
- Minimum 2 diagrammes Mermaid par jour ajouté
- Commentaires de commandes (flag par flag + pourquoi pédagogique)
- Minimum 2 encadrés pédagogiques par chapitre théorique
- Bonnes pratiques par Lab, solutions repliées dans `<details>`, checkpoints cochables
- Aucun emoji, aucun bruit, aucun caractère erroné
- Numérotation des chapitres continue

## 4. Règles du corpus RAG

- Le corpus `books/` ne contient que des ouvrages Linux et Bash (aucun PowerShell, Python, cryptographie)
- Toute affirmation technique sur ces domaines doit être signalée comme **non sourcée par le RAG**
- Sourcer avant d'affirmer ; citer livre et page ; reformuler sans recopier de longs extraits

## 5. Workflow de validation

Chaque extension suit le pipeline imposé par l'orchestrateur :

1. Rédaction → `course-writer`
2. Validation technique → `code-tester` (syntaxe, exécution, reproductibilité)
3. Relecture finale → `proofreader` (anti-bruit, conformité CONTEXT + cahier des charges)
4. Mise à jour de `.opencode/tracking.json` et de `.opencode/CONTEXT.md`

## 6. Critères d'acceptation

- Tous les scripts Bash sont exécutables sous Linux (bash disponible)
- Tous les scripts PowerShell sont syntaxiquement validés (pwsh peut être absent sur Linux : test statique accepté avec mention)
- Tous les scripts Python sont exécutables (python3 disponible)
- Les procédures MinIO S3 sont documentées avec installation préalable
- Rapport `code-tester` : 0 erreur, 0 échec
- Verdict `proofreader` : PRÊT

---

*Document rédigé par l'orchestrateur le 2026-11-08. À valider par le client avant lancement des délégations de rédaction.*
