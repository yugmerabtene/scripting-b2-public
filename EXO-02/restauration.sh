#!/bin/bash
###############################################################################
# RESTAURATION - Script interactif de decompression d'une archive sauvegardee
# Conforme au cahier des charges EXO-02 (Systeme de sauvegarde et restauration)
###############################################################################

FICHIER_LOG="/chemin/vers/le/stockage/des/archives/restauration.log"

# --- Saisie utilisateur : chemin de l'archive ---
read -p "Chemin de l'archive a restaurer : " ARCHIVE_SOURCE

# --- Validation de la presence physique du fichier archive ---
if [ ! -f "$ARCHIVE_SOURCE" ]; then
    {
        echo "=== DÉBUT DE RESTAURATION : $(date '+%Y-%m-%d %H:%M:%S') ==="
        echo "Archive selectionnee : $ARCHIVE_SOURCE"
        echo "STATUT : ECHEC - L'archive especinee est introuvable."
        echo "=== FIN DE RESTAURATION (ECHEC) : $(date '+%Y-%m-%d %H:%M:%S') ==="
        echo "----------------------------------------"
    } >> "$FICHIER_LOG" 2>&1
    echo "ECHEC : L'archive '$ARCHIVE_SOURCE' est introuvable." >&2
    exit 1
fi

# --- Saisie utilisateur : dossier cible ---
read -p "Dossier cible de restauration : " DOSSIER_CIBLE

# --- Gestion intelligente du dossier de destination ---
if [ -e "$DOSSIER_CIBLE" ]; then
    if [ -d "$DOSSIER_CIBLE" ] && [ "$(ls -A "$DOSSIER_CIBLE" 2>/dev/null)" ]; then
        echo "ATTENTION : Le dossier '$DOSSIER_CIBLE' contient deja des donnees."
        read -p "Voulez-vous continuer et ecraser les donnees existantes ? (o/n) : " REPONSE
        if [ "$REPONSE" != "o" ] && [ "$REPONSE" != "O" ]; then
            {
                echo "=== DÉBUT DE RESTAURATION : $(date '+%Y-%m-%d %H:%M:%S') ==="
                echo "Archive selectionnee : $ARCHIVE_SOURCE"
                echo "Lien vers le dossier restaure : $DOSSIER_CIBLE"
                echo "STATUT : ECHEC - Restauration annulee par l'utilisateur (dossier non vide)."
                echo "=== FIN DE RESTAURATION (ECHEC) : $(date '+%Y-%m-%d %H:%M:%S') ==="
                echo "----------------------------------------"
            } >> "$FICHIER_LOG" 2>&1
            echo "Restauration annulee."
            exit 1
        fi
    fi
else
    # Creation automatique du dossier cible s'il est absent
    mkdir -p "$DOSSIER_CIBLE"
    if [ $? -ne 0 ]; then
        {
            echo "=== DÉBUT DE RESTAURATION : $(date '+%Y-%m-%d %H:%M:%S') ==="
            echo "Archive selectionnee : $ARCHIVE_SOURCE"
            echo "Lien vers le dossier restaure : $DOSSIER_CIBLE"
            echo "STATUT : ECHEC - Impossible de creer le dossier cible."
            echo "=== FIN DE RESTAURATION (ECHEC) : $(date '+%Y-%m-%d %H:%M:%S') ==="
            echo "----------------------------------------"
        } >> "$FICHIER_LOG" 2>&1
        echo "ECHEC : Impossible de creer le dossier '$DOSSIER_CIBLE'." >&2
        exit 1
    fi
fi

# --- Debut de restauration (journalisation) ---
{
    echo "=== DÉBUT DE RESTAURATION : $(date '+%Y-%m-%d %H:%M:%S') ==="
    echo "Archive selectionnee : $ARCHIVE_SOURCE"
    echo "Lien vers le dossier restaure : $DOSSIER_CIBLE"
    echo "Extraction des fichiers vers $DOSSIER_CIBLE..."
} >> "$FICHIER_LOG" 2>&1

# --- Extraction de l'archive (capture stdout + stderr dans le log) ---
tar -xzf "$ARCHIVE_SOURCE" -C "$DOSSIER_CIBLE" >> "$FICHIER_LOG" 2>&1
CODE_RETOUR=$?

# --- Rapport de fin ---
if [ $CODE_RETOUR -eq 0 ]; then
    {
        echo "STATUT : Restauration accomplie avec succes."
        echo "=== FIN DE RESTAURATION (SUCCES) : $(date '+%Y-%m-%d %H:%M:%S') ==="
        echo "----------------------------------------"
    } >> "$FICHIER_LOG" 2>&1
    echo "Restauration accomplie avec succes dans : $DOSSIER_CIBLE"
    exit 0
else
    {
        echo "STATUT : ECHEC lors de l'extraction (code $CODE_RETOUR)."
        echo "=== FIN DE RESTAURATION (ECHEC) : $(date '+%Y-%m-%d %H:%M:%S') ==="
        echo "----------------------------------------"
    } >> "$FICHIER_LOG" 2>&1
    echo "ECHEC de la restauration (code $CODE_RETOUR). Consultez le journal : $FICHIER_LOG" >&2
    exit 1
fi
