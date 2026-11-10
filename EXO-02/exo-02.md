# EXO-02 — Système de Sauvegarde et de Restauration

## 1. Présentation

Ce projet consiste à concevoir une solution fiable de gestion des données destinée à des étudiants. Elle repose sur deux processus distincts :

1. **Sauvegarde et archivage** — compression d'un répertoire source dans une archive horodatée au format `.tar.gz`.
2. **Restauration interactive** — décompression d'une archive choisie par l'utilisateur vers un dossier cible.

L'ensemble des opérations doit être journalisé pour garantir la traçabilité et faciliter le débogage.

---

## 2. Critères d'évaluation (sur 5 points)

| # | Critère | Détail | Points |
|---|---------|--------|--------|
| 1 | Sauvegarde avec gestion des erreurs | Vérification de l'existence du dossier source ; arrêt immédiat avec code d'erreur si absent ; journalisation des événements | 1 |
| 2 | Restauration interactive | Saisie du chemin de l'archive et du dossier cible ; validation de la présence du fichier archive ; création automatique du dossier cible ou demande de confirmation s'il contient déjà des données | 1 |
| 3 | Journalisation de sauvegarde | Heure exacte du traitement ; lien absolu vers le dossier archivé | 1 |
| 4 | Journalisation de restauration | Lien absolu vers le dossier restauré ; statut final de l'opération (succès ou échec détaillé) | 1 |
| 5 | Horodatage et automatisation | Nommage standardisé `sauvegarde_AAAA-MM-JJ_HH-MM.tar.gz` ; planification via une tâche Cron | 1 |

---

## 3. Spécifications fonctionnelles

### Processus de sauvegarde et d'archivage
- Définir des **variables fixes** pour le répertoire source et le répertoire de stockage des archives.
- Utiliser le format compressé **Tarball (`.tar.gz`)**.
- Isoler le flux de sortie pour capturer à la fois `stdout` et `stderr` dans le fichier de log.
- Générer un nom d'archive basé sur l'horodatage pour éviter tout écrasement accidentel.

### Processus de restauration interactive
- Interface en ligne de commande avec invites textuelles guidant l'opérateur.
- Vérifier la présence physique du fichier archive avant extraction.
- Gérer intelligemment le dossier de destination :
  - Création automatique s'il est absent.
  - Message d'alerte et demande de confirmation explicite (`o/n`) s'il contient déjà des données.
- Afficher un rapport de fin clair (succès ou type d'échec).

---

## 4. Spécifications techniques et contraintes

- **Environnement** : interpréteur Bash standard sous Linux (compatibilité Debian, Ubuntu, RHEL).
- **Chemins** : utilisation obligatoire de chemins absolus pour éviter les problèmes de contexte d'exécution.
- **Droits** : exécuter avec les privilèges nécessaires pour lire le répertoire d'origine et écrire dans les répertoires de destination et de logs.

---

## 5. Format des journaux

### Journal de sauvegarde (`sauvegarde.log`)

```
=== DÉBUT DU TRAITEMENT : [Date complète] ===
Heure d'archivage : [HH:MM:SS]
Lien du dossier à archiver : [Chemin absolu source]
Création de l'archive dans : [Chemin de l'archive horodatée]
STATUT : Sauvegarde réussie.
=== FIN DU TRAITEMENT (SUCCÈS) : [Date complète] ===
----------------------------------------
```

### Journal de restauration (`restauration.log`)

```
=== DÉBUT DE RESTAURATION : [Date complète] ===
Archive sélectionnée : [Chemin de l'archive source]
Lien vers le dossier restauré : [Chemin du dossier cible]
Extraction des fichiers vers [Chemin du dossier cible]...
STATUT : Restauration accomplie avec succès.
=== FIN DE RESTAURATION (SUCCÈS) : [Date complète] ===
----------------------------------------
```

---

## 6. Planification automatisée (Cron)

Le processus de sauvegarde doit pouvoir être programmé pour s'exécuter de façon autonome, par exemple chaque jour à minuit :

```cron
0 0 * * * /chemin/absolu/EXO-02/sauvegarde.sh
```

---

## 7. Livrables attendus

| Fichier | Rôle |
|---------|------|
| `EXO-02/sauvegarde.sh` | Script de sauvegarde et d'archivage |
| `EXO-02/restauration.sh` | Script de restauration interactive |
| `EXO-02/exo-02.md` | Cet énoncé / cahier des charges |

Les scripts doivent être rendus exécutables (`chmod +x`).
