#!/bin/bash
###############################################################################
# data_backup.sh — Sauvegarde et restauration simple du dossier "data"
# EXO-02 : un seul script, pas de log, pas de cron, noté sur 5
###############################################################################

# --- Configuration : dossier spécifique à sauvegarder ---
DOSSIER_DATA="./data"
REPERTOIRE_ARCHIVES="./archives"

# --- Création du répertoire d'archives si nécessaire ---
mkdir -p "$REPERTOIRE_ARCHIVES"

mode="$1"

###############################################################################
# MODE SAUVEGARDE : archive le dossier "data"
###############################################################################
save() {
    # Vérification de l'existence du dossier data
    if [ ! -d "$DOSSIER_DATA" ]; then
        echo "ERREUR : Le dossier '$DOSSIER_DATA' est introuvable." >&2
        echo "Échec : dossier source absent." >&2
        exit 1
    fi

    # Nom de l'archive horodaté
    NOM_ARCHIVE="sauvegarde_data_$(date '+%Y-%m-%d_%H-%M').tar.gz"
    CHEMIN_ARCHIVE="$REPERTOIRE_ARCHIVES/$NOM_ARCHIVE"

    # Compression
    tar -czf "$CHEMIN_ARCHIVE" -C "$(dirname "$DOSSIER_DATA")" "$(basename "$DOSSIER_DATA")"
    CODE=$?

    if [ $CODE -eq 0 ]; then
        # Vérification de l'intégrité de l'archive créée
        tar -tzf "$CHEMIN_ARCHIVE" >/dev/null 2>&1
        if [ $? -ne 0 ]; then
            echo "Échec : l'archive créée est corrompue ou illisible." >&2
            exit 1
        fi
        echo "Succès : archive créée -> $CHEMIN_ARCHIVE"
        exit 0
    else
        echo "Échec : impossible de créer l'archive (code $CODE)." >&2
        exit 1
    fi
}

###############################################################################
# MODE RESTAURATION : restaure une archive de manière interactive
###############################################################################
restore() {
    # Saisie du chemin de l'archive
    read -p "Chemin de l'archive à restaurer : " ARCHIVE_SOURCE

    # Vérification de la présence du fichier archive
    if [ ! -f "$ARCHIVE_SOURCE" ]; then
        echo "Échec : l'archive '$ARCHIVE_SOURCE' est introuvable." >&2
        exit 1
    fi

    # Saisie du dossier cible
    read -p "Dossier cible de restauration : " DOSSIER_CIBLE

    # Gestion du dossier cible : création automatique si absent, écrasement direct sinon
    mkdir -p "$DOSSIER_CIBLE" 2>/dev/null
    if [ $? -ne 0 ]; then
        echo "Échec : impossible de créer le dossier '$DOSSIER_CIBLE'." >&2
        exit 1
    fi

    # Vérification de l'intégrité de l'archive avant extraction
    tar -tzf "$ARCHIVE_SOURCE" >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "Échec : l'archive '$ARCHIVE_SOURCE' est corrompue ou illisible." >&2
        exit 1
    fi

    # Extraction
    tar -xzf "$ARCHIVE_SOURCE" -C "$DOSSIER_CIBLE"
    CODE=$?

    if [ $CODE -eq 0 ]; then
        echo "Succès : restauration terminée dans -> $DOSSIER_CIBLE"
        exit 0
    else
        echo "Échec : extraction de l'archive échouée (code $CODE)." >&2
        exit 1
    fi
}

###############################################################################
# Point d'entrée
###############################################################################
case "$mode" in
    save)
        save
        ;;
    restore)
        restore
        ;;
    *)
        echo "Usage : $0 {save|restore}" >&2
        echo "  save    : archive le dossier 'data'"
        echo "  restore : restaure une archive de manière interactive" >&2
        exit 1
        ;;
esac
