# whu-proposal

**注意**：开题报告上传系统的时候可能只能上传 `.doc` 文件，有以下解决办法：
1. 将 LaTeX 编译生成的 PDF 转为图片（一般的 PDF 编辑器都可以做到）
2. 将图片插入 `.doc` 或 `.docx` 文件中保存
3. 上传系统

## 主要内容

武汉大学本科生的开题报告模版已经[由 whu-tug 开发](https://github.com/whutug/whu-thesis)，但是研究生的模版仍然只有 word 版本，对于数学系的同学来说，相较于 LaTeX 来说，使用 word 进行排版数学公式并不是一件容易的事情。而且 LaTeX 使用 bib 数据库进行参考文献的管理，可以很方便地实现参考文献的引用。

于是我基于《附件1：研究生学位论文开题报告登记表》开发了此模版，希望能够让同学们更方便、高效地完成开题报告的撰写。

为了方便本硕博同学使用，本模版已将本硕博的开题报告整合，用户仅需根据自己的需求在 `\documentclass[type = ...]{whu-proposal} ` 的 `type` 中填写自己对应的类型即可（详见示例文件）


## 下载

1. 点击 [github 项目主页](https://github.com/whutug/whu-proposal) 右侧的 [releases](https://github.com/whutug/whu-proposal/releases) （或者 [gitee(https://gitee.com/xkwxdyy/whu-proposal)] 的发行版下方的最新版本（一般格式为 `vx.x - yyyy/mm/dd`，如 `v0.3 - 2023-06-09`）
2. 点击 `Assets` 下的 `whu-proposal-vx.x.zip` 即可下载


## 使用

注意，本模版不包含 LaTeX 入门内容，比如 TeXLive 安装（见  [install-latex-guide-zh-cn](https://mirrors.cloud.tencent.com/CTAN/info/install-latex-guide-zh-cn/install-latex-guide-zh-cn.pdf) ） 和 LaTeX 基础入门（见 [lshort-zh-cn](https://mirrors.pku.edu.cn/ctan/info/lshort/chinese/lshort-zh-cn.pdf) ）.

模版中包含一个示例文件，也是模版的使用说明文件，请先阅读完再进行使用。

### 离线使用

本地安装 TeXLive ，然后下载后进行使用即可。（请注意 TeXLive 的版本需要至少是 2021 以后的）

### 在线使用

推荐使用 TeXPage（因为是国内的，所以速度一般会比 Overleaf 快）

#### TeXPage

目前模版已经在 [TeXPage](https://www.texpage.com/template/15c655db-e4d1-41d9-a595-c9969314e798) 上申请成为模版，打开链接，点击 `使用此模板新建项目` 按钮即可。

#### Overleaf

目前模版已经在 [Overleaf](https://www.overleaf.com/latex/templates/whu-proposal-v0-dot-7/fhgjpzskjvhd) 上申请成为模版，打开链接，点击 `Open as Template` 按钮即可。

## 示例文件

```latex
% \documentclass[type = bachelor]{whu-proposal}  % 本科生
\documentclass[type = master]{whu-proposal}      % 硕士生
% \documentclass[type = doctor]{whu-proposal}      % 博士生


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

