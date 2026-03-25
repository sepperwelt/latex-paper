\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{HSZG-Beleg}[2026/03/25 v1.0 Vorlage für Belegarbeiten an der HSZG]
\LoadClass[a4paper,fleqn,11pt]{article}

\setlength{\headheight}{23pt}
\RequirePackage{silence}
\RequirePackage{keyval}
\RequirePackage[a4paper, left=2.5cm, right=2.5cm]{geometry}
\RequirePackage[utf8]{inputenc}
%\RequirePackage[T1]{fontenc}
\RequirePackage[ngerman]{babel}
\RequirePackage{grffile}
\RequirePackage{eurosym}
\RequirePackage{amsmath, amsthm, amssymb}
\allowdisplaybreaks
\RequirePackage[separate-uncertainty]{siunitx}
\RequirePackage{physics}
\RequirePackage{ifthen}
\RequirePackage{fancyhdr}
\pagestyle{fancy}

\RequirePackage{subcaption}

\RequirePackage[justification=centering,labelfont=bf]{caption}
\RequirePackage[bottom]{footmisc}
\RequirePackage{todonotes}
\presetkeys{todonotes}{inline}{}
\WarningFilter{todonotes}{}

\RequirePackage{tikz}
\RequirePackage{gnuplot-lua-tikz}
\RequirePackage{circuitikz}
\usetikzlibrary{calc}
\RequirePackage{lastpage}
\RequirePackage{xspace}	
\RequirePackage[skip=10pt plus1pt, indent=10pt]{parskip}
\RequirePackage{makecell}
\RequirePackage{csvsimple}
\sisetup{locale = DE}

\RequirePackage{svg}
\RequirePackage{sectsty}
\allsectionsfont{\sffamily}

\RequirePackage{csquotes}
\RequirePackage{multicol}
\RequirePackage{setspace}

\RequirePackage{enumitem}
\setitemize{itemsep=-5pt}
\setenumerate{itemsep=-5pt}
\setlength{\mathindent}{10pt}

\RequirePackage[final]{pdfpages}							% zum einbinden von externen pdf-Seiten
\RequirePackage{graphicx}								%  zum Einbinden von Grafiken, spziell für dvi->ps Konvertierung
\setlength{\unitlength}{1mm}
\RequirePackage[hidelinks]{hyperref}	
\RequirePackage{placeins}								% FloatBarrier
\RequirePackage{upgreek}
\RequirePackage{tabularx}								% schöne tabellen
\RequirePackage{longtable}  								% lange tabellen
%\RequirePackage[osf,sc]{mathpazo}						% Schriftart	
\RequirePackage{booktabs}								% linien in der tabelle
\RequirePackage{nicefrac}								% brüche in zeilen

\RequirePackage{array}
\newcolumntype{C}{>{\centering\arraybackslash}X}

