%
% File    : oxengthesis.cls
% Author  : Mauricio Villarroel
% Created : Sept 6, 2013
% ____________________________________________________________________________
%
% Copyright (C) 2013-2022 Mauricio Villarroel. All rights reserved.
%
% SPDX-License-Identifer:  GPL-2.0-only
% ____________________________________________________________________________
%
% DESCRIPTION :
%
% Latex template for a DPhil/PhD thesis or a project report
% ____________________________________________________________________________


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{oxengthesis}[2022/11/09 version 0.11 - Oxford Engineering thesis class by Mauricio Villarroel]


% ____________________________________________________________________________
%
% Configure the package options for memoir
% ____________________________________________________________________________


\DeclareOption{10pt}{
    \PassOptionsToClass{\CurrentOption}{memoir}
}

\DeclareOption{a4paper}{
    \PassOptionsToClass{\CurrentOption}{memoir}
}

\DeclareOption{openany}{
    \PassOptionsToClass{\CurrentOption}{memoir}
}


% Pass all other the options to the memoir class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}

\ExecuteOptions{10pt,a4paper,openany}

\ProcessOptions\relax

\LoadClass[onecolumn,twoside,final]{memoir}


% ____________________________________________________________________________
%
% Local package options
% ____________________________________________________________________________


\RequirePackage{kvoptions}

\SetupKeyvalOptions%
{
    family=OxEngThesis,
    prefix=OxEngThesis@
}


% Option to format a 4th Year Project (4YP) report
% If not declared, the default will be to format the document for a 
% DPhil thesis
\DeclareBoolOption{report}

% Review mode, which will format the text in \DoubleSpacing
\DeclareBoolOption{review}

% Include a short table of contents in each chapter
\DeclareBoolOption{chaptertoc}

% To show page layout errors
\DeclareBoolOption{debuglayout}

% Create the stand-alone abstract page for Oxford's Examination Schools
\DeclareBoolOption{frontabstract}

% Main font for all the text
\DeclareStringOption[Carlito]{font}

% Font for equations
\DeclareStringOption[Latin Modern Math]{mathfont}

% Colour for section and subsection headings
\DeclareStringOption[{0,0,0}]{headingcolour}

% Page layout margins
\DeclareStringOption[4cm]{leftmargin}
\DeclareStringOption[2cm]{rightmargin}
\DeclareStringOption[2cm]{topmargin}
\DeclareStringOption[2.5cm]{bottommargin}


\DeclareStringOption[defaultchapterstyle]{chapterstyle}

\ProcessKeyvalOptions{OxEngThesis}


% ____________________________________________________________________________
%
% Basic LaTeX configuration
% ____________________________________________________________________________


\RequirePackage{textcomp}
\RequirePackage[base]{babel}
\RequirePackage{lipsum}


% Custom colours

\RequirePackage{color}


% TODO tags

