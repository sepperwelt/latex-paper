# Vorlage für Belegarbeiten der Fakultät EI an der Hochschule Zittau/Görlitz
Dieses Repository beinhaltet in erster Linie eine neue Klasse `HSZG-Beleg`, die bequem ein Titelblatt für Belegarbeiten der Fakultät EI an der Hochschule Zittau/Görlitz erstellt. Bereitgestellt wird die Klassendefinition samt Logo-Dateien der HSZG sowie ein Beispieldokument mit nützlichen Formatierungen und Code-Beispielen.

Die Klasse stellt ferner auch nützliche Befehle zur Verfügung, um das genaue Zeichensetzen für Abkürzungen sowie mathematischer Shortcuts zu beschleunigen.

## Verwendung
1. Repository clonen
2. Dokument mit der Klasse `HSZG-Beleg` erstellen. Dafür kann die Datei `Belegarbeit.tex` genutzt werden.
3. Externe Quellen (Bilder, `tikz`-Grafiken etc.) in `./assets` ablegen.
4. Bei Bedarf den Inhalt des Dokuments aufteilen. (Im Beispieldokument in `content.tex` ausgelagert.)

## Setup des Dokuments
Um das Dokument einzurichten, steht der Befehl `\SetupTitlePage` zur Verfügung. Der Befehl nimmt folgende Arbumente:

| Schlüssel      | Verwendung                  | Wert |
|----------------|-----------------------------|------|
| `titlelecture` | Titel der Lehrveranstaltung | `{}` |
| `titlepaper`   | Titel des Belegs            | `{}` |
| `author`       | Verfasser                   | `{}` |
| `studyregister`| Matrikel                    | `{}` |
| `studentid`    | Matrikelnummer              | `{}` |
| `examiner`     | Name des Prüfenden          | `{}` |
| `datefinal`    | Abgabedatum                 | `{}` |
| `bibstyle`     | Zitationsstil [^1]          | `num`, `alph` |
| `border`       | Rahmen auf Titelblatt       | -- |
| `sffont`       | serifenlose Schriftart      | -- |
| `labfem`       | weibliche Laboringeneurin   | -- |

[^1]: Der Zitationsstil `num` setzt die `biblatex`-Option `style=ieee`.

> [!NOTE]
> Wird ein Schlüssel nicht angegeben, wird der Text im Dokument rot dargestellt und eine Fehlermeldung ausgegeben.

> [!NOTE]
> Wird die Datei `references.bib` nicht gefunden, wird `biblatex` nicht geladen und kein Literaturverzeichnis erstellt.

## Bereitgestellte Befehle
### Abtürzungen
Die folgenden Befehle stellen gängige Abkürzungen mit korrektem Abstand zur Verfügung:
| Befehl    | Darstellung |
|-----------|-------------|
| `\zb` | z. B. |
| `\ua` | u. a. |
| `\ie` | d. h. |
| `\og` | o. g. |
| `\oa` | o. a. |

### Mathematische Befehle

| Befehl    | Darstellung | Verwendung |
|-----------|:-----------:|------------|
| `\mv{}` | $\boldsymbol{N}$            | fette Zeichen für Matrizen, Vektoren und dgl.           |
| `\kmv{}`    | $\underline{\boldsymbol{N}}$ | fette unterstrichene Zeichen für komplexe Größen |
| `\trans{}` | $\boldsymbol{A}^{\mathrm{T}}$ | Transponierte einer Matrix |
| `\herm{}` | $\boldsymbol{B}^{\mathrm{H}}$ | Transponierte einer konjugiert komplexen Matrix |
| `\rg{}` | $\mathrm{rg}(C)$ | Rang einer Matrix |
| `\re{}` | $\mathrm{Re}(U)$ | Realteil |
| `\im{}` | $\mathrm{Im}(I)$ | Imaginärteil |
| `\K{}`  | $\underline{I}$ | Komplexe Größe |
| `\ident`| $\boldsymbol{I}$ | Einheitsmatrix |
| `\const` | $\mathrm{const.}$ | Konstante |
| `\ii` | $j$ | Imaginäre Einheit |
| `\jw` | $j \, \omega$ | |

### Tabellen
Das Package stellt den Zelltyp `C` als zentrierte `X`-Zelle für Tabellen mit `tabularx` und dgl. bereit.

  
<details>
<summary>Liste der eingebundenen Pakete</summary>

| Package | Option |
|---------|--------|
| `article` |       |
| `silence` |       |
| `keyval` |       |
| `geometry` | `a4paper` `left=2.5cm` `right=2.5cm`      |
| `inputenc` | `utf8`      |
| `babel` | `ngerman`      |
| `grffile` |       |
| `eurosym` |       |
| `amsmath` | `\allowdisplaybreaks`      |
| `amsthm` |       |
| `amssymb` |       |
| `siunitx` | `separate-uncertainty` `\sisetup{locale = DE}`     |
| `physics` |       |
| `ifthen` |       |
| `fancyhdr` | `\pagestyle{fancy}`      |
| `subcaption` |       |
| `caption` |  `justification=centering` `labelfont=bf`     |
| `footmisc` | `bottom`      |
| `todonotes` | `\presetkeys{todonotes}{inline}{}`      |
| `tikz` | `\usetikzlibrary{calc}`      |
| `gnuplot-lua-tikz` |       |
| `circuitikz` |       |
| `lastpage` |       |
| `xspace` |       |
| `parskip` | `skip=10pt` `plus1pt` `indent=10pt`      |
| `makecell` |       |
| `csvsimple` |       |
| `svg` |       |
| `sectsty` |       |
| `csquotes` |       |
| `multicol` |       |
| `setspace` |       |
| `enumitem` | `\setitemize{itemsep=-5pt}` `\setenumerate{itemsep=-5pt}`|
| `pdfpages` | `final`      |
| `graphicx` |       |
| `hyperref` |       |
| `article` | `hidelinks`      |
| `placeins` |       |
| `upgreek` |       |
| `tabularx` |       |
| `longtable` |       |
| `booktabs` |       |
| `nicefrac` |       |
| `biblatex` | `backend=biber      |

</details>

## Verbesserung
Sehr gern können Verbesserungsvorschläge als Issue eingereicht werden.

## Lizenz
Das Repository ist unter der LaTeX Project Public License lizensiert.
