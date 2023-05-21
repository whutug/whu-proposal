# whu-proposal

## 主要内容

武汉大学本科生的开题报告模版已经[由 whu-tug 开发](https://github.com/whutug/whu-thesis)，但是研究生的模版仍然只有 word 版本，对于数学系的同学来说，相较于 LaTeX 来说，使用 word 进行排版数学公式并不是一件容易的事情。而且 LaTeX 使用 bib 数据库进行参考文献的管理，可以很方便地实现参考文献的引用。

于是我基于《附件1：研究生学位论文开题报告登记表》开发了此模版，希望能够让同学们更方便、高效地完成开题报告的撰写。

下面是示例文件：

```latex
% \documentclass[type = bachelor]{whu-proposal}  % 本科生
% \documentclass[type = master]{whu-proposal}      % 硕士生
\documentclass[type = doctor]{whu-proposal}      % 博士生


% 个人信息
\ProposalSetup{
  title            = { 论文题目 } ,
  department       = { 数学与统计学院 } ,
  student_id       = { 2021202012345 } ,
  author           = { 作者姓名 } ,
  % 下面的内容只有【硕｜博】需要填写
  major            = { 基础数学 } ,
  research_area    = { 算子理论 } , 
  supervisor       = { 导师姓名 } ,
  supervisor_title = { 教授 } ,
  year             = { 2023 },  % 年份不填写时默认为编译时的年份
  month            = { 5 },     % 月份不填写时默认为编译时的月份
  day              = { 21 },    % 日期不填写时默认为编译时的日期
}


% 载入所需宏包，下面的仅为示例文件中需要，实际使用时可根据需要增减

% 参考文献
\usepackage[
  backend      = biber,
  bibstyle     = gb7714-2015,
  citestyle    = gb7714-2015
]{biblatex}
\addbibresource{whu-proposal.bib}  % 参考文献数据库



% 自定义命令，下面的仅为示例文件中需要，实际使用时可根据需要增减
\newcommand\tool{\texttt}
\newcommand\tn[1]{\texttt{\textbackslash#1}}
\newcommand\file{\nolinkurl}



\begin{document}

% 目录，不需要的话可去除
\tableofcontents


% 正文内容
\input{body/motivation.tex}
\input{body/usage.tex}
\input{body/reference.tex}



% 参考文献

% \printbibliography  % “参考文献”一节标题不编号
\printbibliography[heading = bibnumbered]  % “参考文献”一节标题编号


\end{document}
```

## 参与贡献

### 仓库地址
Github：https://github.com/whutug/whu-proposal
Gitee：https://gitee.com/xkwxdyy/whu-proposal

### 提issues
#### Github
issues: https://github.com/whutug/whu-proposal/issues

#### Gitee
issues: https://gitee.com/xkwxdyy/whu-proposal/issues

