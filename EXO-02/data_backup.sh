#!/bin/bash
###############################################################################
# data_backup.sh — Sauvegarde et restauration simple du dossier "data"
#
# EXO-02 : un seul script Bash, pas de journalisation externe, pas de cron.
# Noté sur 5 points :
#   1. Archivage .tar.gz horodaté du dossier data
#   2. Gestion des erreurs (dossier manquant, archive introuvable)
#   3. Restauration interactive (choix de l'archive et du dossier cible)
#   4. Integrite de l'archive (controle tar -tzf avant et apres operation)
#   5. Rapport de fin (message clair succes ou echec detaille)
#
# Usage :
#   ./data_backup.sh save      # archive le dossier ./data
#   ./data_backup.sh restore   # restaure une archive de maniere interactive
###############################################################################

# =============================================================================
# CONFIGURATION — chemins fixes (a adapter selon votre environnement)
# =============================================================================

# Dossier specifique a sauvegarder (chemin relatif ou absolu)
DOSSIER_DATA="./data"

# Repertoire ou sont stockees les archives creees
REPERTOIRE_ARCHIVES="./archives"

# =============================================================================
# FONCTIONS UTILITAIRES
# =============================================================================

# Affiche un message de succes sur la sortie standard
afficher_succes() {
    echo "Succès : $1"
}

# Affiche un message d'erreur sur la sortie d'erreur et arrete le script
afficher_erreur_et_sortir() {
    echo "Échec : $1" >&2
    exit 1
}

# Verifie l'integrite d'une archive .tar.gz (liste son contenu sans l'extraire)
# Retourne 0 si l'archive est valide, 1 sinon
verifier_integrite_archive() {
    local archive="$1"
    tar -tzf "$archive" >/dev/null 2>&1
}

# =============================================================================
# MODE SAUVEGARDE — archive le dossier "data"
# =============================================================================

mode_save() {
    echo "[Sauvegarde] Demarrage de l'archivage du dossier '$DOSSIER_DATA'..."

    # 1. Verifier que le dossier source existe
    if [ ! -d "$DOSSIER_DATA" ]; then
        afficher_erreur_et_sortir "Le dossier '$DOSSIER_DATA' est introuvable."
    fi

    # 2. Creer le repertoire de stockage s'il n'existe pas
    mkdir -p "$REPERTOIRE_ARCHIVES" 2>/dev/null || \
        afficher_erreur_et_sortir "Impossible de creer le repertoire '$REPERTOIRE_ARCHIVES'."

    # 3. Construire le nom de l'archive avec horodatage (AAAA-MM-JJ_HH-MM)
    local nom_archive
    nom_archive="sauvegarde_data_$(date '+%Y-%m-%d_%H-%M').tar.gz"
    local chemin_archive="$REPERTOIRE_ARCHIVES/$nom_archive"

    # 4. Creer l'archive compressee
    tar -czf "$chemin_archive" \
        -C "$(dirname "$DOSSIER_DATA")" \
        "$(basename "$DOSSIER_DATA")"

    local code_retour=$?

    # 5. Verifier que la creation a reussi
    if [ $code_retour -ne 0 ]; then
        afficher_erreur_et_sortir "Impossible de creer l'archive (code $code_retour)."
    fi

    # 6. Verifier l'integrite de l'archive juste creee
    if ! verifier_integrite_archive "$chemin_archive"; then
        afficher_erreur_et_sortir "L'archive creee est corrompue ou illisible."
    fi

    afficher_succes "archive creee -> $chemin_archive"
    exit 0
}

# =============================================================================
# MODE RESTAURATION — restaure une archive de maniere interactive
# =============================================================================

mode_restore() {
    echo "[Restauration] Demarrage de la restauration interactive..."

    # 1. Demander le chemin de l'archive a restaurer
    local archive_source
    read -p "Chemin de l'archive a restaurer : " archive_source

    # 2. Verifier que l'archive existe physiquement
    if [ ! -f "$archive_source" ]; then
        afficher_erreur_et_sortir "L'archive '$archive_source' est introuvable."
    fi

    # 3. Verifier l'integrite de l'archive avant extraction
    if ! verifier_integrite_archive "$archive_source"; then
        afficher_erreur_et_sortir "L'archive '$archive_source' est corrompue ou illisible."
    fi

    # 4. Demander le dossier cible de restauration
    local dossier_cible
    read -p "Dossier cible de restauration : " dossier_cible

    # 5. Creer le dossier cible automatiquement s'il est absent
    mkdir -p "$dossier_cible" 2>/dev/null || \
        afficher_erreur_et_sortir "Impossible de creer le dossier '$dossier_cible'."

    # 6. Extraire l'archive dans le dossier cible
    tar -xzf "$archive_source" -C "$dossier_cible"
    local code_retour=$?

    # 7. Verifier que l'extraction a reussi
    if [ $code_retour -ne 0 ]; then
        afficher_erreur_et_sortir "Extraction de l'archive echequee (code $code_retour)."
    fi

    afficher_succes "restauration terminee dans -> $dossier_cible"
    exit 0
}

# =============================================================================
# POINT D'ENTREE
# =============================================================================

case "$1" in
    save)
        mode_save
        ;;
    restore)
        mode_restore
        ;;
    *)
        echo "Usage : $0 {save|restore}" >&2
        echo "  save    : archive le dossier '$DOSSIER_DATA'" >&2
        echo "  restore : restaure une archive de maniere interactive" >&2
        exit 1
        ;;
esac
