#!/bin/sh

# Rutas relativas a la raíz del proyecto Angular
TEMPLATE_FILE="./src/environments/environment.template"
TARGET_FILE="./src/environments/environment.ts"

echo "Preparando entorno Angular desde template..."

# 1. Detectar variables dinámicas (Prefijo APP_)
# Esto crea un string con formato '$APP_API_URL $APP_VERSION' para envsubst
VARS_A_REEMPLAZAR=$(printf '${%s} ' $(env | grep '^APP_' | cut -d= -f1))

echo "Inyectando las siguientes variables en el build de Angular: $VARS_A_REEMPLAZAR"

# 2. Reemplazo
if [ -f "$TEMPLATE_FILE" ]; then
    envsubst "$VARS_A_REEMPLAZAR" < "$TEMPLATE_FILE" > "$TARGET_FILE"
    echo "Archivo environment.ts generado exitosamente."
else
    echo "ERROR: No se encontró el template en $TEMPLATE_FILE"
    exit 1
fi