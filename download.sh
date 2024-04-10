#!/bin/bash

# Colores
green='\033[0;32m'
red_bg='\033[0;37;41m' # Blanco con fondo rojo
nc='\033[0m' # No color

# Nombre del archivo que contiene las URLs de los repositorios
repos_file="repos"

# Verifica si el archivo existe
if [ ! -f "$repos_file" ]; then
    echo -e "${red_bg}El archivo $repos_file no existe.${nc}"
    exit 1
fi

# Lee cada URL del archivo y clona el repositorio si no está clonado aún
while IFS= read -r url; do
    # Reemplaza "https://" con "http://"
    url_http=$(echo "$url" | sed 's/https:\/\//http:\/\//')
    repo_name=$(basename "$url_http" .git)
    if [ -d "$repo_name" ]; then
        echo -e "${red_bg}El repositorio $repo_name ya está clonado.${nc}"
    else
        echo -e "${green}Clonando repositorio desde $url_http...${nc}"
        git clone "$url_http"
    fi
done < "$repos_file"
