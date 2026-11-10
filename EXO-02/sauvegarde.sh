#!/bin/bash
###############################################################################
# SAUVEGARDE - Script d'archivage et de compression d'un repertoire source
# Conforme au cahier des charges EXO-02 (Systeme de sauvegarde et restauration)
###############################################################################

# --- Variables fixes (chemins absolus) ---
REPERTOIRE_SOURCE="/chemin/vers/le/dossier/a/sauvegarder"
REPERTOIRE_DESTINATION="/chemin/vers/le/stockage/des/archives"
FICHIER_LOG="/chemin/vers/le/stockage/des/archives/sauvegarde.log"

# --- Verification des prerequisites ---
if [ ! -d "$REPERTOIRE_SOURCE" ]; then
    MESSAGE="ERREUR : Le dossier source '$REPERTOIRE_SOURCE' est introuvable."
    echo "$MESSAGE" >&2
    {
        echo "=== DÉBUT DU TRAITEMENT : $(date '+%Y-%m-%d %H:%M:%S') ==="
        echo "Heure d'archivage : $(date '+%H:%M:%S')"
        echo "Lien du dossier à archiver : $REPERTOIRE_SOURCE"
        echo "STATUT : ECHEC - Dossier source introuvable."
        echo "=== FIN DU TRAITEMENT (ECHEC) : $(date '+%Y-%m-%d %H:%M:%S') ==="
        echo "----------------------------------------"
    } >> "$FICHIER_LOG" 2>&1
    exit 1
fi

# --- Creation du repertoire de destination si absent ---
mkdir -p "$REPERTOIRE_DESTINATION"

# --- Nom de l'archive horodate (format standardise) ---
NOM_ARCHIVE="sauvegarde_$(date '+%Y-%m-%d_%H-%M').tar.gz"
CHEMIN_ARCHIVE="$REPERTOIRE_DESTINATION/$NOM_ARCHIVE"

# --- Debut du traitement (journalisation) ---
{
    echo "=== DÉBUT DU TRAITEMENT : $(date '+%Y-%m-%d %H:%M:%S') ==="
    echo "Heure d'archivage : $(date '+%H:%M:%S')"
    echo "Lien du dossier à archiver : $REPERTOIRE_SOURCE"
    echo "Creation de l'archive dans : $CHEMIN_ARCHIVE"
} >> "$FICHIER_LOG" 2>&1

# --- Compression et archivage (capture stdout + stderr dans le log) ---
tar -czf "$CHEMIN_ARCHIVE" -C "$(dirname "$REPERTOIRE_SOURCE")" "$(basename "$REPERTOIRE_SOURCE")" >> "$FICHIER_LOG" 2>&1
CODE_RETOUR=$?

# --- Fin du traitement (statut) ---
if [ $CODE_RETOUR -eq 0 ]; then
    {
        echo "STATUT : Sauvegarde reussie."
        echo "=== FIN DU TRAITEMENT (SUCCES) : $(date '+%Y-%m-%d %H:%M:%S') ==="
        echo "----------------------------------------"
    } >> "$FICHIER_LOG" 2>&1
    echo "Sauvegarde realisee avec succes : $CHEMIN_ARCHIVE"
    exit 0
else
    {
        echo "STATUT : ECHEC lors de la creation de l'archive (code $CODE_RETOUR)."
        echo "=== FIN DU TRAITEMENT (ECHEC) : $(date '+%Y-%m-%d %H:%M:%S') ==="
        echo "----------------------------------------"
    } >> "$FICHIER_LOG" 2>&1
    echo "ECHEC de la sauvegarde (code $CODE_RETOUR). Consultez le journal : $FICHIER_LOG" >&2
    exit 1
fi
