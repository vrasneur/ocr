ocr.sh: a bash script to OCR PDF files easily
=============================================

Author
------

Vincent Rasneur <vrasneur@free.fr>

Required programs
-----------------

* pdftk
* ghostscript
* imagemagick
* tesseract
* aspell (optional)

Remarks
-------

By default, the script uses the French dictionaries of tesseract and aspell.
Use the `-t` argument to change the tesseract dictionary.
Use the `-a` argument to change the aspell dictionary.

By default, the script does not spell-check the output text. To do this, you must add `-s` (or use the `-a` argument).

Usage
-----

To OCR a PDF file

```bash
ocr.sh document.pdf
```

To OCR a PDF file and spell-check each page

```bash
ocr.sh -s document.pdf
```

To OCR an english PDF and spell-check it

```bash
ocr.sh -t eng -a en document.pdf
```

Output files
------------

For a PDF file named `doc1.pdf`, the script:

* creates a directory named `doc1`
* for each PDF page, a file named `pg_<number>.txt` is created inside this directory

Or, if the `-c` argument is used, the script:

* creates a directory named `doc1`
* creates a unique file named `doc1/doc1.txt`
