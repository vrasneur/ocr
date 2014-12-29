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
La variable `tlang` contrôle le dictionnaire tesseract.
La variable `alang` contrôle le dictionnaire aspell.

Le script ne lance pas aspell par défaut, vous devez ajouter `spell=true` (ou utiliser la variable `alang`) pour l'activer.

Utilisation
-----------

Numériser un document PDF

```bash
ocr.sh document.pdf
```

Numériser un document et vérifier l'orthographe

```bash
spell=true ocr.sh document.pdf
```

Numériser un document en anglais et vérifier son orthographe

```bash
tlang=eng alang=en ocr.sh document.pdf
```

Fichiers numérisés
------------------

Pour un document nommé `doc1.pdf`, le script :

* crée un répertoire `doc1`
* pour chaque page du PDF, un fichier `pg_<numéro>.txt` est créé dans ce répertoire
