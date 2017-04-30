ocr.sh: un script bash pour numériser facilement des documents PDF
==================================================================

Auteur
------

Vincent Rasneur <vrasneur@free.fr>

Programmes nécessaires
----------------------

* bash
* pdftk
* ghostscript
* imagemagick
* tesseract
* aspell (optionnel)

Remarques
---------

le script utilise les dictionnaires français de tesseract et aspell par défaut.
L'argument `-t` contrôle le dictionnaire tesseract.
L'argument `-a` contrôle le dictionnaire aspell.

Le script ne lance pas aspell par défaut, vous devez ajouter `-s` (ou utiliser l'argument `-a`) pour l'activer.

Utilisation
-----------

Numériser un document PDF

```bash
ocr.sh document.pdf
```

Numériser un document et vérifier l'orthographe

```bash
ocr.sh -s document.pdf
```

Numériser un document en anglais et vérifier son orthographe

```bash
ocr.sh -t eng -a en document.pdf
```

Fichiers numérisés
------------------

Pour un document nommé `doc1.pdf`, le script :

* crée un répertoire `doc1`
* pour chaque page du PDF, un fichier `pg_<numéro>.txt` est créé dans ce répertoire

Ou alors, si l'argument `-c` est utilisé, le script :

* crée un répertoire `doc1`
* crée un fichier unique `doc1/doc1.txt`
