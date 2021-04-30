\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sektionsmote}[2021/04/28 Sektionsmotesdokument]

% dependencies
\LoadClass{article}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[swedish]{babel}
\RequirePackage[a4paper,margin=2cm,headheight=52pt,includehead,includefoot]{geometry}
\RequirePackage{graphicx}
\RequirePackage{fancyhdr}
\RequirePackage{comment}
\RequirePackage{enumitem}
\RequirePackage{lastpage}
\RequirePackage{xspace}
\RequirePackage{titlesec}
\RequirePackage{csquotes}

% custom paket för autogenererad bilagslista
\RequirePackage{bilaga}

% options för standardrubriker och dokumenttyper
\newif\if@isprelim@
\newif\if@isslutlig@
\newif\if@isprotokoll@ 
\DeclareOption{prelim}{\@isprelim@true}
\DeclareOption{slutlig}{\@isslutlig@true}
\DeclareOption{protokoll}{\@isprotokoll@true}
\ProcessOptions\relax%

% huvudrubrik
\DeclareRobustCommand*{\title}[1]{\gdef\@title{#1}}
\let\@stitle\@title
\DeclareRobustCommand*{\shorttitle}[1]{\gdef\@stitle{#1}}
\DeclareRobustCommand*{\motesdag}[1]{\day=#1}
\DeclareRobustCommand*{\motesmanad}[1]{\month=#1}
\DeclareRobustCommand*{\motesar}[1]{\year=#1}
\DeclareRobustCommand*{\motesnr}[1]{\gdef\@nr{#1}}
\DeclareRobustCommand*{\motestid}[1]{\gdef\@tid{#1}}
\DeclareRobustCommand*{\motesplats}[1]{\gdef\@plats{#1}}
\DeclareRobustCommand*{\verksamhetsar}[1]{\gdef\@verksamhetsar{#1}}
\newcommand\themote{\@verksamhetsar:SEKT--\@nr}
\renewcommand\maketitle{
    \begin{center}
    \textsc{\Huge Fysikteknologsektionen}\\[0.5cm]
    \textsc{\large \@title\\}
    \textsc{\large \today}\\[0.5cm]
    \textbf{\normalsize Tid: \@tid}\\ 
    \textbf{\normalsize Plats: \@plats}\\[0.5cm]
    \end{center}
    \hypersetup{pdftitle={\@stitle}}
  }
\pagenumbering{arabic}
  

% standardrubriker, dokumentspecifikt
\if@isprelim@%
  \title{Preliminär föredragningslista till sektionsmötet}
  \shorttitle{Preliminär föredragningslista}
\fi%
\if@isslutlig@%
  \title{Slutlig föredragningslista till sektionsmötet}
  \shorttitle{Slutlig föredragningslista}
\fi%
\if@isprotokoll@%
  \RequirePackage{digsig}
  \title{Protokoll fört vid sektionsmöte}
  \shorttitle{Sektionsmötesprotokoll}
\fi%

% sidhuvud/fot
\pagestyle{fancy}
\fancyhead[L]{\includegraphics[height=4\baselineskip]{sektionslogo.png}}
\cfoot{\thepage\ (\pageref*{LastPage})}
\newcommand\makeheader{
    \fancyhead[R]{Möte \themote\\\@stitle\\\emph{Fysikteknologsektionen, Chalmers}}
}

% environments för beslut/ordningsfråga
%\newenvironment{beslut}{\begin{flushleft}\emph{Sektionsmötet beslutar}\textbf{Beslut:}}{\end{flushleft}}
\newenvironment{ofraga}{\begin{flushleft}\textbf{Ordningsfråga:}}{\end{flushleft}}
\newenvironment{beslut}{\begin{flushleft}\emph{Sektionsmötet beslutar}\begin{beslutl}}{\end{beslutl}\end{flushleft}}
\newlist{beslutl}{itemize}{1}
\setlist[beslutl]{label=\textbf{att}}

% lista för föredragningslista
\newlist{ootd}{enumerate}{3}
\setlist[ootd,1]{label=\textsection\arabic*}
\setlist[ootd,2]{label=\alph*)}
\setlist[ootd,3]{label=\roman*)}
\setlist{itemsep=.25\parsep} % gör listor tajtare generellt

% numrera rubriker korrekt (i protokollet)
\renewcommand{\thesection}{\textsection\arabic{section}}
\renewcommand{\thesubsection}{\textsection\arabic{section}\alph{subsection}}
\renewcommand{\thesubsubsection}{\textsection\arabic{section}\alph{subsection} \roman{subsubsection}}

% signaturer
\newcommand{\signatur}[2]{
\begin{minipage}[t][8em]{0.33\textwidth}
    \centering
    \vspace{1.2em}
    \begin{Form}
        \digsigfield{\linewidth}{5.5em}{#1}
    \end{Form}
    \vspace*{-0.2em}
    \hrule
    \vspace{0.5em}
    #1\\
    #2
\end{minipage}
}

% Utility commands för protokoll
\newcommand\tid{\@tid\xspace}

% Undvik spacing runt \paragraph
\titlespacing{\paragraph}{0pt}{*2.5}{\wordsep}
