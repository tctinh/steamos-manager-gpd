#!/bin/bash
. /usr/lib/tuned/functions

start() {
    /usr/lib/steamos-manager/gpd-set-tdp 15 || return 1
    return 0
}

stop() {
    return 0
}

process $@