\newcommand\tab[1][0.5cm]{\hspace*{#1}}

\RequirePackage{expl3}
\ExplSyntaxOn

\msg_new:nnnn { HSZG-Beleg } { missing_bib } {'#1'~ nicht~ gefunden.~ Es~ wird~ kein~ Literaturverzeichnis~ erstellt.} {"references.bib"~ wurde~ im~ Stammverzeichnis~ nicht~ gefunden.\\Es~ wird~ kein~ Literaturverzeichnis~ erstellt.\\Das~ Package~ "biblatex"~ wird~ nicht~ geladen.}

\cs_new_protected:Npn \biblio {
    \tl_new:N \l_references_tl
    \tl_set:Nn \l_references_tl {references.bib}


    \bool_if:nTF
        { \file_if_exist_p:V {\l_references_tl} }
        { 
            \RequirePackage[					                % Literaturverzeichnis mit "biber [Projektname ohne Endung]" aktualisieren
                backend=biber,
                style=\tl_use:N \l_bib_style_tl,
            ]{biblatex}                                         % Bibliography management
            \addbibresource{references.bib}                     % Bibliography file
        }
        { 
            \msg_note:nne {HSZG-Beleg}{missing_bib}{\l_references_tl}
        }
}

\AtBeginDocument{\RenewCommandCopy\qty\SI}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% VARIABLEN FÜR VORLAGE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% === Warnung von siunix abschalten ===========================================
\msg_redirect_name:nnn { siunitx } { physics-pkg } { none }

% === Keys deklarieren ========================================================
\tl_new:N \l_titlelecture_tl
\tl_new:N \l_titlepaper_tl
\tl_new:N \l_auth_tl
\tl_new:N \l_studyregister_tl
\tl_new:N \l_studentid_tl
\tl_new:N \l_nameexaminer_tl
\tl_new:N \l_datefinal_tl

\bool_new:N \l_labfem_bool
\bool_set_false:N \l_labfem_bool 
\bool_new:N \l_border_bool
\bool_set_false:N \l_border_bool 

\bool_new:N \g_titlepage_titlelecture_bool
\bool_new:N \g_titlepage_titlepaper_bool
\bool_new:N \g_titlepage_auth_bool
\bool_new:N \g_titlepage_studyregister_bool
\bool_new:N \g_titlepage_studentid_bool
\bool_new:N \g_titlepage_nameexaminer_bool
\bool_new:N \g_titlepage_datefinal_bool

\bool_gset_false:N \g_titlepage_titlelecture_bool
\bool_gset_false:N \g_titlepage_titlepaper_bool
\bool_gset_false:N \g_titlepage_auth_bool
\bool_gset_false:N \g_titlepage_studyregister_bool
\bool_gset_false:N \g_titlepage_studentid_bool
\bool_gset_false:N \g_titlepage_nameexaminer_bool
\bool_gset_false:N \g_titlepage_datefinal_bool

\tl_new:N \l_bib_style_tl
\tl_set:Nn \l_bib_style_tl {alphabetic}

\keys_define:nn { titlepage }{
    titlelecture    .initial:n = {},
    titlelecture    .value_required:n = true,
    titlelecture    .code:n = {
        \bool_gset_true:N \g_titlepage_titlelecture_bool
        \tl_set:Nn \l_titlelecture_tl {#1}
    },
    
    titlepaper        .initial:n = {},
    titlepaper        .value_required:n = true,
    titlepaper        .code:n = {
        \bool_gset_true:N \g_titlepage_titlepaper_bool
        \tl_set:Nn \l_titlepaper_tl {#1}
    },

    author .initial:n = {},
    author .value_required:n = true,
    author .code:n = {
        \bool_gset_true:N \g_titlepage_auth_bool
        \tl_set:Nn \l_auth_tl {#1}    
    },

    studyregister         .initial:n = {},
    studyregister         .value_required:n = true,
    studyregister         .code:n = {
        \bool_gset_true:N \g_titlepage_studyregister_bool
        \tl_set:Nn \l_studyregister_tl {#1}    
    },

    studentid      .initial:n = {},
    studentid      .value_required:n = true,
    studentid      .code:n = {
        \bool_gset_true:N \g_titlepage_studentid_bool
        \tl_set:Nn \l_studentid_tl {#1}
    },

    examiner    .initial:n = {},
    examiner   .value_required:n = true,
    examiner   .code:n = {
        \bool_gset_true:N \g_titlepage_nameexaminer_bool
        \tl_set:Nn \l_nameexaminer_tl {#1}
    },

    datefinal        .initial:n = {},
    datefinal        .value_required:n = true,
    datefinal        .code:n = {
        \bool_gset_true:N \g_titlepage_datefinal_bool
        \tl_set:Nn \l_datefinal_tl {#1}
    },

    labfem          .bool_set:N = \l_labfem_bool,
    labfem          .value_forbidden:n = true,

    sffont          .code:n = {\renewcommand\familydefault\sfdefault},
    sffont          .value_forbidden:n = true,

    bibstyle        .choice:,
    bibstyle / num  .code:n = \tl_set:Nn \l_bib_style_tl {ieee},
    bibstyle / alph .code:n = \tl_set:Nn \l_bib_style_tl {alphabetic},

    border          .bool_set:N = \l_border_bool,
    border          .value_forbidden:n = true,
}

% === Fehlende Keys überprüfen ==========================================

\msg_new:nnnn { HSZG-Beleg } { key-not-set }
    { Schlüssel~`#1'~ist~nicht~gesetzt. }
    { Der~Schlüssel~`#1'~muss~mit~\string\SetupTitlePage~in~der~Präambel~gesetzt~werden.}

\cs_new_protected:Npn \check_keys {
    \bool_if:NF \g_titlepage_titlelecture_bool{
        \msg_warning:nnn { HSZG-Beleg } { key-not-set } { titlelecture }
        \tl_set:Nn \l_titlelecture_tl {\textcolor{red}{Titel~der~Lehrveranstaltung}}
        \RenewDocumentCommand{\titlelecture}{}{\tl_use:N \l_titlelecture_tl}
    }

    \bool_if:NF \g_titlepage_titlepaper_bool{
        \msg_warning:nnn { HSZG-Beleg } { key-not-set } { titlepaper }
        \tl_set:Nn \l_titlepaper_tl {\textcolor{red}{Titel~ des~ Belegs}}
        \RenewDocumentCommand{\titlepaper}{}{\tl_use:N \l_titlepaper_tl}
    }

    \bool_if:NF \g_titlepage_auth_bool{
        \msg_warning:nnn { HSZG-Beleg } { key-not-set } { author }
        \tl_set:Nn \l_auth_tl {\textcolor{red}{Müller}}
        \RenewDocumentCommand{\auth}{}{\tl_use:N \l_auth_tl}
    }

    \bool_if:NF \g_titlepage_studyregister_bool{
        \msg_warning:nnn { HSZG-Beleg } { key-not-set } { studyregister }
        \tl_set:Nn \l_studyregister_tl {\textcolor{red}{Matrikel}}
        \RenewDocumentCommand{\studyregister}{}{\tl_use:N \l_studyregister_tl}
    }

    \bool_if:NF \g_titlepage_studentid_bool{
        \msg_warning:nnn { HSZG-Beleg } { key-not-set } { studentid }
        \tl_set:Nn \l_studentid_tl {\textcolor{red}{Matrikelnummer}}
        \RenewDocumentCommand{\studentid}{}{\tl_use:N \l_studentid_tl}
    }

    \bool_if:NF \g_titlepage_nameexaminer_bool{
        \msg_warning:nnn { HSZG-Beleg } { key-not-set } { examiner }
        \tl_set:Nn \l_nameexaminer_tl {\textcolor{red}{Muster}}
        \RenewDocumentCommand{\nameexaminer}{}{\tl_use:N \l_nameexaminer_tl}
    }

    \bool_if:NF \g_titlepage_datefinal_bool{
        \msg_warning:nnn { HSZG-Beleg } { key-not-set } { datefinal }
        \tl_set:Nn \l_datefinal_tl {\textcolor{red}{Abgabedatum}}
        \RenewDocumentCommand{\datefinal}{}{\tl_use:N \l_datefinal_tl}
    }

    \bool_if:NT \l_labfem_bool {
        \RenewDocumentCommand{\examiner}{}{Prüferin}
    }
}

% === Setup-Befehl =============================================================

\NewDocumentCommand{\SetupTitlePage}{m}{
    \keys_set:nn {titlepage}{#1}
    \check_keys
    \biblio
    \author{\auth}

    % === Rahmen zeichnen ===================================================
    \NewDocumentCommand{\border}{}{\newgeometry{left=2.5cm, right=2.5cm,top=1.8cm,bottom=0.1cm}}

    \bool_if:NT \l_border_bool {
        \RenewDocumentCommand{\border}{}{
            \newgeometry{left=2.5cm, right=2.5cm,top=1cm,bottom=0.1cm}
            \begin{tikzpicture}[remember~ picture, overlay]
                \draw[line~ width = 1pt] ($(current~ page.north~ west) + (20mm,-15mm)$) rectangle ($(current~ page.south~ east) + (-20mm,15mm)$);
                \draw[line~ width = 1pt] ($(current~ page.north~ west)+ (20mm,-36mm)$) -- ($(current~ page.north~ west)+ (190mm,-36mm)$);
            \end{tikzpicture}
        }
    }
}

\NewDocumentCommand{\titlelecture}{}{\tl_use:N \l_titlelecture_tl}
\NewDocumentCommand{\titlepaper}{}{\tl_use:N \l_titlepaper_tl}
\NewDocumentCommand{\auth}{}{\tl_use:N \l_auth_tl}
\NewDocumentCommand{\studyregister}{}{\tl_use:N \l_studyregister_tl}
\NewDocumentCommand{\studentid}{}{\tl_use:N \l_studentid_tl}
\NewDocumentCommand{\nameexaminer}{}{\tl_use:N \l_nameexaminer_tl}
\NewDocumentCommand{\examiner}{}{Prüfer}
\NewDocumentCommand{\datefinal}{}{\tl_use:N \l_datefinal_tl}


% === Fehlende Logo-Dateien ====================================================

\msg_new:nnn { HSZG-Beleg } { missing_logo } {Logo\ "#1"\ fehlt!}

\tl_new:N \l_hszg_tl
\tl_set:Nn \l_hszg_tl {assets/images/HSZG.svg}
\cs_new_protected:Npn \FileHszgTest{
    \bool_if:nTF
        { \file_if_exist_p:V \l_hszg_tl }
        { \includesvg[height=1.5cm]{\tl_use:N \l_hszg_tl} }
        { 
            \todo[color=red]{Logo\ \texttt{HSZG.svg}\ fehlt!}
            \msg_error:nne{HSZG-Beleg}{missing_logo}{\l_hszg_tl}
        }
} 

\tl_new:N \l_fei_tl
\tl_set:Nn \l_fei_tl {assets/images/f-ei.png}
\cs_new_protected:Npn \FileFEITest{
    \bool_if:nTF
        { \file_if_exist_p:V \l_fei_tl }
        { \includegraphics[height=1.4cm]{\tl_use:N \l_fei_tl}}
        { 
            \todo[color=red]{Logo\ \texttt{f-ei.png}\ fehlt!}
            \msg_error:nne{HSZG-Beleg}{missing_logo}{\l_fei_tl}
        }
} 

\ExplSyntaxOff

% === gebräuchliche Abkürzungen etc. ===========================================

% ---------------Mathematisches----------------------------->
\newcommand{\mv}[1]{\ensuremath{\boldsymbol{#1}}}               %  fett dargestellte Zeichen im Mathematikmodus, Matrizen, Vektoren
\newcommand{\kmv}[1]{\ensuremath{\underline{\boldsymbol{#1}}}}  %  fett dargestellte unterstrichene Zeichen im Mathematikmodus
\newcommand{\trans}[1]{\ensuremath{\boldsymbol{#1}^{\mathrm{T}}}} %  Transponierte einer Matrix
\newcommand{\herm}[1]{\ensuremath{\boldsymbol{#1}^{\mathrm{H}}}} %  Transponierte der konjugiert komplexen Matrix
\newcommand{\rg}[1]{\ensuremath{\mathrm{rg}\left({#1}\right)}}  %  Rang Matrix
\newcommand{\re}[1]{\mathrm{Re}\left\{  #1 \right\} }           %  Realteil
\newcommand{\im}[1]{\mathrm{Im}\left\{  #1 \right\} }           %  Imaginärteil
\newcommand{\K}[1]{\underline{#1}}                              %  Unterstreichung ... komplex
\newcommand{\ident}{\mv{I}}	                                    %  Einheitsmatrix							
\newcommand{\const}{\mathrm{const.}}			                %  const. im Mathematikmodus							
\newcommand{\ii}{j}		                                        %  imaginäre Einheit
\newcommand{\jw}{\ii \, \omega}						            %  imaginäre Einheit * omega										

% --------------- Abkürzungen ------------------------------>
\newcommand{\zb}{\mbox{z.\,B.}\xspace}		%  Erzeugt z.B. mit korrektem Zwischenraum
\newcommand{\ua}{\mbox{u.\,a.}\xspace}		%  Erzeugt u.a. mit korrektem Zwischenraum
\newcommand{\ie}{\mbox{d.\,h.}\xspace}		%  Erzeugt d.h. mit korrektem Zwischenraum
\newcommand{\og}{\mbox{o.\,g.}\xspace}		%  Erzeugt o.g. mit korrektem Zwischenraum
\newcommand{\oa}{\mbox{o.\,a.}\xspace}		%  Erzeugt o.a. mit korrektem Zwischenraum
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\lhead{} 
\chead{} 
\rhead{} 

\lfoot{} \cfoot{} \rfoot{\footnotesize Seite \thepage\ von \pageref{LastPage}} 
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0.4pt}
\addto\captionsngerman{\renewcommand{\figurename}{Abb.}}
\addto\captionsngerman{\renewcommand{\tablename}{Tab.}}
%\captionsetup{justification = raggedright}

\AddToHook{begindocument/end}{
    \begin{titlepage}
        \border

        \begin{center}

            % Upper part of the page
            \begin{minipage}[t][2cm]{\textwidth}
                \begin{minipage}[b][1.5cm]{0.33\textwidth}
                    \FileHszgTest
                \end{minipage}
                \hfill
                \begin{minipage}[b][1.5cm][c]{0.55\textwidth}
                    \vspace*{\fill}
                    \centering
                    \textbf{\sffamily\large Fakultät\\ Elektrotechnik / Informatik}\\
                    Fachbereich Elektrotechnik
                    \vspace*{\fill}
                \end{minipage}
                \begin{minipage}[b][1.5cm]{0.1\textwidth}
                    \FileFEITest
                \end{minipage}
            \end{minipage}
            %\newline

            \sffamily
            \vspace{3cm}
            {\large\textbf{Belegarbeit zur Lehrveranstaltung \\\vspace{1em} \titlelecture}}

            \vspace{3cm}
            zum Thema \\
            \vspace{1em}
            {\Large\textbf{\titlepaper}}

            \vspace{5cm}

            \begin{center}
                \begin{minipage}[t]{\textwidth}
                    \begin{minipage}[t][0.5cm]{0.5\textwidth}
                        \raggedleft
                        \textbf{Verfasser}
                        \vspace{0.5em}

                        \textbf{Seminargruppe}
                        \vspace{0.5em}

                        \textbf{Matrikelnummer}
                        \vspace{0.5em}

                        \textbf{\examiner}
                        \vspace{3cm}

                        \textbf{Abgabedatum} 
                    \end{minipage}
                    \hspace{0.5cm}
                    \begin{minipage}[t][0.5cm]{0.5\textwidth}
                        \auth
                        \vspace{0.5em}

                        \studyregister
                        \vspace{0.5em}

                        \studentid
                        \vspace{0.5em}

                        \nameexaminer
                        \vspace{3cm}

                        \datefinal
                    \end{minipage}
                \end{minipage}
            \end{center}

        \end{center}

    \end{titlepage}

    \renewcommand{\baselinestretch}{1.5} 
    \newgeometry{left=2.5cm, right=2.5cm,top=2.5cm,bottom=2.5cm}
}