\newcommand{\todo}[1]{\textcolor{red}{@TODO: #1}}


% Font configuration

\RequirePackage{fontspec}
\setmainfont{\OxEngThesis@font}


% No hyphenation for the main text,
% but allow hyphenation for text typeset via either \texttt or \ttfamily
% such as source code listings

\RequirePackage[htt]{hyphenat}


% Configure math environment

\RequirePackage{amsmath}
\RequirePackage{unicode-math}
\setmathfont{\OxEngThesis@mathfont}


% Don't let figures and other floats past their sections

\RequirePackage[section,below]{placeins}


% Define a generic space

\RequirePackage{xspace}


% ____________________________________________________________________________
%
% Format page margins
% ____________________________________________________________________________


\settypeoutlayoutunit{cm}


% Define the margins

\newlength{\myleftmargin}
\newlength{\myrightmargin}
\newlength{\mytopmargin}
\newlength{\mybottommargin}

\setlength{\myleftmargin}{\OxEngThesis@leftmargin}
\setlength{\myrightmargin}{\OxEngThesis@rightmargin}
\setlength{\mytopmargin}{\OxEngThesis@topmargin}
\setlength{\mybottommargin}{\OxEngThesis@bottommargin}


% Setup the page layout

\setlrmarginsandblock{\myleftmargin}{\myrightmargin}{*} 

\newlength{\linespace}
\setlength{\linespace}{\baselineskip} % current equivalent of \onelineskip

\setlength{\headheight}{\onelineskip}
\setlength{\headsep}{2\linespace}

\setlength{\uppermargin}{\mytopmargin}
\addtolength{\uppermargin}{\headheight}
\addtolength{\uppermargin}{\headsep}

\setlength{\lowermargin}{\mybottommargin}

\setlength{\textheight}{\paperheight}
\addtolength{\textheight}{-\uppermargin}
\addtolength{\textheight}{-\lowermargin}


%% footnote settings

\setlength{\footskip}{\onelineskip}
\setlength{\footnotesep}{\onelineskip}

\setulmarginsandblock{\uppermargin}{\lowermargin}{*}

\checkandfixthelayout[nearest]


% ____________________________________________________________________________
%
% Page layout
% ____________________________________________________________________________


% Paragraph indentation

\setlength{\parindent}{2em}


% Widows and orphans

\RequirePackage{nowidow}

\flushbottom


% Debugging page layout

\ifOxEngThesis@debuglayout

    % Used temporarily for checking layout
    \RequirePackage{layout}

    % Show overfull errors
    \overfullrule=5pt
    
\fi


% ____________________________________________________________________________
%
% Format tables
% ____________________________________________________________________________


\RequirePackage{makecell}
\RequirePackage{multirow}
\RequirePackage[table]{xcolor}
\RequirePackage{array}


% Custom background colour for headers

\definecolor{TableHeaderBackColor}{rgb}{0.9,0.9,0.9}


% Standard table row heights

\setlength{\extrarowheight}{2pt}

\newcommand\smallTableRowHeight{\setlength{\extrarowheight}{0pt}}

\newcommand\singleTableRowHeight{\setlength{\extrarowheight}{2pt}}

\newcolumntype{+}{>{\global\let\currentrowstyle\relax}}
\newcolumntype{^}{>{\currentrowstyle}}
\newcommand{\tableheaderstyle}{
  \rowcolor{TableHeaderBackColor}
  \gdef\currentrowstyle{\bfseries}\bfseries\ignorespaces
}

\newcommand\tableHeaderStart{
  \hline
  \tableheaderstyle
}

\newcommand\tableHeaderEnd{\hline}

\newcommand\tableHCell[1]{
  {\singleTableRowHeight
   \begin{tabular}{c}
     \textbf{#1}
   \end{tabular}
  }
}

\newcommand\tableHCellTwoRows[2]{
  {\singleTableRowHeight
   \begin{tabular}{c}
     \textbf{#1}\\{#2}
   \end{tabular}
  }
}


% ____________________________________________________________________________
%
% Format figures
% ____________________________________________________________________________


\RequirePackage{graphicx}


% Default folder for figures

\graphicspath{{figures/}}


% Colour of subfigure references

\newcommand{\oxfigsubplot}[1]{\textcolor{black}{(#1)}}


% Figure captions

\captionnamefont{\small} 
\captiontitlefont{\small} 
\changecaptionwidth
\captionwidth{0.9\textwidth}  


% Allow subfloats in figure environment

\newsubfloat{figure}


% ____________________________________________________________________________
%
% Format lists
% ____________________________________________________________________________


\RequirePackage{enumitem}

\ifOxEngThesis@review
    % Do nothing
\else
    \setlist[itemize]{itemsep=1pt}
\fi



% ____________________________________________________________________________
%
% Custom styles for source code listings
% ____________________________________________________________________________


\RequirePackage{listings}


\lstdefinestyle{custom-c}{
  belowcaptionskip=1\baselineskip,
  breaklines=true,
  frame=L,
  xleftmargin=\parindent,
  language=C++,
  showstringspaces=false, 
  basicstyle=\small\ttfamily, %footnotesize\ttfamily
  keywordstyle=\bfseries\color{green!40!black},
  commentstyle=\itshape\color{purple!40!black},
  identifierstyle=\color{blue},
  stringstyle=\color{orange}
}

\lstdefinestyle{custom-bash}{
  belowcaptionskip=1\baselineskip,
  breaklines=true,
  frame=L,
  xleftmargin=\parindent,
  language=bash,
  showstringspaces=false,
  basicstyle=\small\ttfamily,
  keywordstyle=\color{blue}, % identifierstyle=\color{green},
  commentstyle=\color{red},
  stringstyle=\color{orange}
}

\lstdefinestyle{custom-verbatim}{
  frame=L,
  showstringspaces=false,
  basicstyle=\ttfamily,
  columns=fullflexible,
  keepspaces=true
}

\lstdefinestyle{custom-latex}{
  breaklines=true,
  xleftmargin=\parindent,
  aboveskip=1\baselineskip,
  belowskip=1\baselineskip,
  language=[LaTeX]{TeX},
  showstringspaces=false,
  basicstyle=\small\ttfamily,
  postbreak=\mbox{\textcolor{gray}{$\hookrightarrow$}\space},
  keywordstyle=\color{blue}, % identifierstyle=\color{green},
  commentstyle=\color{red},
  stringstyle=\color{orange}
}


\lstdefinestyle{custom-text}{
  breaklines=true,
  breakautoindent=true,
  breakindent=0pt,
  xleftmargin=\parindent,
  aboveskip=2\baselineskip,
  belowskip=2\baselineskip,
  showstringspaces=false,
  frame=L,
  basicstyle=\ttfamily
}


% ____________________________________________________________________________
%
% Common measurement units
% ____________________________________________________________________________


\RequirePackage{siunitx}
\DeclareSIUnit\year{yr}
\DeclareSIUnit\hours{hrs}
\DeclareSIUnit\bpm{beats/min}
\DeclareSIUnit\brpm{breaths/min}


% ____________________________________________________________________________
%
% Glossaries
% ____________________________________________________________________________


\RequirePackage[nonumberlist,abbreviations,shortcuts=abbreviations]{glossaries-extra}


% The colour of the glossary links
\renewcommand*{\glstextformat}[1]{\textcolor{black}{#1}}


% Show the full description of the acronym the first time it gets used
\setabbreviationstyle{long-short}


%% ____________________________________________________________________________
%%
%% Character protrusion, font expansion and inter-word spacing
%% ____________________________________________________________________________


\RequirePackage[activate={true,nocompatibility},final,tracking=true]{microtype}

\microtypecontext{spacing=nonfrench}



% ____________________________________________________________________________
%
% Hyperlinks
% ____________________________________________________________________________


\RequirePackage[hyperindex=true,colorlinks=true,pagebackref=false,allcolors=black,plainpages=false,pdfpagelabels,bookmarksnumbered]{hyperref}


% ____________________________________________________________________________
%
% Coloured boxes
% ____________________________________________________________________________


\RequirePackage{tcolorbox}

\tcbuselibrary{skins}

% A warning box in red with a title

\newtcolorbox{OxWarningBox}[2][]{enhanced,drop fuzzy shadow,colback=red!5!white,colframe=red!75!black,toptitle=2mm,bottomtitle=2mm,top=5mm,bottom=5mm,beforeafter skip balanced=1cm,leftright skip=0.5cm,fonttitle=\bfseries\Large,title={#2},#1}

% An informational box in gray with a title

\newtcolorbox{OxInfoBox}[2][]{enhanced,drop fuzzy shadow,toptitle=2mm,bottomtitle=2mm,top=5mm,bottom=5mm,beforeafter skip balanced=1cm,leftright skip=0.5cm,fonttitle=\bfseries\Large,title={#2},#1}


% ____________________________________________________________________________
%
% Shorcuts to typical latex logos
% ____________________________________________________________________________


\newcommand{\latex}{{\fontfamily{cmr}\selectfont\LaTeX}\xspace}
\newcommand{\tex}{\TeX\xspace}


% ____________________________________________________________________________
%
% Table of contents for chapters
% ____________________________________________________________________________


\ifOxEngThesis@chaptertoc
    \RequirePackage[tight]{minitoc}
    \mtcsetdepth{minitoc}{2}
    %\mtcsetrules{*}{off}
    \mtcsettitle{minitoc}{Chapter contents}
    \renewcommand{\mtcSfont}{\normalfont\small}
    \setlength{\mtcskipamount}{2\bigskipamount}
    \setlength{\mtcindent}{1.5em}
\fi


% ____________________________________________________________________________
%
% FRONT MATTER
% ____________________________________________________________________________


\aliaspagestyle{chapter}{empty}


%
% Name of the input files used in the class
%


\def\oxfordtitlefilename{titlepage-oxford.tex}
\def\abstractfilename{abstract.tex}
\def\glossaryfilename{glossary.tex}

\def\declarationfilename{declaration.tex}
\def\dedicationfilename{dedication.tex}
\def\acknowledgementsfilename{acknowledgements.tex}
\def\publicationsfilename{publications.tex}


%
% Variables used in the front matter
%


% A sentence to appear before the degree
\def\degreeprefix#1{\gdef\@degreeprefix{#1}}

% The full (unabbreviated) name of the degree
\def\degree#1{\gdef\@degree{#1}}

% The name of your Oxford college (e.g. Christ Church, Pembroke)
\def\college#1{\gdef\@college{#1}}

% The name of the university(e.g. University of Oxford)
\def\university#1{\gdef\@university{#1}}

% Filename for the university's logo
\def\universitylogo#1{\gdef\@universitylogo{#1}}

% The name of the university department(e.g. Department of Engineering Science)
\def\department#1{\gdef\@department{#1}}

% The name of your supervisor
\def\supervisor#1{\gdef\@supervisor{#1}}

% Filename of the title page
\def\titlepage#1{\gdef\@titlepage{#1}}


%
% Front abstract page (for Examination Schools at Oxford)
%


\newcommand{\makefrontabstractpage}
{
    {\Large
    \noindent%
    \begin{minipage}[t]{.6\textwidth}
        \raggedright \AuthorName \\ \CollegeName
    \end{minipage}%
    \begin{minipage}[t]{.39\textwidth}
        \raggedleft \DegreeName \\ \DegreeDate
    \end{minipage}
    }

    \begin{center}
        \LARGE{\bfseries{\TitleName}}
    \end{center}
    \noindent\hrulefill

    \begingroup
        \input{\abstractfilename}
    \endgroup
}


%
% The Title page
%


\newcommand{\maketitlepage}
{
    \pdfbookmark[0]{Title page}{title}
    
    \begingroup
    
        \IfFileExists{\titlefilename}
        {
            \include{\titlefilename}
        }
        {
            \include{\oxfordtitlefilename}
        }
        
    \endgroup
}


%
% Dedication page
%


\newcommand{\makededicationpage}
{
    \cleardoublepage
    
    \begingroup   
        \input{\dedicationfilename}
    \endgroup
}


%
% Declaration page
%


\newcommand{\makedeclarationpage}
{
    \cleardoublepage
    \chapter*{Declaration}
    
    \begingroup    
        \input{\declarationfilename}
    \endgroup
}


%
% Acknowledgements page
%


\newcommand{\makeacknowledgementspage}
{
    \cleardoublepage
    \chapter*{Acknowledgements}

    \begingroup
        \input{\acknowledgementsfilename}
    \endgroup
}


%
% Abstract page
%


\newcommand{\makeabstractpage}
{
    \cleardoublepage
    \chapter*{Abstract}
    
    \begingroup
    
        \ifOxEngThesis@review
            \DoubleSpacing
        \else
            \OnehalfSpacing
        \fi
    
        \input{\abstractfilename}
    
    \endgroup
}


%
% List of publications page
%


\newcommand{\makepublicationspage}
{
    \cleardoublepage
    \chapter*{List of publications}
    
    \begingroup
        \input{\publicationsfilename}
    \endgroup
}


%
% Table of contents page
%


\makepagestyle{tocpagestyle}
    \makeheadrule{tocpagestyle}{\textwidth}{0.3pt}
    \makeevenhead{tocpagestyle}{\thepage}{}{\bfseries{Table of contents}}
    \makeoddhead {tocpagestyle}{\bfseries{Table of contents}}{}{\thepage}

\addtodef{\tableofcontents}
{
    \cleardoublepage
    \setcounter{tocdepth}{2}
    \pagestyle{tocpagestyle}
    \renewcommand{\contentsname}{Table of contents}
    \renewcommand*{\tocheadstart}{}
    \setlength{\cftbeforechapterskip}{0.8em \@plus\p@}
    \renewcommand*{\cftappendixname}{Appendix\space}
    \SingleSpacing
}{}


% Fix hbox overfull warnings in TOC
\renewcommand*{\cftdotsep}{1}
\setpnumwidth{3em}
\setrmarg{4em}


%
% List of figures page
%


\makepagestyle{lofpagestyle}
    \makeheadrule{lofpagestyle}{\textwidth}{0.3pt}
    \makeevenhead{lofpagestyle}{\thepage}{}{\bfseries{List of figures}}
    \makeoddhead {lofpagestyle}{\bfseries{List of figures}}{}{\thepage}

\addtodef{\listoffigures}
{
    \clearforchapter
    \pagestyle{lofpagestyle}
    \renewcommand{\listfigurename}{List of figures}
    \renewcommand*{\lofheadstart}{}
    \SingleSpacing
}{}


%
% List of tables page
%


\makepagestyle{lotpagestyle}
    \makeheadrule{lotpagestyle}{\textwidth}{0.3pt}
    \makeevenhead{lotpagestyle}{\thepage}{}{\bfseries{List of tables}}
    \makeoddhead {lotpagestyle}{\bfseries{List of tables}}{}{\thepage}

\addtodef{\listoftables}
{
    \clearforchapter
    \pagestyle{lotpagestyle}
    \renewcommand{\listtablename}{List of tables}
    \renewcommand*{\lotheadstart}{}
    \SingleSpacing
}{}


%
%  Glossary page
%


\makepagestyle{loapagestyle}
    \makeheadrule{loapagestyle}{\textwidth}{0.3pt}
    \makeevenhead{loapagestyle}{\thepage}{}{\bfseries{List of abbreviations}}
    \makeoddhead {loapagestyle}{\bfseries{List of abbreviations}}{}{\thepage}


\newcommand{\listofabbreviations}
{
    \clearforchapter
    \pagestyle{loapagestyle}
    \renewcommand*{\abbreviationsname}{Glossary}
    \glsfindwidesttoplevelname
    \setglossarystyle{alttree}
    \DoubleSpacing
    \printabbreviations
}


%
% A single command to create the entire contents of the front matter
%

\newcommand*{\makefrontmatterpages}
{

    % Define shortcuts to front matter variables
    % with default values
    
    
    \newcommand{\TitleName}{\@title}
    \newcommand{\AuthorName}{\@author}

    \ifdefined \@date
        \newcommand{\DegreeDate}{\@date}
    \else
        \newcommand{\DegreeDate}{DEGREE DATE}
    \fi
    
    \ifdefined \@degreeprefix
        \newcommand{\DegreePrefix}{\@degreeprefix}
    \else
        \ifOxEngThesis@report
            \newcommand{\DegreePrefix}{}
        \else
            \newcommand{\DegreePrefix}{A thesis submitted for the degree of}
        \fi
    \fi
    
    \ifdefined \@degree
        \newcommand{\DegreeName}{\@degree}
    \else
        \ifOxEngThesis@report
            \newcommand{\DegreeName}{{\huge Define the type of report}}
        \else
            \newcommand{\DegreeName}{Doctor of Philosophy}
        \fi
    \fi
    
    \ifdefined \@college
        \newcommand{\CollegeName}{\@college}
    \else
        \newcommand{\CollegeName}{}
    \fi
    
    \ifdefined \@university
        \newcommand{\UniversityName}{\@university}
    \else
        \newcommand{\UniversityName}{University of Oxford}
    \fi
    
    \ifdefined \@universitylogo
        \newcommand{\UniversityLogo}{\@universitylogo}
    \else
        \newcommand{\UniversityLogo}{oxford-logo}
    \fi
    
    \ifdefined \@department
        \newcommand{\DepartmentName}{\@department}
    \else
        \newcommand{\DepartmentName}{Department of Engineering Science}
    \fi
    
    \ifdefined \@supervisor
        \newcommand{\SupervisorName}{\@supervisor}
    \else
        \newcommand{\SupervisorName}{SUPERVISOR NAME}
    \fi
    
    \ifdefined \@titlepage
        \newcommand{\titlefilename}{\@titlepage}
    \else
        \newcommand{\titlefilename}{\oxfordtitlefilename}
    \fi
    
    
    % Load the glossary definitions


    \IfFileExists{\glossaryfilename}
    {
        \include{\glossaryfilename}
    }{}


    % Format the front matter pages
    
    
    \pagestyle{empty}
    \renewcommand\chapterheadstart{}
    \OnehalfSpacing
    
    
    % Include the front matter sections if available
        
    \ifOxEngThesis@frontabstract
        \IfFileExists{\abstractfilename}
        {
            \makefrontabstractpage
            \cleardoublepage
        }{}
    \fi

    \maketitlepage

    \ifOxEngThesis@report
        % Do nothing
    \else
        \IfFileExists{\dedicationfilename}
        {
            \makededicationpage
        }{}
        
        \IfFileExists{\declarationfilename}
        {
            \makedeclarationpage
        }{}
    \fi
    
    \IfFileExists{\acknowledgementsfilename}
    {
        \makeacknowledgementspage
    }{}
    
    \IfFileExists{\abstractfilename}
    {
        \makeabstractpage
    }{}
    
    \ifOxEngThesis@report
        % Do nothing
    \else
        \IfFileExists{\publicationsfilename}
        {
            %\makepublicationspage
            % I have one publication so this page would be embarassing
        }{}
    \fi
    
    \ifOxEngThesis@chaptertoc
        \dominitoc
        \tableofcontents
        \listoffigures
        \adjustmtc[2]
        \listoftables
        \adjustmtc[2]
    \else
        \tableofcontents
        \listoffigures
        \listoftables
    \fi
    
    \IfFileExists{\glossaryfilename}
    {
        \listofabbreviations
    }{}
}


% ____________________________________________________________________________
%
% MAIN MATTER
% ____________________________________________________________________________


% Enable minitoc for chapters

\ifOxEngThesis@chaptertoc

    \RequirePackage{xparse}
    
    \AtBeginDocument
    {
      \let\oldchapter\chapter
      \RenewDocumentCommand{\chapter}{s O{#3} m}
      {
        \IfBooleanTF{#1}{%
          % chapter is starred, no \minitoc
          \oldchapter*{#3}%
        }{%
          \oldchapter[#2]{#3}%
          \minitoc
          \mtcskip
        }%
      }
      
    }
    
\fi


% The font colour for section headings. Default is black
\definecolor{headingcolour}{rgb}{\OxEngThesis@headingcolour}


\let\Chaptermark\chaptermark
\def\chaptermark#1{\def\Chaptername{#1}\Chaptermark{#1}}

%\newcommand*{\thesectionname}{\@currentlabelname}

\let\Sectionmark\sectionmark
\def\sectionmark#1{\def\Sectionname{#1}\Sectionmark{#1}}

\makepagestyle{mainpagestyle}
    \makeevenhead{mainpagestyle}{\thepage}{}{\bfseries{\thesection.~\Sectionname}}
    \makeoddhead {mainpagestyle}{\bfseries{\chaptername~\thechapter.~\Chaptername}}{}{\thepage}
    \makeheadrule{mainpagestyle}{\textwidth}{0.3pt}

\makechapterstyle{defaultchapterstyle}
{ 
    \chapterstyle{default}
    
    \renewcommand\chapterheadstart{}
    \setlength\beforechapskip{0\baselineskip}
    \setlength\midchapskip{0\baselineskip}
    \setsecheadstyle{\large\bfseries\color{headingcolour}}
    \setsubsecheadstyle{\large\bfseries\color{headingcolour}}
    \setsubsubsecheadstyle{\large\bfseries}
    
    \ifOxEngThesis@review
        \DoubleSpacing
    \else
        \OnehalfSpacing
    \fi
    
    % Uncomment the following lines to temporarily check/debug page layout
    
    %\ifOxEngThesis@debuglayout
    %    \layout
    %\fi
}

\addtodef{\mainmatter}
{
    \glsresetall
    \clearforchapter
    \pagestyle{mainpagestyle}
    \chapterstyle{\OxEngThesis@chapterstyle}
}{}


% Enabling numbering for subsections

\setsecnumdepth{subsection}

%
% Configure the appendix
%

 \makepagestyle{appendixpagestyle}
     \makeevenhead{appendixpagestyle}{\thepage}{}{\bfseries{\thesection.~\Sectionname}}
     \makeoddhead {appendixpagestyle}{\bfseries{\appendixname~\thechapter.~\Chaptername}}{}{\thepage}
     \makeheadrule{appendixpagestyle}{\textwidth}{0.3pt}

\addtodef{\appendix}
{
    \clearforchapter
    \pagestyle{appendixpagestyle}
    \chapterstyle{\OxEngThesis@chapterstyle}
}{}


% ____________________________________________________________________________
%
% BACK MATTER
% ____________________________________________________________________________


\addtodef{\backmatter}
{
    \pagestyle{empty}
    \renewcommand\chapterheadstart{}
    \SingleSpacing
}{}


%
% Bibliography
%


% Name of the input files used in the class
\def\bibliographyfilename{references}


\makepagestyle{bibliopagestyle}
    \makeheadrule{bibliopagestyle}{\textwidth}{0.3pt}
    \makeevenhead{bibliopagestyle}{\thepage}{}{\bfseries{Bibliography}}
    \makeoddhead {bibliopagestyle}{\bfseries{Bibliography}}{}{\thepage}


% Param 1 : bibliography style
\newcommand{\listofreferences}[1][ieeetr]
{
    \clearforchapter
    \pagestyle{bibliopagestyle}
    \bibliographystyle{#1}
    \SingleSpacing
    \setlength{\parskip}{0pt}
    \setlength{\itemsep}{1pt plus 1ex}
    
    % Fix hbox warnings on bibtex entries
    \apptocmd{\sloppy}{\hbadness 10000\relax}{}{} 
    
    \IfFileExists{\bibliographyfilename.bib}
    {
        \bibliography{\bibliographyfilename}
    }{}
}


% ____________________________________________________________________________
%
% Extra configuration
% ____________________________________________________________________________


% Page boundary: suppress some underfull \vbox warnings

\makeatletter
    \def\@textbottom{\vskip \z@ \@plus 1pt}
    \let\@texttop\relax
\makeatother


% ____________________________________________________________________________
%
% References
% ____________________________________________________________________________

% Reference to the labels and numbers of chapter, section, figures, ...
% "memoir" class requires this to be towards the end of the configuration

\RequirePackage[noabbrev]{cleveref}

