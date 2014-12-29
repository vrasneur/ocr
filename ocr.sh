#!/bin/bash

fdir=$(basename "$1" .pdf)
mkdir -p "${fdir}"

cd "${fdir}"

echo "[*] splitting PDF"
pdftk ../"$1" burst
rm -f doc_data.txt
for i in pg_*.pdf; do
    pref=$(basename ${i} .pdf)
    echo "[*] convert ${pref}"
    gs -r300 -dINTERPOLATE -q -dNOPAUSE -sDEVICE=png16m -sOutputFile="${pref}.png" ${i} -c quit
    echo "[*] normalize ${pref}"
    convert "${pref}.png" -modulate 120,0 "${pref}.ok.png"
    echo "[*] ocr ${pref}"
    tesseract "${pref}.ok.png" "${pref}" -l "${tlang:=fra}"

    if [[ "${spell}" = true || -n "${alang}" ]]; then
        aspell check "${pref}.txt" -l "${alang:=fr}"
    fi
done

echo "[*] cleaning"
rm pg_*.png
rm pg_*.pdf
