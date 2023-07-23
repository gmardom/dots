#!/usr/bin/env bash

file_name="$(realpath "${1}")"
file_mime="$(file --mime -b "${file_name}" | cut -f1 -d';')"

dim_w="${2}"
dim_h="${3}"
pos_x="${4}"
pos_y="${5}"

function prev_image() {
    chafa "${file_name}" \
        --dither diffusion \
        --dither-grain 8x8 \
        --size "${dim_w}x${dim_h}"
    lf -remote "send reload"
}

function prev_text() {
    highlight "${file_name}" \
        --out-format=ansi \
        --line-length=$((dim_w - 4)) \
        --wrap \
        --force
}

case "${file_mime}" in
    image/*) prev_image ;;
    text/*)  prev_text  ;;
    *) echo No preview  ;;
esac
