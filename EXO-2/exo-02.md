
CAHIER DES CHARGES : SYSTÈME DE SAUVEGARDE ET DE RESTAURATION


1. Présentation du Projet

Ce projet consiste à concevoir et formaliser une solution fiable de gestion des données pour des étudiants. La solution repose sur l'implémentation de deux processus distincts : un mécanisme de sauvegarde et d'archivage d'une part, et un mécanisme de restauration interactive d'autre part. L'ensemble des actions doit être tracé pour garantir un suivi précis et faciliter le débogage.

2. Critères d'Évaluation et Barème (Sur 5 points)

• 1 Point : Sauvegarde avec gestion des erreurs
	• Vérification impérative de l'existence du dossier source avant traitement.
	• Interruption immédiate du processus avec un code d'erreur si le dossier est introuvable.
	• Écriture automatique des événements dans un fichier de journalisation dédié.
• 1 Point : Restauration interactive
	• Demande de saisie à l'utilisateur pour le chemin de l'archive et le dossier cible.
	• Validation de la présence physique du fichier archive.
	• Gestion intelligente du dossier de destination (création automatique s'il est absent, message d'alerte et demande de confirmation s'il contient déjà des données).
• 1 Point : Journalisation de sauvegarde (Suivi et débogage)
	• Enregistrement de l'heure exacte du traitement.
	• Traçabilité du lien absolu vers le dossier archivé.
• 1 Point : Journalisation de restauration (Suivi et débogage)
	• Enregistrement du lien absolu vers le dossier restauré.
	• Intégration du statut final de l'opération (succès ou échec détaillé).
• 1 Point : Horodatage strict et automatisation
	• Application d'un format de nommage standardisé basé sur le temps pour éviter tout écrasement accidentel : sauvegarde_AAAA-MM-JJ_HH-MM.tar.gz.
	• Planification finale via une tâche automatisée (Cronjob).

3. Spécifications Fonctionnelles


Processus de Sauvegarde et d'Archivage

• Définition des cibles : Utilisation de variables fixes pour identifier le répertoire source et le répertoire de stockage des archives.
• Formatage et compression : Utilisation du format compressé Tarball (.tar.gz) pour optimiser l'espace disque.
• Sécurité des données : Isolation complète du flux de sortie pour capturer à la fois le canal standard et le canal d'erreur au sein du fichier de log.

Processus de Restauration Interactive

• Interface utilisateur en ligne de commande : Utilisation d'invites textuelles pour guider l'opérateur.
• Protection contre l'écrasement : Suspension du script en attente d'une validation explicite (o/n) si le répertoire de destination n'est pas vierge.
• Rapport de fin : Notification claire du succès ou du type d'échec rencontré lors de la décompression du bloc de données.

4. Spécifications Techniques et Contraintes

• Environnement : Les procédures doivent être écrites pour l'interpréteur de commandes standard Bash sous Linux (compatibilité Debian, Ubuntu, RHEL).
• Localisation des ressources : Obligation d'employer des chemins absolus pour prévenir les défaillances liées au changement de contexte d'exécution.
• Droits d'accès : Les processus doivent s'exécuter avec les privilèges requis pour lire le répertoire d'origine et écrire dans les répertoires de destination et de logs.

5. Modèles de Tâches et de Fichiers Attendus


Planification Automatisée (Cronjob)

Le déclenchement du processus de sauvegarde doit pouvoir être programmé pour s'exécuter de façon autonome en arrière-plan à intervalle régulier (par exemple, chaque jour à minuit pile).

Structure Type du Journal de Sauvegarde

text
=== DÉBUT DU TRAITEMENT : [Date complète] ===
Heure d'archivage : [HH:MM:SS]
Lien du dossier à archiver : [Chemin absolu]
Création de l'archive dans : [Chemin de l'archive horodatée]
STATUT : Sauvegarde réussie avec succès.
=== FIN DU TRAITEMENT (SUCCÈS) : [Date complète] ===
----------------------------------------
Utilisez le code avec précaution.

Structure Type du Journal de Restauration

text
=== DÉBUT DE RESTAURATION : [Date complète] ===
Archive sélectionnée : [Chemin de l'archive source]
Lien vers le dossier restauré : [Chemin du dossier cible]
Extraction des fichiers vers [Chemin du dossier cible]...
STATUT : Restauration accomplie avec succès.
=== FIN DE RESTAURATION (SUCCÈS) : [Date complète] ===
----------------------------------------
Utilisez le code avec précaution.
Si ce cahier des charges correspond à vos attentes pour l'évaluation, précisez-moi :
• Si vous souhaitez inclure une grille de notation vierge sous forme de tableau pour le correcteur.
• S'il y a des contraintes d'espace disque minimal ou de nettoyage des vieilles archives à spécifier dans le document.
