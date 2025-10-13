#!/bin/bash
set -e

# ---------------------------------------------------------------------------
# Configuration des répertoires
# ---------------------------------------------------------------------------
KEY_DIR="${1:-../mender-keys}"                       # Répertoire pour stocker les clés
LAYER_DIR="/home/stanley/Documents/TM/meta-custom"   # Layer Yocto meta-custom
YOCTO_LAYER_DIR="/home/stanley/Documents/TM/yocto/meta-custom"
GIT_BRANCH="${2:-main}"                              # Branche Git

mkdir -p "$KEY_DIR"

# ---------------------------------------------------------------------------
# Définition des chemins de clés
# ---------------------------------------------------------------------------
PRIVATE_KEY="$KEY_DIR/private.key"
PUBLIC_KEY="$KEY_DIR/public.key"
PRIVATE_ROTATION_KEY="$KEY_DIR/private-rotation.key"
ROTATION_PUBLIC_KEY="$KEY_DIR/public-rotation.key"

# ---------------------------------------------------------------------------
# Étape 1 : Génération initiale de la clé principale si elle n'existe pas
# ---------------------------------------------------------------------------
if [ ! -f "$PRIVATE_KEY" ] || [ ! -f "$PUBLIC_KEY" ]; then
    echo "No main key found. Generating initial main key pair in PKCS#1 format..."
    openssl genrsa -traditional -out "$PRIVATE_KEY" 3072
    openssl rsa -in "$PRIVATE_KEY" -pubout -out "$PUBLIC_KEY"
    echo "Main key pair generated."
fi

# ---------------------------------------------------------------------------
# Étape 2 : Promotion automatique de la clé de rotation existante
# ---------------------------------------------------------------------------
if [ -f "$PRIVATE_ROTATION_KEY" ] && [ -f "$ROTATION_PUBLIC_KEY" ]; then
    echo "Promoting rotation key to main signing key..."
    mv "$PRIVATE_ROTATION_KEY" "$PRIVATE_KEY"
    mv "$ROTATION_PUBLIC_KEY" "$PUBLIC_KEY"
    echo "Promotion done: rotation key is now the main key."
else
    echo "No existing rotation key found. Keeping current main key."
fi

# ---------------------------------------------------------------------------
# Étape 3 : Génération d'une nouvelle paire de rotation en PKCS#1
# ---------------------------------------------------------------------------
echo "Generating new rotation key pair in PKCS#1 format..."
openssl genrsa -traditional -out "$PRIVATE_ROTATION_KEY" 3072
openssl rsa -in "$PRIVATE_ROTATION_KEY" -pubout -out "$ROTATION_PUBLIC_KEY"
echo "New rotation key pair generated."

# ---------------------------------------------------------------------------
# Étape 4 : Copie des clés publiques dans les layers Yocto
# ---------------------------------------------------------------------------
echo "Copying public keys into meta-custom layer..."
mkdir -p "$LAYER_DIR/meta-key/recipes-mender/mender-keys/files"
mkdir -p "$LAYER_DIR/meta-key/recipes-mender/mender-keys-rotation/files"
cp "$PUBLIC_KEY" "$LAYER_DIR/meta-key/recipes-mender/mender-keys/files/public.key"
cp "$ROTATION_PUBLIC_KEY" "$LAYER_DIR/meta-key/recipes-mender/mender-keys-rotation/files/public-rotation.key"
echo "Public keys copied successfully."

# ---------------------------------------------------------------------------
# Étape 5 : Git push dans meta-custom
# ---------------------------------------------------------------------------
cd "$LAYER_DIR"
git add .
git commit -m "Rotate Mender keys $(date +'%Y-%m-%d %H:%M:%S')" || echo "No changes to commit"
git push origin "$GIT_BRANCH"
echo "Changes pushed to branch '$GIT_BRANCH' in meta-custom."

# ---------------------------------------------------------------------------
# Étape 6 : Git pull dans ton environnement Yocto/KAS
# ---------------------------------------------------------------------------
cd "$YOCTO_LAYER_DIR"
git checkout "$GIT_BRANCH"
git pull origin "$GIT_BRANCH"
echo "Yocto meta-custom synchronized with latest keys."

# ---------------------------------------------------------------------------
# Étape 7 : Résumé
# ---------------------------------------------------------------------------
echo "Key rotation completed successfully!"
echo "Main key (.key):        $PUBLIC_KEY"
echo "Rotation key (.key):    $ROTATION_PUBLIC_KEY"
echo "Private key:            $PRIVATE_KEY"
echo "Rotation private:       $PRIVATE_ROTATION_KEY"
echo
echo "Next OTA will be signed with the promoted key."
