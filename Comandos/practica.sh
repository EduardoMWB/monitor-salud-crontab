#!/usr/bin/env bash
# practica.sh
# Registra la salud del sistema: RAM, disco, carga de CPU y procesos de navegador.

DIR_LOG="$HOME/Reporte_Salud"
LOG="$DIR_LOG/salud.log"
UMBRAL_RAM=80

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
mkdir -p "$DIR_LOG"

FECHA=$(date '+%Y-%m-%d %H:%M:%S')
read -r RAM_TOTAL RAM_USADA < <(free -m | awk '/^Mem:/ {print $2, $3}')
RAM_PCT=$(( RAM_USADA * 100 / RAM_TOTAL ))
DISCO_PCT=$(df -P "$HOME" | awk 'NR==2 {gsub("%","",$5); print $5}')
CARGA=$(cut -d' ' -f1 /proc/loadavg)
NAV=$(pgrep -c -f 'firefox|chrome|chromium' || true)

ESTADO="OK"
[ "$RAM_PCT" -ge "$UMBRAL_RAM" ] && ESTADO="ALERTA_RAM"

echo "$FECHA | RAM=${RAM_PCT}% | DISCO=${DISCO_PCT}% | CARGA=${CARGA} | NAV=${NAV} | ESTADO=${ESTADO}" >> "$LOG"
