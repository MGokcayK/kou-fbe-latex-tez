\UseRawInputEncoding
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{kou}[28/01/2022 KOU Thesis Class // @Mehmet Gökçay KABATAŞ]

\LoadClass[12pt]{report}
\pdfminorversion=7

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Taslak için gerekli bilgilerin toplandığı komutlar.
\newcommand*\baslik{\@ifnextchar\bgroup {\gdef\titl}{\titl}}
\newcommand*\thetitle{\@ifnextchar\bgroup {\gdef\titleng}{\titleng}}
\newcommand*\bolum{\@ifnextchar\bgroup {\gdef\dept}{\dept}}
\newcommand*\yazar{\@ifnextchar\bgroup {\gdef\auth}{\auth}}
\newcommand*\tarihAY{\@ifnextchar\bgroup {\gdef\trhA}{\trhA}}
\newcommand*\tarihYIL{\@ifnextchar\bgroup {\gdef\trhY}{\trhY}}
\newcommand*\starih{\@ifnextchar\bgroup {\gdef\strh}{\strh}}
\def\jr{\hfill}
\newcommand{\jrBIR}[1]{\def\jr{#1}}
\def\jrd{\hfill}
\newcommand{\jrBIRd}[1]{\def\jrd{#1\hspace*{\fill}\text{........................}}}
\def\jrS{\hfill}
\newcommand{\jrIKI}[1]{\def\jrS{#1}}
\def\jrdS{\hfill}
\newcommand{\jrIKId}[1]{\def\jrdS{#1\hspace*{\fill}\text{........................}}}
\def\jrT{\hfill}
\newcommand{\jrUC}[1]{\def\jrT{#1}}
\def\jrdT{\hfill}
\newcommand{\jrUCd}[1]{\def\jrdT{#1\hspace*{\fill}\text{........................}}}
\def\jrF{\hfill}
\newcommand{\jrDORT}[1]{\def\jrF{#1}}
\def\jrdF{\hfill}
\newcommand{\jrDORTd}[1]{\def\jrdF{#1\hspace*{\fill}\text{........................}}}
\def\jrFT{\hfill}
\newcommand{\jrBES}[1]{\def\jrFT{#1}}
\def\jrdFT{\hfill}
\newcommand{\jrBESd}[1]{\def\jrdFT{#1\hspace*{\fill}\text{........................}}}
\newcommand*\onsoz{\@ifnextchar\bgroup {\gdef\onsz}{\onsz}}
\newcommand*\ozet{\@ifnextchar\bgroup {\gdef\oz}{\oz}}
\newcommand*\anahtarkelimeler{\@ifnextchar\bgroup {\gdef\anahtar}{\anahtar}}
\newcommand*\theabstract{\@ifnextchar\bgroup {\gdef\abst}{\abst}}
\newcommand*\keywords{\@ifnextchar\bgroup {\gdef\keywrd}{\keywrd}}

% İçindekiler tablosuna girmeyen başlık açma komutu.
\newcommand{\nocontentsline}[3]{}
\newcommand{\tocless}[2]{\bgroup\let\addcontentsline=\nocontentsline{\bfseries#2}\egroup}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Seçenekler
\newif\ifphd\phdfalse
\newif\ifmsc\mscfalse

\DeclareOption{phd}{\phdtrue}
\DeclareOption{msc}{\msctrue}

\ProcessOptions
% Kullanılan paketler
\RequirePackage{silence}
\WarningsOff[everypage]% 

\RequirePackage[style=authoryear-icomp,
				maxbibnames=99,
				maxcitenames=2,
				backend=biber, 
				giveninits,
				uniquename=false,
				eventdate=comp,
				sorting=anyt]{biblatex}
\RequirePackage{enumitem}
\RequirePackage{etoolbox}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[style=english]{csquotes}
\RequirePackage[main=turkish,english,shorthands=:!]{babel}
%\RequirePackage{appendix}
\RequirePackage{graphicx}
\RequirePackage{xy} 
\RequirePackage{listings}
\RequirePackage{array}
\RequirePackage{algorithm}
\RequirePackage{algpseudocode}
\RequirePackage[format=plain,justification=raggedright, margin=0em]{caption}
\RequirePackage[fleqn]{amsmath}
\RequirePackage{amssymb}
\RequirePackage{color}
\RequirePackage{txfonts}
\RequirePackage{siunitx}
\RequirePackage{subcaption}
\RequirePackage{tikz}
\RequirePackage{mathtools}
\RequirePackage{fancyhdr,xfp}
\RequirePackage[nodisplayskipstretch]{setspace}
\RequirePackage[explicit, newparttoc]{titlesec}
\RequirePackage{titletoc}
\RequirePackage{xpatch}
\RequirePackage{lipsum}
\RequirePackage{pdflscape}
\RequirePackage{everypage}
\RequirePackage{quoting}
\RequirePackage[perpage]{footmisc}
\RequirePackage{framed}
\RequirePackage[pdfusetitle, linktoc=all]{hyperref}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Kişisel yayın ve eser bölümünde kullanılacak komut oluşturulması

% Yeni fullcite komutu
\DeclareCiteCommand{\customfullcite}
{}%
{\usedriver
	{\DeclareNameAlias{sortname}{default}}
	{\thefield{entrytype}}
	}
{\multicitedelim}
{}

% Bibliography'e eklenmeyen kategori oluşturulması
\DeclareBibliographyCategory{nobibliography}

% Kişisel eserin yazdırılacağı komut
\newcommand{\kisiselcite}[1]{\hangindent=1cm\hangafter=1\addtocategory{nobibliography}{#1}\customfullcite{#1}}

% Tez/proje sahibinin ismini kalınlaştıran düzenleme
\renewcommand*{\mkbibnamegiven}[1]{%
	\ifitemannotation{highlight}
	{\textbf{#1}}
	{#1}}

\renewcommand*{\mkbibnamefamily}[1]{%
	\ifitemannotation{highlight}
	{\textbf{#1}}
	{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Algoritmanın sayfalar arasında bölünebilmesi için yeni ortam oluşturma
% https://tex.stackexchange.com/questions/428001/long-algorithm-cannot-split-into-two-pages
\makeatletter
\newenvironment{algoritma}
{
	\vspace{\baselineskip}
	\linespread{1.0}\selectfont
	\refstepcounter{algorithm}% New algorithm
	\renewcommand{\caption}[2][\relax]{% Make a new \caption
				\kern2pt\hrule\kern4pt
				\hbox{\ALG@name~\thealgorithm: ##2\hfill}%
				\ifx\relax##1\relax % #1 is \relax
				\addcontentsline{loa}{algorithm}{\protect\numberline{\thealgorithm}##2}%
				\else % #1 is not \relax
				\addcontentsline{loa}{algorithm}{\protect\numberline{\thealgorithm}##1}%
				\fi
				\kern2pt\hrule\kern2pt
			}
		}{
	\kern2pt\hrule\relax% \@fs@post for \@fs@ruled
	\vspace{\baselineskip}
}
\makeatother



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Yeni maddelendirme tanımlamaları. 

% "simge" ortamı "\begin{simge} ve \end{simge}" arasında kullanılır ve 
% farkı "Etiket" düzeni ve etiketin sonuna ":" koyulmasıdır. 
\SetLabelAlign{simgeAlign}{\parbox[t]{\labelwidth}{#1\hfill:}}
\newlist{simge}{enumerate}{4}
\setlist[simge]{label=\arabic*., leftmargin=3cm,align=simgeAlign,
	before=\setlength{\baselineskip}{0pt},
	labelsep=*,labelwidth=*, nosep, topsep=0pt,itemsep=2pt}

% "maddelendir" ortamı standart "itemize" a benzer fakat ufak düzenlemeler
% içerir.
\newlist{maddelendir}{enumerate}{4}
\setlist[maddelendir]{label=\arabic*.,noitemsep,leftmargin=1cm,align=left,
	labelsep=*,labelwidth=*,topsep=0pt}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tanımlanan grafik dosyalarının uzantıları.
%\DeclareGraphicsExtensions{.pdf,.png,.jpg}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Türkçeleştirme işlemleri.
\makeatletter
\setlength{\@fptop}{0pt}
\renewcommand{\ALG@name}{Algoritma}
\makeatother
%\renewcommand{\listtablename}{Tablolar Dizini}
%\renewcommand{\contentsname}{Yeni }
%\renewcommand{\listfigurename}{My nice list of figures}
%\renewcommand{\figurename}{?ekil}
%\renewcommand{\lstlistingname}{ekil}
%\renewcommand{\tablename}{Tablo}
%\addto\captionsturkish{% Replace "english" with the language you use
	%	\renewcommand{\contentsname}%
	%	{sea}%
	%}
%\renewcommand{\algorithmicrequire}{\textbf{Gerekli:}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Linklerin çevresinde oluşan kırmızı kutunun renksizleştirilmesi.
\hypersetup{
	colorlinks   = false, 
	urlcolor     = blue, 
	linkcolor    = blue, 
	citecolor   = red, 
	pdfborder={0 0 0.0},
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Bazı renk tanımlamaları.
\colorlet{mygray}{black!30}
\colorlet{mygreen}{green!60!blue}
\colorlet{mymauve}{red!60!blue}



\newlength{\lsttop}
\setlength{\lsttop}{0.0mm}
%%%%%%%%%%%%% BUNU TEKRAR DUZENLE %%%%%%%%%%%%%%%%%%%%%%
% Kod yazımı için oluşturulan liste özellikleri.
\lstset{
	backgroundcolor=\color{white},  
	basicstyle=\ttfamily,
	columns=fullflexible,
	breakatwhitespace=false,      
	breaklines=true,                
	captionpos=b,                    
	commentstyle=\color{mygreen}, 
	extendedchars=true,              
	frame=single,                   
	keepspaces=true,             
	keywordstyle=\color{blue},      
	numbers=none,                
	numbersep=5pt,                   
	numberstyle=\tiny\color{blue}, 
	rulecolor=\color{mygray},        
	showspaces=false,               
	showtabs=false,                 
	stepnumber=5,                  
	stringstyle=\color{mymauve},    
	tabsize=3,              
	xleftmargin=3.4pt,
	xrightmargin=3.4pt,
	belowskip=-3.4pt,      
	aboveskip=\baselineskip, %3.5mm,
	inputencoding = utf8,  % Input encoding
	extendedchars = true,  % Extended ASCII
	literate      =        % Support additional characters
	{á}{{\'a}}1  {é}{{\'e}}1  {í}{{\'i}}1 {ó}{{\'o}}1  {ú}{{\'u}}1
	{Á}{{\'A}}1  {É}{{\'E}}1  {Í}{{\'I}}1 {Ó}{{\'O}}1  {Ú}{{\'U}}1
	{à}{{\`a}}1  {è}{{\`e}}1  {ì}{{\`i}}1 {ò}{{\`o}}1  {ù}{{\`u}}1
	{À}{{\`A}}1  {È}{{\'E}}1  {Ì}{{\`I}}1 {Ò}{{\`O}}1  {Ù}{{\`U}}1
	{ä}{{\"a}}1  {ë}{{\"e}}1  {ï}{{\"i}}1 {ö}{{\"o}}1  {ü}{{\"u}}1
	{Ä}{{\"A}}1  {Ë}{{\"E}}1  {Ï}{{\"I}}1 {Ö}{{\"O}}1  {Ü}{{\"U}}1
	{â}{{\^a}}1  {ê}{{\^e}}1  {î}{{\^i}}1 {ô}{{\^o}}1  {û}{{\^u}}1
	{Â}{{\^A}}1  {Ê}{{\^E}}1  {Î}{{\^I}}1 {Ô}{{\^O}}1  {Û}{{\^U}}1
	{œ}{{\oe}}1  {Œ}{{\OE}}1  {æ}{{\ae}}1 {Æ}{{\AE}}1  {ß}{{\ss}}1
	{ç}{{\c c}}1 {Ç}{{\c C}}1 {ø}{{\o}}1  {Ø}{{\O}}1   {å}{{\r a}}1
	{Å}{{\r A}}1 {ã}{{\~a}}1  {õ}{{\~o}}1 {Ã}{{\~A}}1  {Õ}{{\~O}}1
	{ñ}{{\~n}}1  {Ñ}{{\~N}}1  {¿}{{?`}}1  {¡}{{!`}}1 {ı}{{\i}}1
	{I}{\.{I}}1 {İ}{\.{I}}1 {ş}{\c{s}}1 {Ş}{\c{S}}1 {ğ}{\u{g}}1 {Ğ}{\u{G}}1
	{ü}{{\"{u}}}1 {Ü}{{\"{U}}}1
%	{°}{{\textdegree}}1 {º}{{\textordmasculine}}1 {ª}{{\textordfeminine}}1
}


% Listing sayacı ve isimlendirmesinin figür ile eşitlenmesi
\makeatletter
\AtBeginDocument{
	\let\lstlistingname\figurename
	\let\thelstlisting\thefigure
	\let\c@lstlisting\c@figure
	\let\ftype@lstlisting\ftype@figure
}
\makeatother


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Sayfa geometrisinin ayarlanması
\RequirePackage[top=3.0cm, bottom=3.0cm, left=3.0cm, right=3.0cm, a4paper]{geometry}

% Sayfa numaralandırmasının düzenlenmesi.
\pagestyle{plain}

% Paragraf arasarasının 12 nokta (punto) yapılması.
\setlength{\parindent}{0em}
\setlength{\parskip}{12pt}

% Satır arasının 1.5 yapılması
\setstretch{1.5}
%\captionsetup*[table]{}    
%\captionsetup[figure]{}  
\setlength{\intextsep}{\baselineskip}
\setlength{\textfloatsep}{\baselineskip}
\setlength{\FrameSep}{0pt}
\setlength{\fboxsep}{0pt}
%\AfterEndEnvironment{figure}{\vskip-\baselineskip}
%\AfterEndEnvironment{table}{\vskip-\baselineskip}

% Tablo ve Şekil etiketlerinin sonuna nokta konulması
\renewcommand{\thetable}{\thechapter.\arabic{table}.}
\renewcommand{\thefigure}{\thechapter.\arabic{figure}.}

% Denklemlerin sol tarafa yaklaştırılması
\setlength{\mathindent}{0pt}
\setlength{\abovedisplayskip}{0pt}
\setlength{\belowdisplayskip}{0pt}
\setlength{\abovedisplayshortskip}{0pt}
\setlength{\belowdisplayshortskip}{0pt}
\allowdisplaybreaks

% Bölüm ve içerik sayacının derinliğinin ayarlanması.
\setcounter{secnumdepth}{4}
\setcounter{tocdepth}{4}

% Satir sonunda kelimeleri - ile kesmeme.
\tolerance=1
\emergencystretch=\maxdimen
\hyphenpenalty=10000
\hbadness=10000

% Yatay sayfa ortamı oluşturulması
\newenvironment{yataysayfa}{
	\clearpage
	\pagestyle{empty}
	\assignpagestyle{\chapter}{empty}
	\begin{landscape}
	}
	{
	\end{landscape}
}

% Yatay sayfanın numarasının düzenlenmesi
\newlength{\hfoot}
\newlength{\vfoot}
\AddEverypageHook{\ifdim\textwidth=\linewidth\relax
	\else\setlength{\hfoot}{-\topmargin}%
	\addtolength{\hfoot}{-\headheight}%
	\addtolength{\hfoot}{-\headsep}%
	\addtolength{\hfoot}{-.5\linewidth}%
	\ifodd\value{page}\setlength{\vfoot}{\oddsidemargin}%
	\else\setlength{\vfoot}{\evensidemargin}\fi%
	\addtolength{\vfoot}{\textheight}%
	\addtolength{\vfoot}{\footskip}%
	\raisebox{\hfoot}[0pt][0pt]{\rlap{\hspace{\vfoot}\rotatebox[origin=cB]{90}{\thepage}}}\fi}

% Dipnot ayırıcı çizgi düzenlenmesi
\def\footnoterule{\kern-3pt \hrule \kern2.6pt} % the \hrule is .4pt high

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bölüm başlıklarının (birinci, ikinci, üçüncü ve dördüncü derece) ayarlanması.

% Birinci derece bölüm başlığının düzenlenmesi.
\titleformat{\chapter}
{\bfseries\large}
{}
{0pt}
{\thechapter.~\MakeUppercase{#1}}

\titleformat{name=\chapter,numberless}
{\bfseries\large}
{}
{0pt}
{\addcontentsline{toc}{chapter}{#1}\MakeUppercase{#1}}
\titlespacing{\chapter}{0pt}{-\baselineskip-\headheight}{0pt}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% İkinci derece bölüm başlığının düzenlenmesi.
\titleformat{\section}
{\bfseries}
{}
{0pt}
{\thesection.~#1}

\titleformat{name=\section,numberless}[block]
{\bfseries}
{}
{0pt}
{\addcontentsline{toc}{section}{#1}#1}
\titlespacing{\section}{0pt}{0pt}{0pt}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Üçüncü derece bölüm başlığının düzenlenmesi.
\titleformat{\subsection}
{\bfseries}
{}
{0pt}
{\thesubsection.~#1}

\titleformat{name=\subsection,numberless}[block]
{\bfseries}
{}
{0pt}
{\addcontentsline{toc}{subsection}{#1}#1}
\titlespacing{\subsection}{0pt}{0pt}{0pt}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dördüncü derece bölüm başlığının düzenlenmesi. 
\titleformat{\subsubsection}
{\bfseries}
{}
{0pt}
{\thesubsubsection.~#1}

\titleformat{name=\subsubsection,numberless}[block]
{\bfseries}
{}
{0pt}
{\addcontentsline{toc}{subsubsection}{#1}#1}
\titlespacing{\subsubsection}{0pt}{0pt}{0pt}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Dizin marjin ayarlanması
\contentsmargin[1.5cm]{0cm}
\renewcommand\contentspage{\thecontentspage}

% Birinci derece bölüm başlıklarının içindekiler listesindeki gösteriminin ayarlanması
\titlecontents{chapter}% <section-type>
[0mm]% <left> % not guesswork
{\vspace{-\baselineskip}}% <above-code>
{\thecontentslabel.~\MakeUppercase}% <numbered-entry-format>
{\MakeUppercase}% <numberless-entry-format>
{\titlerule*[1mm]{.}\contentspage}% <filler-page-format>

% İkinci derece bölüm başlıklarının içindekiler listesindeki gösteriminin ayarlanması
\titlecontents{section}
[5mm]
{\vspace{-\baselineskip}}% <above-code>
{\thecontentslabel.~}
{}
{\titlerule*[1mm]{.}\contentspage}

% Üçüncü derece bölüm başlıklarının içindekiler listesindeki gösteriminin ayarlanması
\titlecontents{subsection}
[13mm]
{\vspace{-\baselineskip}}% <above-code>
{\thecontentslabel.~}
{}
{\titlerule*[1mm]{.}\contentspage}

% Dördüncü derece bölüm başlıklarının içindekiler listesindeki gösteriminin ayarlanması
\titlecontents{subsubsection}
[24mm]
{\vspace{-\baselineskip}}% <above-code>
{\thecontentslabel.~}
{}
{\titlerule*[1mm]{.}\contentspage}

% Şekillerin, Şekil dizini içerisinde gösteriminin ayarlanması
\titlecontents{figure}
[2.5cm]
{\vspace{-\baselineskip}}% <above-code>
{\contentslabel[\figurename~\thecontentslabel~]{2.5cm}}
{\hspace*{-2.5cm}}
{\titlerule*[1mm]{.}\contentspage}%

% Tabloların, tablo dizini içerisinde gösteriminin ayarlanması
\titlecontents{table}
[2.5cm]
{\vspace{-\baselineskip}}% <above-code>
{\contentslabel[\tablename~\thecontentslabel~]{2.5cm}}
{\hspace*{-2.5cm}}
{\titlerule*[1mm]{.}\contentspage}

% Dizinlerin başlıktan sonra 1 satır boşluk bırakılması
\patchcmd{\tableofcontents}{\@starttoc}{\vspace{\baselineskip}\@starttoc}{}{} 
\patchcmd{\listoffigures}{\@starttoc}{\vspace{\baselineskip}\@starttoc}{}{} 
\patchcmd{\listoftables}{\@starttoc}{\vspace{\baselineskip}\@starttoc}{}{} 

% Tablo dizininde ve şekil dizininde yeni bölüme geçişte oluşan boşluğun
% kapatılması.
\newcommand*{\noaddvspace}{\renewcommand*{\addvspace}[1]{}}
\addtocontents{lof}{\protect\noaddvspace}
\addtocontents{lot}{\protect\noaddvspace}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% hyperref ve `\MakeUppercase` kullanımı sonucu çıkan hata çözümü : https://github.com/latex3/hyperref/issues/121
\makeatletter
\let\ORG@hyper@linkstart\hyper@linkstart
\protected\def\hyper@linkstart#1#2{%
	\lowercase{\ORG@hyper@linkstart{#1}{#2}}}
\makeatother


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%position tester
\newcommand{\placetextbox}[3]{
	\setbox0=\hbox{#3}
	\AddToShipoutPictureFG*{
		\put({#1cm},{\LenToUnit{\paperheight}+0.5\baselineskip-#2cm}){\vtop{{\null}\makebox[0pt][l]{#3}}}%
	}%
}%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Table of Contents komutunu yeniden tanımlanması. 
% Numarasız başlıklardan olan TOC un başlığında oluşan
% hatayı düzenlemektedir. 

% Mesela, Article.sty içinde tanımlı olan TOC 
%\newcommand\tableofcontents{%
%	\section*{\contentsname
%			\@mkboth{%
%				\MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
%		\@starttoc{toc}%
%}
% formundadır. Buradaki \MakeUppercase komutu ile TOC un başlığı kesişmekte
% bu durumda hata oluşturmaktadır. Komutun basitçe tekrar tanımlanmasıyla
% sorun çözülmüştür.
\makeatletter
\renewcommand\tableofcontents{%
	\chapter*{\contentsname}\vspace{\baselineskip}
	\@starttoc{toc}%
}
\makeatother


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Kapak sayfası tanımımlanması.
\newcommand\kapakolustur
{
	\begin{titlepage}
		\centering
		\bfseries
		\fontsize{14}{16.8}\selectfont
		\begin{minipage}[t][3.5cm][t]{\textwidth}
			\centering
			KOCAELİ ÜNİVERSİTESİ \\ FEN BİLİMLERİ ENSTİTÜSÜ 
		\end{minipage} 		
		\begin{minipage}[t][3.5cm][t]{\textwidth}
			\centering
			\MakeUppercase{\dept}	
		\end{minipage} 
		\begin{minipage}[t][4.0cm][t]{\textwidth}
			\centering
			\ifphd
			\MakeUppercase{DOKTORA TEZİ}
			\else
				\ifmsc
				\MakeUppercase{YÜKSEK LİSANS TEZİ}
				\else
				\MakeUppercase{PROJE}
				\fi
			\fi
		\end{minipage} 		
		\begin{minipage}[t][6.0cm][t]{\textwidth}
			\centering
			\MakeUppercase{\titl}
		\end{minipage} 
		\begin{minipage}[t][2.0cm][t]{\textwidth}
			\centering
			\MakeUppercase{\auth}
		\end{minipage} 
		\vfill
		\vbox{\MakeUppercase{Kocaeli}~\trhY}
	\end{titlepage}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Onay sayfası ortamı oluşturulması.
\newenvironment{onaysayf}
{
	\clearpage
	\thispagestyle{empty}% we want this page to be empty (adjust to use a modified page style)
	\setlength{\parskip}{0pt}
	\centering
	\bfseries
	\fontsize{14}{16.8}\selectfont
}

% Onay sayfası tanımlanması.
\newcommand\onayolustur
{
	\begin{onaysayf}
		\begin{minipage}[t][2.50cm][t]{\textwidth}
			\centering
			KOCAELİ ÜNİVERSİTESİ \\ FEN BİLİMLERİ ENSTİTÜSÜ 
		\end{minipage} 	
		\begin{minipage}[t][2.50cm][t]{\textwidth}
			\centering
			\MakeUppercase{\dept}	
		\end{minipage} 	
		\begin{minipage}[t][2.50cm][t]{\textwidth}
			\centering
			\ifphd
			\MakeUppercase{DOKTORA TEZİ}
			\fi
			\ifmsc
			\MakeUppercase{YÜKSEK LİSANS TEZİ}
			\else
			\MakeUppercase{PROJE}
			\fi
		\end{minipage} 	
		\begin{minipage}[t][4.3cm][t]{\textwidth}
			\centering
			\MakeUppercase{\titl}
		\end{minipage} 	
		\begin{minipage}[t][4.0cm][t]{\textwidth}
			\centering
			\MakeUppercase{\auth}
		\end{minipage} 
		\begin{minipage}[t][6.5cm][t]{0.773\textwidth}
			\fontsize{12}{0}\selectfont
			\setlength{\parskip}{4pt}
			\jr \\
			\jrd  
			
			\jrS \\
			\jrdS
			
			\jrT \\
			\jrdT
			
			\jrF \\
			\jrdF
			
			\jrFT \\
			\jrdFT
			\vfill

		\end{minipage} 
		\begin{minipage}[t][1.0cm][t]{\textwidth}
		\centering
		\fontsize{12}{0}\selectfont
		Tezin Savunulduğu Tarih: \MakeUppercase{\strh}
	\end{minipage} 
	\end{onaysayf}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Etik Beyan ve Araştırma Fonu Desteği Sayfası
\newcommand\etikolustur
{
	\cleardoublepage\phantomsection\addcontentsline{toc}{chapter}{Etik Beyan ve Araştırma Fonu Desteği}
	\centerline{\bfseries\MakeUppercase{Etik Beyan ve Araştırma Fonu Desteği}}
	Kocaeli Üniversitesi Fen Bilimleri Enstitüsü tez yazım kurallarına uygun olarak hazırladığım bu tez/proje çalışmasında,
	\begin{maddelendir}[label=-, labelwidth=0.4cm, leftmargin=1.25cm]
		\item Bu tezin/projenin bana ait, özgün bir çalışma olduğunu,
		\item Çalışmamın hazırlık, veri toplama, analiz ve bilgilerin sunumu olmak üzere tüm aşamasında bilimsel etik ilke ve kurallara uygun davrandığımı,
		\item Bu çalışma kapsamında elde edilen tüm veri ve bilgiler için kaynak gösterdiğimi ve bu kaynaklara kaynakçada yer verdiğimi,
		\item Bu çalışmamın Kocaeli Üniversitesi'nin abone olduğu intihal yazılım programı kullanılarak Fen Bilimleri Enstitüsü'nün belirlemiş ölçütlere uygun olduğunu,
		\item Kullanılan verilerde herhangi bir tahrifat yapmadığımı,
		\item Tezin/projenin herhangi bir bölümünü bu üniversite veya başka bir üniversitede başka bir tez/proje çalışması olarak sunmadığımı,
	\end{maddelendir}
	beyan ederim.
	
	\framebox[0.5cm][t]{\rule{0pt}{0.5\baselineskip}}~Bu tez/proje çalışmasının herhangi bir aşaması hiçbir kurum/kuruluş tarafından maddi/alt yapı desteği ile desteklenmemiştir.
	
	\framebox[0.5cm][t]{\rule{0pt}{0.5\baselineskip}}~Bu tez/proje çalışması kapsamında üretilen veri ve bilgiler ................................ tarafından ................................ no'lu proje kapsamında maddi/alt yapı desteği alınarak gerçekleştirilmiştir.
	
	Herhangi bir zamanda, çalışmamla ilgili yaptığım bu beyana aykırı bir durumun saptanması durumunda, ortaya çıkacak tüm ahlaki ve hukuki sonuçları kabul ettiğimi bildiririm.
	
	\hfill\mbox{\parbox{4.2cm}{\centering............................\\(İmza)\\........................................ \\(Öğrencinin Adı Soyadı)}}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YAYIMLAMA VE FİKRİ MÜLKİYET HAKLARI
\newcommand\fikriolustur
{
	\cleardoublepage\phantomsection\addcontentsline{toc}{chapter}{YAYIMLAMA VE FİKRİ MÜLKİYET HAKLARI}
	\centerline{\bfseries\MakeUppercase{YAYIMLAMA VE FİKRİ MÜLKİYET HAKLARI}}
	Fen Bilimleri Enstitüsü tarafından onaylanan lisansüstü tezimin/projemin tamamını
	veya herhangi bir kısmını, basılı ve elektronik formatta arşivleme ve aşağıda belirtilen
	koşullarla kullanıma açma izninin Kocaeli Üniversitesi’ne verdiğimi beyan ederim. Bu
	izinle Üniversiteye verilen kullanım hakları dışındaki tüm fikri mülkiyet haklarım bende
	kalacak, tezimin/projemin tamamının ya da bir bölümünün gelecekteki çalışmalarda
	(makale, kitap, lisans ve patent vb.) kullanımı bana ait olacaktır.\\
	Tezin/projenin kendi özgün çalışmam olduğunu, başkalarının haklarını ihlal etmediğimi
	ve tezimin/projenin tek yetkili sahibi olduğumu beyan ve taahhüt ederim. Tezimde yer
	alan telif hakkı bulunan ve sahiplerinden yazılı izin alınarak kullanılması zorunlu
	metinlerin yazılı izin alarak kullandığımı ve istenildiğinde suretlerini Üniversiteye
	teslim etmeyi taahhüt ederim. \\
	Yükseköğretim kurulu tarafından yayınlanan \textbf{\textit{“Lisanüstü Tezlerin Elektronik Ortamda
	Toplanması, Düzenlenmesi ve Erişime Açılmasına İlişkin Yönerge”}} kapsamında tezim
	aşağıda belirtilen koşullar haricinde YÖK Ulusal Tez Merkezi/ Kocaeli Üniversitesi
	Kütüphaneleri Açık Erişim Sisteminde erişime açılır. 
	
	\framebox[0.5cm][t]{\rule{0pt}{0.5\baselineskip}} Enstitü yönetim kurulu kararı ile tezimin/projemin erişime açılması mezuniyet tarihinden itibaren 2 yıl ertelenmiştir. \\	
	\framebox[0.5cm][t]{\rule{0pt}{0.5\baselineskip}} Enstitü yönetim kurulu gerekçeli kararı ile tezimin/projemin erişime açılması mezuniyet tarihinden itibaren 6 ay ertelenmiştir. \\
	\framebox[0.5cm][t]{\rule{0pt}{0.5\baselineskip}} Tezim/projem ile ilgili gizlilik kararı verilmemiştir.
	
	\hfill\mbox{\parbox{4.2cm}{\centering............................\\(İmza)\\........................................ \\(Öğrencinin Adı Soyadı)}}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Önsöz ve teşekkür sayfası oluşturma.
\newcommand\onsozolustur
{
	\chapter*{Önsöz ve Teşekkür}
	\onsz
	
	\trhA~-~\trhY \hfill \auth
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Özetin oluşturulması.
\newcommand\ozetolustur
{
	\clearpage\phantomsection\addcontentsline{toc}{chapter}{Özet}	
	\textbf{\MakeUppercase{\titl}}
	
	\textbf{\MakeUppercase{Özet}}
	
	\oz
	
	\textbf{Anahtar Kelimeler: }\anahtar
}

\newcommand\createabstract
{
	\selectlanguage{english}
	\clearpage\phantomsection\addcontentsline{toc}{chapter}{Abstract}
	\textbf{\MakeUppercase{\titleng}}
	
	\textbf{\MakeUppercase{Abstract}}
	
	\abst
	
	\textbf{Keywords: }\keywrd
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ekler ana sayfasını oluşturulması.
\newenvironment{eklersayf}
{
	\cleardoublepage\phantomsection\addcontentsline{toc}{chapter}{Ekler}
	\thispagestyle{empty}
	\setlength{\parskip}{0pt}
	\centering
	\bfseries
	\fontsize{14}{16.8}\selectfont
}


% Eklerde oluşturulan sayacın Türkçe harf karşılığı.
\newcommand*{\Turkish}[1]
{%
	\ifcase#1\or A\or B\or C\or \c{C}\or D\or E\or F\or G\or \u{G}\or H\or I
	\or \.{I}\or J\or K\or L\or M\or N\or O\or \"{O}\or P\or R\or S\or \c{S}
	\or T\or U\or \"{U}\or V\or Y\or Z
	\else\@ctrerr\fi
}

% Ekler ortamının oluşturulması.
\newcounter{eklercounter}
%\renewcommand{\theeklercounter}{\Turkish{eklercounter}}
\makeatletter
\gdef\theeklercounter{\Turkish\c@eklercounter}
\makeatother
\newenvironment{ekler}[1][]
{
	\cleardoublepage
	\refstepcounter{eklercounter}
	\textbf{Ek-\theeklercounter}
	\stepcounter{chapter}
	\renewcommand{\thechapter}{\theeklercounter.\arabic{chapter}}
	\setcounter{section}{0}
	\renewcommand{\thesection}{\theeklercounter.\arabic{section}}
	\setcounter{equation}{0}
	\renewcommand{\theequation}{\theeklercounter.\arabic{equation}}
	\setcounter{table}{0}
	\renewcommand{\thetable}{\theeklercounter.\arabic{table}.}
	\setcounter{figure}{0}
	\renewcommand{\thefigure}{\theeklercounter.\arabic{figure}.}
	\setlength{\lsttop}{3.5mm}
	\par
}{\setlength{\lsttop}{0.0mm}}

% Ekler sayfasının oluşturulması.
\newcommand\eklerolustur
{
	\begin{eklersayf}
		\vspace*{\fill}
		\textbf{\MakeUppercase{Ekler}}
		\vspace*{\fill}
	\end{eklersayf}
	\addtocontents{toc}{\protect\setcounter{tocdepth}{0}}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Alıntı ortamının düzenlenmesi

\NewDocumentCommand{\kimden}{m}{%
	{\nobreak\hfill\penalty50\hskip1em\null\nobreak
		\hfill\mbox{\normalfont(#1)}%
		\parfillskip=0pt \finalhyphendemerits=0 \par}%
}
\renewcommand*{\quotingfont}{\setstretch{1.0}\fontsize{10}{12}\selectfont\setlength{\parskip}{18pt}}
\NewDocumentEnvironment{alinti}{m}
{\vspace{-6pt}\begin{quoting}[indentfirst=true,
		leftmargin=1.5cm,
		rightmargin=1.5cm,
		begintext=",
		endtext=,
		]}
	{"\kimden{#1}\end{quoting}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% KAYNAKÇA FORMAT DÜZENLENMESİ %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Son yazardan önceki "ve" kelimesinin silinmesi. (Kaynakça içinden)
\DeclareDelimAlias[bib]{finalnamedelim}{multinamedelim}

% Başlıklarda bulunan " işaretinin kaldırılması.
\DeclareFieldFormat
[article,book,booklet,conference,inbook,incollection,manual,masterthesis,misc,phdthesis,procedings,techreport,inproceedings,patent,thesis,unpublished]
{title}{#1\isdot}

% Yazarların soyad-ad üzerinden sıralanması.
\DeclareNameAlias{sortnames}{family-given}
\DeclareNameAlias{default}{family-given}
\DeclareNameAlias{author}{family-given}
\DeclareNameAlias{editor}{family-given}

% Yazar-Yıl ikilisinin arasına virgül eklenmesi.
\renewcommand*{\nameyeardelim}{\addcomma\space}

% Kaynakçada alt satırın 1cm içeri kaydırılması.
\setlength{\bibhang}{1cm}
\setlength{\bibitemsep}{\baselineskip}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Makale(article) format duzenlenmesi.

% Dergi cilt numarasının italik olarak düzenlenmesi.
\DeclareFieldFormat[article]{volume}{\textit{#1}\nopunct}
% Dergi başlığının italik olarak düzenlenmesi.
\DeclareFieldFormat[article]{journaltitle}{\textit{#1},}
% Dergi sayı numarasının düzenlenmesi.
\DeclareFieldFormat[article]{number}{(#1)}
% Dergi sayfa numarasının düzenlenmesi.
\DeclareFieldFormat[article]{pages}{#1}
% Dergi DOI numarasının düzenlenmesi.
\DeclareFieldFormat[article]{doi}{DOI: \ifhyperref	{\href{https://doi.org/#1}{#1}}{{#1}}}

% Makale formatının düzenlenmesi.
\DeclareBibliographyDriver{article}{%
	\usebibmacro{bibindex}%
	\usebibmacro{begentry}%
	\usebibmacro{author/translator+others}%
	\setunit{\addcomma\space}%
	\newunit\newblock%
	\usebibmacro{title}%
	\setunit{\addperiod\space}%
	\printfield{journaltitle}%
	\addcomma\addspace%
	\printfield{volume}%	
	\printfield{number}%
	\addcomma\addspace%
	\printfield{pages}%
	\addperiod%
	\addspace%
	\iffieldundef{doi}%
	{}
	{\printfield{doi}}
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Kitap(book) format duzenlenmesi.

% Kitap basım sayısı (edition) düzenlenmesi.
\DeclareFieldFormat[book,inbook]{edition}{(#1.~\printtext{Bs.\@})}
% Kitap sayfalarının düzenlenmesi.
\DeclareFieldFormat[book,inbook]{pages}{(#1)}
% Yayıncının düzenlenmesi.
\newbibmacro*{gPublish}{\printlist{location}\addcolon\addspace\printlist{publisher}}
% Başlığın düzenlenmesi.
\newbibmacro*{gBookTitle}{\mkbibitalic{\printfield{title}}\addspace\printfield{edition}}%

% Kitap formatının düzenlenmesi.
\DeclareBibliographyDriver{book}{%
	\usebibmacro{bibindex}%
	\usebibmacro{begentry}%
	\usebibmacro{author/translator+others}%
	\setunit{\addperiod\addspace}%
	\usebibmacro{gBookTitle}%
	\setunit{\addperiod\addspace}%
	\usebibmacro{gPublish}%
	\addperiod%
}

% Kaynak kitaptan bir bölüm olduğunda (inbook)
% editörün belirten yazının düzenlenmesi.
\newbibmacro*{gEditorStr}{(Ed.), }
% Başlığın düzenlenmesi.
\newbibmacro*{gInBookTitle}{\printfield{title}\addperiod}%
% Editörün düzenlenmesi.
\newbibmacro*{gInBookEditor}{\printnames{editor}\addcomma}%

% Kitap içinden bölüm (inbook) formatının düzenlenmesi.
\DeclareBibliographyDriver{inbook}{%
	\usebibmacro{bibindex}%
	\usebibmacro{begentry}%
	\usebibmacro{author/translator+others}%
	\setunit{\addperiod\space}%
	\usebibmacro{gInBookTitle}%
	\setunit{\space}%
	\usebibmacro{gInBookEditor}%
	\addspace%
	\usebibmacro{gEditorStr}%
	\setunit{\addcomma\space}%
	\printfield{booktitle}%
	\addspace%
	\printfield{edition}%
	\addspace%
	\printfield{pages}%
	\addperiod%
	\addspace%
	\usebibmacro{publisher+location+date}%
	\addperiod%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bildiri(inproceeding) format duzenlenmesi.

% Bildiri başlığının düzenlenmesi.
\DeclareFieldFormat[inproceeding]{title}{#1}

% Bildiri formatının düzenlenmesi.
\DeclareBibliographyDriver{inproceeding}{%
	\usebibmacro{bibindex}%
	\usebibmacro{begentry}%
	\usebibmacro{author/translator+others}%
	\setunit{\addcomma\space}%
	\newunit\newblock%
	\usebibmacro{title}%
	\setunit{\addperiod\space}%
	\iflistundef{organization}%
		{}%
		{\addspace\mkbibitalic{\printlist{organization}}\addcomma\addspace}%
	\iflistundef{location}%
		{}%
		{\addspace{\printlist{location}}\addcomma\addspace}%
	\addcomma\addspace%
	\printeventdate%
	\addperiod%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tez(thesis) format duzenlenmesi.

% Tez başlığının düzenlenmesi.
\DeclareFieldFormat[inproceeding]{title}{#1}

% Biblatex içerisinde "school" alanı(field), otomatik olarak 
% institution alanına eşitlenmektedir. Bu eşitlenme nedeniyle aynı anda 
% her iki alanın kullanımına izin verilmemektedir. Bunu aşabilmek amacıyla
% kullanılmayan ama tanımlanmış olan alanlardan biri olan "origtitle" alanı
% üzerine school alanı tekrar yazılmıştır. Böylece .bib dosyası içerisinde
% tez tanımlamasında school ve institution aynı anda kullanılabilmektedir.
\DeclareSourcemap{
	\maps[datatype=bibtex]{
		\map[overwrite]{
			\step[fieldsource=school, fieldtarget=origtitle]
		}
	}
}

% Tez formatının düzenlenmesi.
\DeclareBibliographyDriver{thesis}{%
	\usebibmacro{bibindex}%
	\usebibmacro{begentry}%
	\usebibmacro{author/translator+others}%
	\setunit{\addcomma\space}%
	\newunit\newblock%
	\usebibmacro{title}%
	\setunit{\addperiod\space}%
	\printfield{type}%
	\addcomma\addspace%
	\iffieldundef{origtitle}%
		{}%
		{\printfield{origtitle}}%
	\addcomma\addspace%
	\iflistundef{institution}%
		{}%
		{\printlist{institution}}%
	\addcomma\addspace%
	\printlist{location}%
	\iffieldundef{number}%
		{}%
		{\addcomma\addspace\printfield{number}}%
	\addperiod%
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rapor(techreport) format duzenlenmesi.

% Rapor başlığının düzenlenmesi.
\DeclareFieldFormat[report]{title}{#1}

% Rapor sayfalarının düzenlenmesi.
\DeclareFieldFormat[report]{pages}{#1}

% Rapor formatının düzenlenmesi.
\DeclareBibliographyDriver{report}{%
	\usebibmacro{bibindex}%
	\usebibmacro{begentry}%
	\usebibmacro{author}%
	\setunit{\addcomma\space}%
	\newunit\newblock%
	\usebibmacro{title}%
	\setunit{\addcomma\space}%
	\iflistundef{institution}%
	{}%
	{\mkbibitalic{\printlist{institution}}}%
	\addcomma\addspace%
	\iffieldundef{number}%
	{}%
	{\printfield{number}}%
	\addcomma\addspace%
	\printfield{pages}%
	\addperiod%
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Web Sayfası (online) format duzenlenmesi.

% Verılen linklerin formatının düzenlenmesi.
\DeclareFieldFormat[online]{url}{\ifhyperref	{\href{#1}{#1}}{{#1}}}

% Yazarsız ve nocite ile verilen linklerin sayacı.
\newcounter{nocitecounter}

% Online formatta yazar olmadığı durumda kaynakça içerisinde ki 
% sıralamayı doğru yapabilmek için, sıralamada kullanılan diğer 
% alanlardan biri olan sorttitle alanını eğer boş ise "url" değeriyle
% değiştirilip böylece urlnin doğru sıralamada olması düzenlenmiştir.
\DeclareSourcemap{
	\maps[datatype=bibtex]{
		\map[overwrite]{
			\step[fieldset=sorttitle, match={}, fieldvalue={url}, final]
		} 
	}
}

% Rapor formatının düzenlenmesi.
\DeclareBibliographyDriver{online}{%
	\usebibmacro{bibindex}%
	\usebibmacro{begentry}%
	\ifnameundef{author}%
		{\stepcounter{nocitecounter}\printtext{URL-\thenocitecounter}\addcolon\addspace}%
		{\usebibmacro{author/translator+others}\setunit{\addcomma\space}}%	
	\newunit\newblock%
	\usebibmacro{title}%
	\setunit{\addperiod\space}%
	\iflistundef{location}%
		{}%
		{\printlist{location}}%
	\addcomma\addspace%
	\iffieldundef{url}%
	{}%
	{\printfield{url}}%
	\addspace%
	\printtext{(Ziyaret Tarihi:\printeventdate)\@}%
	\addperiod%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Patent format duzenlenmesi.

% Patent formatının düzenlenmesi.
\DeclareBibliographyDriver{patent}{%
	\usebibmacro{bibindex}%
	\usebibmacro{begentry}%
	\usebibmacro{author}%
	\addperiod\addspace%
	\usebibmacro{title}%
	\addcomma\addspace%
	\printfield{number}\@%
	\addcomma\space%
	\mkbibitalic{\printnames{holder}}%
	\addperiod%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Standart (misc) format duzenlenmesi.

% Standart'a özel olarak kurum ve yıl alan bilgilerinin düzenlenmesi.
\newbibmacro*{gAuthorYear}{\printnames{author}\addperiod\addspace(\printfield{year})\addperiod}%

% Standart'a özel olarak standart numarası düzenlemesi.
\newbibmacro*{gStNumber}{(\printfield{number})}%

% Standart formatının düzenlenmesi.
\DeclareBibliographyDriver{misc}{%
	\usebibmacro{bibindex}%
	\usebibmacro{begentry}%
	\usebibmacro{gAuthorYear}%
	\addspace%
	\mkbibitalic{\printfield{title}}\addspace\nopunct%
	\usebibmacro{gStNumber}%
	\addperiod\space%
	\printlist{location}%
	\addperiod%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Kanun, yönetmelik, resmi gazete (mamual) format duzenlenmesi.

% Manual için kurum ve yıl alan bilgilerinin düzenlenmesi.
\newbibmacro*{gTitleYear}{\usebibmacro{title}\addperiod\addspace(\printfield{year})}%

% Standart'a özel olarak standart numarası düzenlemesi.
\newbibmacro*{gSayiTarih}{(\printfield{number})}%

% Standart formatının düzenlenmesi.
\DeclareBibliographyDriver{manual}{%
	\usebibmacro{bibindex}%
	\usebibmacro{begentry}%
	\usebibmacro{gTitleYear}%
	\addperiod\space%
	\printlist{location}%
	\addspace%
	\usebibmacro{gSayiTarih}%
	\addperiod\addspace%	
	\printlist{publisher}%
	\addperiod%
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Kaynakça sıralamasında kullanılan alanlar ve önceliklerine göre sıralanmaları.
\DeclareSortingTemplate{gSort}{
	\sort{
		\field{sortname}
		\field{author}
		\field{editor}
		\field{translator}
		\field{title}
		\field{sorttitle}
		\field{publisher}
	}
}

\newrefcontext[sorting=gSort]

