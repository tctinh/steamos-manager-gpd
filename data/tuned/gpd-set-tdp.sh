#!/bin/bash
# Set TDP on GPD Win Mini via ACPI/ALIB.
# Mirrors the encoding in steamos-manager/src/power.rs (AcpiCallAlibTdpLimitManager)
# using the parameter IDs from data/devices/gpd-win-mini.toml.
#
# Usage: gpd-set-tdp <watts 4-28>

set -euo pipefail

WATTS="${1:-}"
if ! [[ "$WATTS" =~ ^[0-9]+$ ]] || (( WATTS < 4 || WATTS > 28 )); then
    echo "Usage: $0 <watts 4-28>" >&2
    exit 1
fi

ACPI_CALL=/proc/acpi/call
if [[ ! -e "$ACPI_CALL" ]]; then
    echo "$ACPI_CALL not present — load the acpi_call kernel module" >&2
    exit 1
fi
if [[ ! -w "$ACPI_CALL" ]]; then
    echo "$ACPI_CALL not writable by uid $(id -u) — run as root" >&2
    exit 1
fi

ALIB_METHOD='\_SB.ALIB'
ID_STAPM_LIMIT=0x05
ID_FAST_LIMIT=0x06
ID_SLOW_LIMIT=0x07
ID_SLOW_TIME=0x08
ID_STAPM_TIME=0x01
ID_TEMP_TARGET=0x03
ID_SKIN_LIMIT=0x2e

POWER_VAL=$(( WATTS * 1000 ))
SLOW_TIME=10
STAPM_TIME=100
TEMP_TARGET=85

u32_le_hex() {
    local v=$1
    printf '%02x%02x%02x%02x' \
        $(( v & 0xff )) \
        $(( (v >> 8) & 0xff )) \
        $(( (v >> 16) & 0xff )) \
        $(( (v >> 24) & 0xff ))
}

param() {
    printf '%02x%s' "$(( $1 ))" "$(u32_le_hex "$2")"
}

PARAMS=""
PARAMS+=$(param "$ID_STAPM_LIMIT"  "$POWER_VAL")
PARAMS+=$(param "$ID_FAST_LIMIT"   "$POWER_VAL")
PARAMS+=$(param "$ID_SLOW_LIMIT"   "$POWER_VAL")
PARAMS+=$(param "$ID_SLOW_TIME"    "$SLOW_TIME")
PARAMS+=$(param "$ID_STAPM_TIME"   "$STAPM_TIME")
PARAMS+=$(param "$ID_TEMP_TARGET"  "$TEMP_TARGET")
PARAMS+=$(param "$ID_SKIN_LIMIT"   "$POWER_VAL")

SIZE=$(( 2 + 7 * 5 ))
SIZE_HEX=$(printf '%02x%02x' $(( SIZE & 0xff )) $(( (SIZE >> 8) & 0xff )))

printf '%s 0x0c b%s%s' "$ALIB_METHOD" "$SIZE_HEX" "$PARAMS" > "$ACPI_CALL"
