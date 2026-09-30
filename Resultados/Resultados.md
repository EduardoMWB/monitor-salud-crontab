# Resultados

El script `Comandos/practica.sh`, programado con crontab cada 2 minutos, escribe una línea en
`~/Reporte_Salud/salud.log` por cada ejecución, con este formato:

```
fecha hora | RAM=<%> | DISCO=<%> | CARGA=<promedio 1 min> | NAV=<procesos de navegador> | ESTADO=OK|ALERTA_RAM
```

| Campo | Significado |
|---|---|
| Fecha/hora | Momento de la medición (`date`) |
| RAM | Porcentaje de memoria usada (`free -m`) |
| DISCO | Porcentaje de uso del disco en la carpeta personal (`df -P`) |
| CARGA | Carga promedio del último minuto (`/proc/loadavg`) |
| NAV | Procesos de navegador activos (`pgrep -c -f`) |
| ESTADO | `OK`, o `ALERTA_RAM` si la RAM supera el 80% |

## Log real registrado por cron

```
2026-09-29 18:39:18 | RAM=19% | DISCO=38% | CARGA=2.51 | NAV=16 | ESTADO=OK
2026-09-29 18:39:41 | RAM=19% | DISCO=38% | CARGA=2.89 | NAV=16 | ESTADO=OK
2026-09-29 18:40:01 | RAM=19% | DISCO=38% | CARGA=2.64 | NAV=16 | ESTADO=OK
```

Las dos primeras líneas se generaron al probar el script a mano; la tercera fue ejecutada por **cron de
forma automática**, tal como se ve en la captura `Evidencias/Terminal_02.png` con `tail -f`.

## Lectura rápida

- **RAM:** se mantuvo estable en 19%, sin acercarse al umbral de alerta (80%).
- **Disco:** estable en 38% de uso.
- **Carga de CPU:** entre 2.51 y 2.89, dentro de lo normal para un equipo con varios núcleos.
- **Navegador:** 16 procesos activos de forma constante (pestañas y procesos auxiliares).
- **Alertas:** ninguna (`grep ALERTA` no devolvió resultados).
