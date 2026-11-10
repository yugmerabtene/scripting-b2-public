# EXO-02 — Sauvegarde et Restauration du dossier `data`

## 1. Présentation

Ce projet consiste à écrire **un seul script Bash** capable de :
1. **Archiver** le dossier spécifique `data` (compression `.tar.gz` avec horodatage).
2. **Restaurer** une archive choisie vers un dossier cible (de manière interactive).

Aucune journalisation externe ni tâche planifiée ne sont requises.

---

## 2. Critères d'évaluation (sur 5 points)

| # | Critère | Détail | Points |
|---|---------|--------|--------|
| 1 | Archive du dossier `data` | Compression en `.tar.gz` avec nom horodaté `sauvegarde_data_AAAA-MM-JJ_HH-MM.tar.gz` | 1 |
| 2 | Gestion des erreurs | Vérification que le dossier `data` existe avant archivage ; arrêt avec code d'erreur sinon | 1 |
| 3 | Restauration interactive | Saisie du chemin de l'archive et du dossier cible ; vérification que l'archive existe | 1 |
| 4 | Intégrité de l'archive | Contrôle que l'archive `.tar.gz` est valide et lisible (avant extraction et après création). | 1 |
| 5 | Rapport de fin | Message clair indiquant succès ou échec détaillé de l'opération | 1 |

---

## 3. Spécifications fonctionnelles

### Archivage (`mode sauvegarde`)
- Le dossier à archiver est fixé : **`data`** (chemin relatif ou absolu défini en début de script).
- L'archive est nommée `sauvegarde_data_AAAA-MM-JJ_HH-MM.tar.gz`.
- Elle est placée dans un répertoire de stockage défini (par exemple `./archives` ou un chemin absolu).

### Restauration (`mode restauration`)
- L'utilisateur saisit :
  1. le chemin de l'archive à restaurer,
  2. le dossier cible de restauration.
- Le script vérifie que l'archive existe physiquement.
- Si le dossier cible est absent, il est créé automatiquement.
- Le dossier cible est créé automatiquement s'il est absent ; son contenu est écrasé directement par l'extraction (sans confirmation).
- L'intégrité de l'archive est vérifiée : contrôle que le fichier `.tar.gz` est lisible avant extraction et après création.

### Rapport de fin
À la fin de chaque opération, le script affiche clairement :
- `Succès` avec le chemin de l'archive ou du dossier restauré, ou
- `Échec` avec le motif détaillé.

---

## 4. Spécifications techniques

- **Interpréteur** : Bash standard sous Linux.
- **Dossier cible** : le dossier `data` est spécifique et défini en variable au début du script.
- **Droits** : le script doit pouvoir lire `data` et écrire dans le répertoire de stockage / dossier cible.
- **Livrable** : un seul script Bash exécutable (ex: `data_backup.sh`).

---

## 5. Exemple d'utilisation

```bash
# Rend le script exécutable
chmod +x data_backup.sh

# Archivage du dossier data
./data_backup.sh save

# Restauration interactive
./data_backup.sh restore
```

Lors de la restauration, le script demande le chemin de l'archive et le dossier cible, puis confirme avant d'écraser des données existantes.
