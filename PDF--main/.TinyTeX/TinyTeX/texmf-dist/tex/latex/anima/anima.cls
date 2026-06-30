%%
%% This is file `anima.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% anima.dtx  (with options: `class')
%% ----------------------------------------------------------------
%% anima --- Class for creating slideshow with simple animations with TikZ
%% E-mail: adriano_gsgs@hotmail.com
%% Written by Adriano Gomes de Santana
%% Released under the LaTeX Project Public License v1.3c or later
%% See http://www.latex-project.org/lppl.txt
%% ----------------------------------------------------------------
%% 

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{anima}[2024/11/12 Classe Anima para Animations]
\LoadClass[multi=page]{standalone}

\RequirePackage{pgf,tikz}[1994/06/01]
\usetikzlibrary{positioning}

\newcommand\animaFormatText{\large}
\newcommand\animaFormatTitle{\large\bf}
\newcommand{\animaFrameTitle}[4]{
\begin{anima}
\node (centro) at (0,0) {};
\begin{block}{\huge\vphantom{Íq} #1}
[(\anima@BoardWidth-.15)*1cm]
[above = of centro,
align = center]
[node distance = 0.5cm, below = of animaPosBlock]
\\\Large #2
\end{block}
\node[
text width = {(2*\anima@BoardWidth-0.25)*1cm},
node distance = 3.5cm,
below = of centro]
{#3\hfill #4};
\end{anima}
}

\newcommand\animaBoardDimension[2]{
\def\anima@BoardWidth{(#1/2)}
\def\anima@BoardHeight{(#2/2)}
}
\animaBoardDimension{16}{9}

\newcommand{\animaColorTheme}[6]{
\definecolor{anima@BoardColor} {HTML}{#1}
\definecolor{boardColor} {HTML}{#1}
\definecolor{anima@TextColor} {HTML}{#2}
\definecolor{textColor} {HTML}{#2}
\definecolor{anima@Color1}   {HTML}{#3}
\definecolor{animaColor1} {HTML}{#3}
\definecolor{anima@Color2}   {HTML}{#4}
\definecolor{animaColor2} {HTML}{#4}
\definecolor{anima@Color3}   {HTML}{#5}
\definecolor{animaColor3} {HTML}{#5}
\definecolor{anima@Color4}   {HTML}{#6}
\definecolor{animaColor4} {HTML}{#6}
}

\def\animaColorThemeI{
\animaColorTheme{FFFFFF}
{000000}
{0000FF}
{FF0000}
{00FF00}
{FFFF00}
}
\def\animaColorThemeII{
\animaColorTheme{FFFFFF}
{660907}
{016BBF}
{FF0000}
{00FFFF}
{FFD16A}

}

\animaColorThemeI

\newcommand\animaBackgroud{
\draw[dotted, opacity=.2,line width = .3pt] %
({-\anima@BoardWidth},{-\anima@BoardHeight}) grid %
({\anima@BoardWidth},{\anima@BoardHeight});
}

\NewExpandableDocumentCommand
{\uns}{s o o m m m}{
    %\IfNoValueTF{#2}{
    % Não há #2 nem #3
        \ifnum#5=0
            (\um*(#4+#6)>=#4?1:0)
        \else
           \IfBooleanTF{#1}{
               (\um*(#4+#5+#6)<#4?0:
                (\um*(#4+#5+#6)>=#4+#5?1:
                (
                    -((2*(#6+#5+#4)^3)/#5^3)*(\um)^3+
                    ((3*(#5+2*#4)*(#6+#5+#4)^2)/#5^3)*(\um)^2+
                    -((6*#4*(#5+#4)*(#6+#5+#4))/#5^3)*\um+
                    ((#4^2*(3*#5+2*#4))/#5^3)
                )
                ))
            }{
               (\um*(#4+#5+#6)<#4?0:
                (\um*(#4+#5+#6)>=#4+#5?1:
                (((#4+#5+#6)/#5)*\um-#4/#5)
                ))
            }
        \fi
    %}{
    %    \IfNoValueTF{#3}{
    %        % Há #2, mas não há #3
    %        \ifnum#4=0
    %            \ifnum#5=0
    %                1
    %            \else
    %                1
    %            \fi
    %        \else
    %            \ifnum#5=0
    %                1
    %            \else
    %                1
    %            \fi
    %        \fi
    %    }{
    %        \ifnum#4=0
    %            \ifnum#5=0
    %                1
    %            \else
    %                1
    %            \fi
    %        \else
    %            \ifnum#5=0
    %                1
    %            \else
    %                1
    %            \fi
    %        \fi
    %    }
    %}
}
\newcommand{\zeros}[3]{(1-\uns{#1}{#2}{#3})}

\newcount\anima@FrameCount
\newcount\nFrame
\NewDocumentEnvironment{anima}{+O{1} +b}{
\ifnum #1 = 1
\def\um{1}
\def\zero{0}
\begin{page}%
\begin{tikzpicture}[color=anima@TextColor,line width=1.5pt]
\clip ({-\anima@BoardWidth},{-\anima@BoardHeight})
rectangle ({\anima@BoardWidth},{\anima@BoardHeight});
\fill[color=anima@BoardColor]
({-\anima@BoardWidth},{-\anima@BoardHeight})
rectangle ({\anima@BoardWidth},{\anima@BoardHeight});
\animaBackgroud
\node (animaPosBlock) at \anima@PositionBlock{};
#2
\end{tikzpicture}%
\end{page}
\else
\anima@FrameCount = 0
\loop
\nFrame = \anima@FrameCount
\def\um{(\the\anima@FrameCount/(#1-1))}
\def\zero{(1-\um)}
\begin{page}%
\begin{tikzpicture}[color=anima@TextColor,line width=1.0pt]
\clip
({-\anima@BoardWidth},{-\anima@BoardHeight}) rectangle
({\anima@BoardWidth},{\anima@BoardHeight});
\fill[color=anima@BoardColor]  
({-\anima@BoardWidth},{-\anima@BoardHeight}) rectangle
({\anima@BoardWidth},{\anima@BoardHeight});
\animaBackgroud
\node (animaPosBlock) at \anima@PositionBlock {};
#2
\end{tikzpicture}%
\end{page}
\advance \anima@FrameCount +1
\ifnum \anima@FrameCount < #1 \repeat
\fi
}{}

\renewenvironment{frame}[1][1]{\begin{anima}[#1]}{\end{anima}}

\def\anima@PositionBlock{(0,{\anima@BoardHeight})}
\def\anima@WhidthBlock{\anima@BoardWidth*0.9875 cm}

\tikzstyle{anima@themeBlock}=[
draw,
bottom color = BlockColor,
top color    = BlockColor!50!anima@BoardColor
]

\newcommand{\animaStyle}[1]{
\def\anima@NameStyle{#1}
\def\anima@animaStyle{anima}
\def\anima@defaultStyle{default}
\ifx\anima@NameStyle\anima@animaStyle
\tikzstyle{anima@themeBlock}=[
draw = BlockColor,
bottom color = BlockColor,
top color    = BlockColor!50!anima@BoardColor,
rounded corners=1.4pt
]
\else
\tikzstyle{anima@themeBlock}=[
draw,
bottom color = BlockColor,
top color    = BlockColor!50!anima@BoardColor
]
\fi
}
\newcommand{\animaColor}[1]{
\def\anima@NameColor{#1}
\def\anima@browntextColor{browntext}
\def\anima@greenboardColor{greenboard}
\def\anima@blackboardColor{blackboard}
\def\anima@graytextColor{graytext}
\def\anima@nfColor{nf}
\def\anima@defaultColor{default}
\ifx\anima@NameColor\anima@browntextColor
\animaColorTheme
{FFFFFF}{660907}{016BBF}
{FF0000}{00FFFF}{FFD16A}
\else\ifx\anima@NameColor\anima@greenboardColor
\animaColorTheme
{00542C}{FFFFFF}{2222FF}
{FF3333}{00FF00}{FFFF00}
\else\ifx\anima@NameColor\anima@blackboardColor
\animaColorTheme
{252B26}{FFFFFF}{2BA8D9}
{F23030}{2EA662}{F28322}
\else\ifx\anima@NameColor\anima@graytextColor
\animaColorTheme
{FFFFFF}{252B26}{2BA8D9}
{F23030}{2EA662}{F28322}
\else\ifx\anima@NameColor\anima@nfColor
\animaColorTheme
{252B26}{FFFFFF}{2BA8D9}
{F23030}{2EA662}{EEEE44}%{F28322}
\else
\animaColorTheme%
{FFFFFF}{000000}{0000FF}%
{FF0000}{00FF00}{FFFF00}
\fi\fi\fi\fi

}

\newcommand{\animaTheme}[1]{
\def\anima@NameTheme{#1}
\def\anima@defaultTheme{default}
\def\anima@LTbarTheme{LTbar}
\def\anima@planeTheme{plane}
\ifx\anima@NameTheme\anima@LTbarTheme
\renewcommand\animaBackgroud{
\draw[dotted, opacity=.2,line width = .3pt] %
({-\anima@BoardWidth},{-\anima@BoardHeight}) grid %
({\anima@BoardWidth},{\anima@BoardHeight});
\fill[
anima@Color3,
draw=anima@Color3!50!anima@BoardColor,
opacity=.7]
({-\anima@BoardWidth},{-\anima@BoardHeight}) rectangle
({-0.7*\anima@BoardWidth},{\anima@BoardHeight});
\fill[
anima@Color3,
draw=anima@Color3!50!anima@BoardColor,
opacity=.5]
({-\anima@BoardWidth+2.4},{\anima@BoardHeight}) rectangle
({\anima@BoardWidth},{0.7*\anima@BoardHeight});
\node at (-5,4.5) [anchor=north west]{\begin{minipage}{14cm}\color{anima@TextColor} \small
\textbf{\@title}\vspace{-5pt}

\@author
\end{minipage}};
}
\else\ifx\anima@NameTheme\anima@planeTheme
\renewcommand\animaBackgroud{}
\else
\renewcommand\animaBackgroud{
\draw[dotted, opacity=.2,line width = .3pt] %
({-\anima@BoardWidth},{-\anima@BoardHeight}) grid %
({\anima@BoardWidth},{\anima@BoardHeight});
}
\fi\fi
}

\NewDocumentEnvironment{block}
{+O{animaPosBlock} +m +O{\anima@WhidthBlock} +O{} +O{} +b}
{
\colorlet{BlockColor}{anima@Color1}
\node[
anima@themeBlock,
text width = {2*#3-0.25cm},
node distance = 0.0cm,
below = of {#1}, #4]
(animaPosBlock) {\animaFormatTitle\vphantom{Íq} #2};
\node[ text width = {2*#3-0.25cm},
node distance = 0.0cm,
below = of animaPosBlock,#5]
(animaPosBlock) {\animaFormatText #6};
}{}

\NewDocumentEnvironment{alertblock}
{+O{animaPosBlock} +m +O{\anima@WhidthBlock} +O{} +O{} +b}
{
\colorlet{BlockColor}{anima@Color2}
\node[
anima@themeBlock,
text width = {2*#3-0.25cm},
node distance = 0.0cm,
below = of {#1}, #4]
(animaPosBlock) {\animaFormatTitle\vphantom{Íq} #2};
\node[ text width = {2*#3-0.25cm},
node distance = 0.0cm,
below= of animaPosBlock,#5]
(animaPosBlock) {\animaFormatText #6};
}{}

\NewDocumentEnvironment{exampleblock}
{+O{animaPosBlock} +m +O{\anima@WhidthBlock} +O{} +O{} +b}
{
\colorlet{BlockColor}{anima@Color3}
\node[
anima@themeBlock,
text width = {2*#3-0.25cm},
node distance = 0.0cm,
below = of {#1}, #4]
(animaPosBlock) {\animaFormatTitle\vphantom{Íq} #2};
\node[ text width = {2*#3-0.25cm},
node distance = 0.0cm,
below= of animaPosBlock,
#5]
(animaPosBlock) {\animaFormatText #6};
}{}

\NewDocumentEnvironment{anotherblock}
{+O{animaPosBlock} +m +O{\anima@WhidthBlock} +O{} +O{} +b}
{
\colorlet{BlockColor}{anima@Color4}
\node[
anima@themeBlock,
text width = {2*#3-0.25cm},
node distance = 0.0cm,
below = of {#1}, #4]
(animaPosBlock) {\animaFormatTitle\vphantom{Íq} #2};
\node[ text width = {2*#3-0.25cm},
node distance = 0.0cm,
below= of animaPosBlock,
#5]
(animaPosBlock) {\animaFormatText #6};
}{}

\NewDocumentEnvironment{notitleblock}
{+O{animaPosBlock} +O{\anima@WhidthBlock} +O{} +b}
{
\node[
text width = {2*#2-0.25cm},
node distance = 0.0cm,
below= of animaPosBlock,
#3]
(animaPosBlock) {\animaFormatText #4};
}{}

\newcommand{\animaExemplo}{\large
\begin{block}[(0,4.2)]{LAYOUT EXAMPLE WITH BLOCK OF TITLE}[7.9cm]
\end{block}

\begin{exampleblock}[(-4,3)]{EXAMPLE BLOCK}[3.9cm]
A example of block with a equation
$$f(x)=2\sin(.57x)$$
\end{exampleblock}

\begin{alertblock}{ALERT BLOCK}[3.9cm]
\end{alertblock}

\begin{scope}[
shift={(4,-2)},
scale=1.3,
rotate around x= {360*\uns011},
rotate around y= {360*\uns110}]
\draw[animaColor1,-latex] (0,0)--(1,0)node[anchor=north]{$x$};
\draw[animaColor2,-latex] (0,0)--(0,1)node[anchor=east]{$y$};
\draw[animaColor4] (-1,-1,-1)--(1,-1,-1)--(1,1,-1)--(-1,1,-1)--cycle;
\draw[animaColor4] (-1,-1,1)--(1,-1,1)--(1,1,1)--(-1,1,1)--cycle;
\draw[animaColor4] (-1,-1,-1)--(-1,-1,1) (1,-1,-1)--(1,-1,1)
(1,1,-1)--(1,1,1) (-1,1,-1)--(-1,1,1);
\draw[anima@Color3,-latex] (0,0)--(0,0,1)node[anchor=south]{$z$};
\end{scope}

\node at (0,3) [anchor=north west]{
\begin{minipage}{7.25cm}\animaFormatText
{\color{textColor} Text in the color textColor}\\
{\color{animaColor1} Text in the color animaColor1}\\
{\color{animaColor2} Text in the color animaColor2}\\
{\color{animaColor3} Text in the color animaColor3}\\
{\color{animaColor4} Text in the color animaColor4}\\
\end{minipage}};

\begin{scope}[shift={(-7,-4)},color=animaColor2]
\draw[-latex] (-.5,0)--(6,0)node[anchor=north]{$x$};
\draw[-latex] (0,-.5)--(0,3)node[anchor=east]{$f(x)$};
\def\numero{\the\nFrame}
\foreach \i in {-1,0,...,\numero}{
\fill[color=animaColor4]
({1.25+(\i+1)*(4/((\numero)+2))},0)--
({1.25+(\i+2)*(4/((\numero)+2))},0)--
({1.25+(\i+2)*(4/((\numero)+2))},{2*sin(.6*(1+(\i+2)
*(4/((\numero)+2))) r)})--
({1.25+(\i+1)*(4/((\numero)+2))},{2*sin(.6*(1+(\i+2)
*(4/((\numero)+2))) r)})--
cycle;
\draw[-latex] (-.5,0)--(6,0)node[anchor=north]{$x$};
\draw[-latex] (0,-.5)--(0,3)node[anchor=east]{$f(x)$};
\draw[color=animaColor3,domain=0:{5.7}] plot (\x,{2*sin(.57*\x r)});
\draw[color=animaColor1,domain=0:{5.7*\um}] plot (\x,{2*sin(.57*\x r)});
}
\end{scope}
}
%% 
%% Copyright (C) 2009 by Adriano Gomes de Santana <adriano_gsgs@hotmail.com>
%% 
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License (LPPL), either
%% version 1.3c of this license or (at your option) any later
%% version.  The latest version of this license is in the file:
%% 
%% http://www.latex-project.org/lppl.txt
%% 
%% This work is "maintained" (as per LPPL maintenance status) by
%% Adriano Gomes de Santana.
%% 
%% This work consists of the file  anima.dtx
%% and the derived files           anima.ins,
%%                                 anima.pdf and
%%                                 anima.cls.
%% 
%%
%% End of file `anima.cls'.
