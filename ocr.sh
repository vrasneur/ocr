#!/bin/bash

function find_program {
    if ! hash $1 2>/dev/null; then
	>&2 echo "[!] $2 ('$1') not found"
	exit 1
    fi
}

find_program "pdftk" "pdftk"
find_program "convert" "ImageMagick"
find_program "gs" "Ghostscript"
find_program "tesseract" "Tesseract"

while getopts ":sct:a:" opt; do
    case $opt in
	s)
	    spell=true
	    ;;
	c)
	    concat=true
	    ;;
	t)
	    tlang=$OPTARG
	    ;;
	a)
	    spell=true
	    alang=$OPTARG
	    ;;
	\?)
	    >&2 echo "[!] invalid option: '-$OPTARG'"
	    exit 1
	    ;;
    esac
done

shift $((OPTIND-1))

if [[ "${spell}" = true ]]; then
    find_program "aspell" "Aspell"
fi

if [[ $# -ne 1 ]]; then
    >&2 echo "[!] wrong number of files (got $#)"
    exit 1
fi

if [[ ! -e $1 ]]; then
    >&2 echo "[!] PDF file not found: '$1'"
    exit 1
fi

set -e

fdir=$(basename "$1" .pdf)
fdir=$(basename "${fdir}" .PDF)
mkdir -p "${fdir}"

cd "${fdir}"

echo "[*] splitting PDF"
pdftk ../"$1" burst
rm -f doc_data.txt
printf "[*] found %s page(s)\n" $(ls pg_*.pdf 2>/dev/null | wc -l)
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

if [[ "${concat}" = true ]]; then
    echo "[*] concatenating pages into '${fdir}/${fdir}.txt'"
    cat pg_*.txt > "${fdir}.txt"
    rm pg_*.txt
fi
