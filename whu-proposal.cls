%
% Copyright (c) 2023 Kangwei Xia
% Released under the LaTeX Project Public License v1.3c License.
% Repository: https://gitee.com/xkwxdyy/whu-proposal
%

\NeedsTeXFormat{LaTeX2e}[2017/04/15]
\RequirePackage { expl3 }
\RequirePackage { xparse }
\RequirePackage { l3keys2e }
\ProvidesExplClass {whu-proposal} {2023-09-26} {v0.8} {LaTeX template for thesis proposal for students in Wuhan University}


\bool_new:N \g__whuproposal_bachelor_type_bool  % 判断开题报告类型
\box_new:N \l__whuproposal_tmp_box
\box_new:N \l__whuproposal_tmpa_box
\box_new:N \l__whuproposal_tmpb_box
\dim_new:N \l__whuproposal_tmp_dim
\dim_new:N\l__whuproposal_tmpa_dim
\dim_new:N\l__whuproposal_tmpb_dim
\int_new:N \l__whuproposal_tmp_int
\tl_new:N \l__whuproposal_tmpa_tl
\tl_new:N \l__whuproposal_tmpb_tl
\clist_new:N \l__whuproposal_tmpa_clist
\clist_new:N \l__whuproposal_tmpb_clist
\bool_new:N \g__whuproposal_if_title_multiline_bool  % 判断加入标题后是否变成多行

% % 检查 LaTeX2e kernel 版本
% \msg_new:nnn { whu-proposal } { latex-too-old }
%   { TeX~ Live~ 2020~ or~ later~ version~ is~ required~ to~ compile~ this~ document. }
% \@ifl@t@r \fmtversion { 2020/02/02 }
%   { }
%   { \msg_fatal:nn { whu-proposal } { latex-too-old } }

% 检查编译引擎，要求使用 XeLaTeX。
\msg_new:nnn { whu-proposal } { incompatible-engine }
  { XeLaTeX~ is~ required~ to~ compile~ this~ document. }

\sys_if_engine_xetex:F
  { \msg_fatal:nn { whu-proposal } { incompatible-engine } }


% 使用 l3keys 定义 \ProposalSetup 配置命令
\NewDocumentCommand \ProposalSetup { m }
  { \keys_set:nn { whu-proposal } {#1} }



% 加载文档类和宏包

% 处理文档类选项
\keys_define:nn { whu-proposal / option }
  {
    type .choice:,
    type .value_required:n = true,
    type / bachelor .code:n =
      {
        \bool_gset_true:N \g__whuproposal_bachelor_type_bool
      } ,
    type / master .code:n =
      {
        \bool_gset_false:N \g__whuproposal_bachelor_type_bool
      } ,
    type / doctor .code:n =
      {
        \bool_gset_false:N \g__whuproposal_bachelor_type_bool
      },
    type .initial:n = bachelor
  }
\ProcessKeysOptions { whu-proposal / option }


\PassOptionsToClass { UTF8 , a4paper , scheme = chinese } { ctexart }
\bool_if:NT \g__whuproposal_bachelor_type_bool
  {
    \PassOptionsToClass { zihao = -4 } { ctexart }
  }
\RequirePackage { filehook }
\AtEndOfPackageFile* { fontspec }
  { \msg_redirect_name:nnn { fontspec } { no-script } { none } }
\AtEndOfPackageFile* { xeCJK }
  {
    \msg_redirect_name:nnn { xeCJK } { CJKfamily-redef } { none }
    \defaultCJKfontfeatures { Script  = CJK }
  }

% 载入 \cls{ctexart} 文档类。
\LoadClass { ctexart }

% 要求 ctex v2.4.9 2017-04-01 或更高的版本。
\msg_new:nnn { whu-proposal } { require-package-version }
  { The~ package~ "#1"~ is~ required. }

\@ifclasslater { ctexart } { 2017/04/01 }
  { }
  {
    \msg_fatal:nnn { whu-proposal } { require-package-version }
      { ctex~ v2.4.9~ 2017-04-01 }
  }

% 建议在模板开始处载入全部宏包，不要轻易改变加载顺序。
\RequirePackage { etoolbox }
\RequirePackage { geometry }
\RequirePackage { graphicx }
\RequirePackage { fontspec }
\RequirePackage { xeCJK }
\RequirePackage { xeCJKfntef }
\RequirePackage { fancyhdr }
\RequirePackage { lastpage }
\RequirePackage { needspace }
\RequirePackage { tikzpagenodes }

\AtEndPreamble 
  {
    \RequirePackage [ hidelinks ] { hyperref }
  }




% 对冲突的宏包报错。
\msg_new:nnn { whu-proposal } { package-conflict }
  { The~ "#2"~ package~ is~ incompatible~ with~ "#1". }

\cs_new:Npn \whuproposal_package_conflict:nn #1#2
  {
    \AtEndOfPackageFile* {#1}
      {
        \AtBeginOfPackageFile* {#2}
          { \msg_error:nnnn { whu-proposal } { package-conflict } {#1} {#2} }
      }
  }

\whuproposal_package_conflict:nn { unicode-math } { amscd }
\whuproposal_package_conflict:nn { unicode-math } { amsfonts }
\whuproposal_package_conflict:nn { unicode-math } { amssymb }
\whuproposal_package_conflict:nn { unicode-math } { bbm }
\whuproposal_package_conflict:nn { unicode-math } { bm }
\whuproposal_package_conflict:nn { unicode-math } { eucal }
\whuproposal_package_conflict:nn { unicode-math } { eufrak }
\whuproposal_package_conflict:nn { unicode-math } { mathrsfs }
\whuproposal_package_conflict:nn { unicode-math } { newtxmath }
\whuproposal_package_conflict:nn { unicode-math } { upgreek }

\whuproposal_package_conflict:nn { enumitem } { paralist }


% 纸张和页面布局
\bool_if:NTF \g__whuproposal_bachelor_type_bool
  {
    \geometry 
      {
        hmargin = 3 cm , top = 2.5 cm , bottom = 2 cm , ignoreall 
      }
  }
  {
    \geometry
      {
        % showframe,
        paper     = a4paper,
        papersize = { 210mm , 297mm } ,
        top = 2.54cm,
        % bottom = 2.54cm,
        % left = 3.18cm,
        left = 3.28cm,  % 为了要对齐字，往右移动了一点
        right = 3.18cm,
        footskip = 0.96cm,  % 2.54-1.75 = 0.79，但是还是不重合，所以要微调
        headsep  = 1.04cm,  % 2.54-1.5
        % 因为框的底部往上提了一点，所以版心的底部也要往上提一点
        bottom = 2.7cm,   % 本来是 2.54 cm
      }
  }




% 章节标题格式设置
\bool_if:NTF \g__whuproposal_bachelor_type_bool
  {
    \ctexset
      {
        section =
          {
            number     = \chinese { section } ,
            format     = \zihao { 4 } \bfseries,
            name        = {,、},
            aftername   = {},
            beforeskip = 3.5ex plus 1ex minus .5ex,
            afterskip  = 1ex plus .2ex minus 1ex,
            tocline    = \chinese{#1}、#2
          } ,
        subsection =
          {
            format     = \zihao { 4 } \bfseries,
            beforeskip = 2ex plus 0.5ex minus .5ex,
            afterskip  = 2ex plus .2ex minus 1ex,
          } ,
        subsubsection =
          {
            format     = \zihao { 4 } \bfseries,
            beforeskip = 2ex plus 0.5ex minus .5ex,
            afterskip  = 2ex plus .2ex minus 1ex,
          } ,
      }
  }
  {
    \ctexset
      {
        section =
          {
            number     = \chinese { section } ,
            format     = \zihao { -4 } \bfseries,
            name        = {,、},
            aftername   = {},
            beforeskip = 2ex plus 1ex minus .5ex,
            afterskip  = 2ex plus .2ex minus 1ex,
            tocline    = \chinese{#1}、#2
          } ,
        subsection =
          {
            format     = \zihao { -4 } \bfseries,
            beforeskip = 2ex plus 0.5ex minus .5ex,
            afterskip = 1ex plus 0.5ex minus .5ex,
          } ,
        subsubsection =
          {
            format     = \zihao { -4 } \bfseries,
            beforeskip = 2ex plus 0.5ex minus .5ex,
            afterskip = 1ex plus 0.5ex minus .5ex,
          } ,
      }
  }



% 字体

\cs_new_protected:Npn \__whuproposal_setmainfont:nn #1#2
  { \__fontspec_main_setmainfont:nn {#2} {#1} }

% 西文字体
\__whuproposal_setmainfont:nn { Times~ New~ Roman } { }

% 中文字体
% 在 ctex 的字体配置的基础上进行一些修改
% 将苹方和微软雅黑分别替换为华文黑体和中易黑体
\str_if_eq:onTF { \g__ctex_fontset_tl } { mac }
  {
    \setCJKsansfont { Heiti~ SC~ Light } [ BoldFont = Heiti~ SC~ Medium ]
  }
  {
    \str_if_eq:onT { \g__ctex_fontset_tl } { windows }
      { \setCJKsansfont { SimHei } }
  }


% 如果有内容较高（如分式）使得行间距小于 0.5em，则将其增加至 0.5em。
\dim_set:Nn \lineskiplimit { .5em }
\skip_set:Nn \lineskip { .5em }



% 个人信息

\keys_define:nn { whu-proposal }
  {
    % 标题
    title .tl_set:N = \g__whuproposal_title_tl,
    % 培养单位
    department .tl_set:N = \g__whuproposal_department_tl,
    % 专业
    major .tl_set:N = \g__whuproposal_major_tl,
    % 研究方向
    research_area .tl_set:N = \g__whuproposal_research_area_tl,
    % 学号
    student_id .tl_set:N = \g__whuproposal_student_id_tl,
    % 姓名
    author .tl_set:N = \g__whuproposal_author_tl,
    % 导师姓名
    supervisor .tl_set:N = \g__whuproposal_supervisor_tl,
    % 导师职称
    supervisor_title .tl_set:N = \g__whuproposal_supervisor_title_tl,
    % 年
    year .int_set:N = \g__whuproposal_year_int,
    % 月
    month .int_set:N = \g__whuproposal_month_int,
    % 日
    day .int_set:N = \g__whuproposal_day_int,
  }
\keys_set:nn { whu-proposal }
  {
    title            = { 论文题目 } ,
    department       = { 数学与统计学院 } ,
    major            = { 基础数学 } ,
    research_area    = { 算子理论 } ,
    student_id       = { 2021202012345 } ,
    author           = { 作者姓名 } ,
    supervisor       = { 导师姓名 } ,
    supervisor_title = { 教授 } ,
    year  = { \int_use:N \c_sys_year_int },
    month = { \int_use:N \c_sys_month_int },
    day   = { \int_use:N \c_sys_day_int },
  }

% 封面
\cs_new:Npn \__whuproposal_cover_master_doctor:
  {
    \thispagestyle{empty}
      \begin{tikzpicture}[ remember~picture, overlay ]
        \__whuproposal_cover_master_doctor_logo:
        \__whuproposal_cover_master_doctor_type:
        \__whuproposal_cover_master_doctor_infomation:
        \__whuproposal_cover_master_doctor_time:
      \end{tikzpicture}
    % \end{titlepage}
  }

% logo
\cs_new:Npn \__whuproposal_cover_master_doctor_logo:
  {
    \node[anchor = north] ( logo ) at 
      (
        [ shift = { ( 0em , -0.11\textheight ) } ]
          current~page~text~area.north
      )
      {
        \includegraphics
          [ height = 4.5em]
          { figures / whu-logo.png } 
      };
  }
% 类型
\cs_new:Npn \__whuproposal_cover_master_doctor_type:
  {
    \node[anchor = north] ( type ) at 
      (
        [ shift = { ( -2pt , -0.235\textheight ) } ]
          current~page~text~area.north
      )
      {
        \zihao{-1} \bfseries \heiti 研究生学位论文开题报告登记表
      };
  }
% 时间
\cs_new:Npn \__whuproposal_cover_master_doctor_time:
  {
    \node [ anchor = south ] ( date ) at ( [shift = {(0em, 2.5em)}]current~page~text~area.south ) 
      {
        \zihao{3} \fangsong
        \int_use:N \g__whuproposal_year_int
        % \zhdigits { \int_use:N \g__whuproposal_year_int }
        \, 年 \,
        \int_use:N \g__whuproposal_month_int
        % \zhnumber { \int_use:N \g__whuproposal_month_int }
        \, 月
        \int_use:N \g__whuproposal_day_int
        % \zhnumber { \int_use:N \g__whuproposal_day_int }
        \, 日
      };
  }
% 个人信息

% 对用户输入空格引发的报错进行处理
\prg_generate_conditional_variant:Nnn \tl_if_blank:n { v } { T }

\cs_new:Npn \__whuproposal_cover_master_doctor_infomation_preset:
  {
    \clist_map_inline:nn
      {
        department,
        major,
        research_area ,
        student_id ,
        author ,
        supervisor ,
        supervisor_title
      }
      {
        \tl_if_blank:vT
          { g__whuproposal_ ##1 _tl  }
          {
            \tl_set:cn { g__whuproposal_ ##1 _tl } { \textcolor{red}{待填写} }
          }
      }
  
  }
\cs_new:Npn \__whuproposal_cover_master_doctor_infomation:
  {
    \node[] (information) at
        (
          [shift = {(0, -4.6em)}]
          current~page.center
        )
        {
          \begin{minipage} [ c ] { \textwidth }
            \centering \zihao{3} \fangsong
            \__whuproposal_cover_master_doctor_infomation_preset:
            \clist_set:Nn \l__whuproposal_tmpa_clist
              {
                培养单位：,
                专\qquad 业：,  % 加 \qquad 消除 underfull \hbox 的警告
                研究方向：,
                学\qquad 号：,
                姓\qquad 名：,
                导师姓名：,
                导师职称：
              }
            \clist_set:Nx \l__whuproposal_tmpb_clist
              {
                \g__whuproposal_department_tl ,
                \g__whuproposal_major_tl ,
                \g__whuproposal_research_area_tl ,
                \g__whuproposal_student_id_tl ,
                \g__whuproposal_author_tl ,
                \g__whuproposal_supervisor_tl ,
                \g__whuproposal_supervisor_title_tl
              }
            \__whuproposal_get_max_text_width:NN 
              \l__whuproposal_tmpa_dim \l__whuproposal_tmpa_clist
            % 获得个人信息的内容最大宽度
            \__whuproposal_get_max_text_width:NN 
              \l__whuproposal_tmpb_dim \l__whuproposal_tmpb_clist
            \bool_until_do:nn
              { \clist_if_empty_p:N \l__whuproposal_tmpa_clist }
              {
                \clist_pop:NN \l__whuproposal_tmpa_clist \l__whuproposal_tmpa_tl
                \clist_pop:NN \l__whuproposal_tmpb_clist \l__whuproposal_tmpb_tl
                \__whuproposal_cover_infomation_spread_box:nn
                  { \l__whuproposal_tmpa_dim }
                  { \l__whuproposal_tmpa_tl }
                % \hspace*{1em}
                \__whuproposal_cover_infomation_center_underline_box:Vn 
                  \l__whuproposal_tmpb_dim 
                  { \l__whuproposal_tmpb_tl }
                \skip_vertical:n { 1.5 ex }
              }
          \end{minipage}
        };
  }

\cs_new_protected:Npn \__whuproposal_cover_infomation_center_underline_box:nn #1#2
  {
    \mode_leave_vertical:
    \CJKunderline*
      [
        thickness = 1pt
      ]
      {
        \hbox_to_wd:nn { #1 + 2cm } 
          { 
            \hfil 
              #2
            \hfil
          }
      }
  }
\cs_generate_variant:Nn \__whuproposal_cover_infomation_center_underline_box:nn  { Vn }

\cs_new_protected:Npn \__whuproposal_cover_infomation_spread_box:nn #1#2
  {
    \mode_leave_vertical:
    \hbox_to_wd:nn {#1}
      { \tl_map_inline:nn {#2} { ##1 \hfil } \unskip }
  }
\cs_new:Npn \__whuproposal_get_text_width:Nn #1#2
  {
    \hbox_set:Nn \l__whuproposal_tmpa_box {#2}
    \dim_set:Nn #1 { \box_wd:N \l__whuproposal_tmpa_box }
  }
\cs_new:Npn \__whuproposal_get_max_text_width:NN #1#2
  {
    \group_begin:
      \clist_set_eq:NN \l__whuproposal_tmpa_clist #2
      \bool_until_do:nn { \clist_if_empty_p:N \l__whuproposal_tmpa_clist }
        {
          \clist_pop:NN \l__whuproposal_tmpa_clist \l__whuproposal_tmpa_tl
          \__whuproposal_get_text_width:NV \l__whuproposal_tmpa_dim \l__whuproposal_tmpa_tl
          \dim_gset:Nn #1 { \dim_max:nn {#1} { \l__whuproposal_tmpa_dim } }
        }
    \group_end:
  }
\cs_generate_variant:Nn \__whuproposal_get_text_width:Nn { NV }

% 计算标题所占的最大宽度
\dim_new:N \g__whuproposal_title_width_dim  % 标题的宽度：行宽 - “学位论文题目：”

\cs_new:Npn \__whuproposal_master_doctor_front_matter:
  {
    \__whuproposal_cover_master_doctor:
    \hbox_set:Nn \l__whuproposal_tmp_box { \zihao{-4}  学位论文题目：}
    \dim_gset:Nn \g__whuproposal_title_width_dim
      {
        \dim_eval:n { \textwidth - \box_wd:N \l__whuproposal_tmp_box }
      }
    \newpage
    \par \vspace*{-6.9pt} 
      {
        \noindent \zihao{-4} 
        学位论文题目：
        % \parbox[ \dim_use:N \g__whuproposal_title_width_dim ]{ \g__whuproposal_title_tl }
        \begin{minipage}[t]{ \dim_use:N \g__whuproposal_title_width_dim }
          \g__whuproposal_title_tl
        \end{minipage}
      } 

    \par \vspace*{2.9ex} \noindent {\zihao{-4} 开题报告内容摘要（可附页）：}
    \fontsize{12pt}{14.5bp} \selectfont
  }
\AtBeginDocument
  {
    \bool_if:NTF \g__whuproposal_bachelor_type_bool
      {
        \__whuproposal_bachelor_front_matter:
      }
      {
        \__whuproposal_master_doctor_front_matter:
      }
  }


\bool_if:NF \g__whuproposal_bachelor_type_bool
  {
    \int_set:Nn \c@page { 0 }  % 去掉封面的框

    \AddToHook { shipout / background }
      {
        \put (0cm,0cm)
          {
            \int_compare:nNnT { \c@page } > { 0 }  % 去掉封面的框
              {
                \int_compare:nNnTF { \c@page } = {1}
                  { \__whuproposal_box_first_page: }
                  {
                    \__whuproposal_lastpage_tmp_set:
                    \int_compare:nNnT { \c@page } < { \l__whuproposal_tmp_int - 1 }
                      { \__whuproposal_box_after_first_page: }
                  }
              }
          }
      }
  }

% 判断 lastpage 的版本
\IfPackageAtLeastTF{lastpage}{2023-01-01}
  {
    % TeXLive 2023
    \cs_new:Npn \__whuproposal_lastpage_tmp_set:
      {
        \bool_lazy_or:nnTF 
          { \cs_if_eq_p:NN \lastpage@lastpage \__whuproposal_relax: }
          { \str_if_eq_p:ee \lastpage@lastpage {??} }
          { \int_set:Nn \l__whuproposal_tmp_int { 0 } }
          { \int_set:Nn \l__whuproposal_tmp_int { \lastpage@lastpage } }
      }
  }
  {
    \IfPackageAtLeastTF{lastpage}{2021-01-01}
      {
        % TeXLive 2022
        \cs_new:Npn \__whuproposal_lastpage_tmp_set:
          {
            \bool_lazy_or:nnTF 
              { \cs_if_eq_p:NN \lastpage@lastpage \__whuproposal_relax: }
              { \str_if_eq_p:ee \lastpage@lastpage {??} }
              { \int_set:Nn \l__whuproposal_tmp_int { 0 } }
              { \int_set:Nn \l__whuproposal_tmp_int { \int_eval:n { \lastpage@lastpage + 2 } } }
          }
      }
      {
        % TeXLive 2021 及之前
        \cs_new:Npn \box_ht_plus_dp:N #1 { \box_ht:N #1 + \box_dp:N #1 }
        \cs_new:Npn \__whuproposal_lastpage_tmp_set:
          {
            \bool_lazy_or:nnTF 
              { \cs_if_eq_p:NN \thepage \__whuproposal_relax: }
              { \str_if_eq_p:ee \thepage {??} }
              { \int_set:Nn \l__whuproposal_tmp_int { 0 } }
              { \int_set:Nn \l__whuproposal_tmp_int { \int_eval:n { \lastpage@lastpage + 2 } } }
          }
      }
  }


\cs_new_nopar:Npn \__whuproposal_relax: { \relax }

\dim_new:N \g__whuproposal_box_width_extra_dim   % box 的额外宽度
\dim_new:N \g__whuproposal_box_height_extra_dim  % box 的下面的额外高度
\dim_new:N \g__whuproposal_box_seperate_line_vertical_dim  % 分割线距离上方线的最终距离
\dim_new:N \g__whuproposal_box_seperate_line_vertical_aux_dim  % 分割线距离上方线的距离
\dim_set:Nn \g__whuproposal_box_width_extra_dim { 12pt }
\dim_set:Nn \g__whuproposal_box_height_extra_dim { 6pt }
\dim_set:Nn \g__whuproposal_box_seperate_line_vertical_aux_dim { 6.9ex }

% 正文第一页的分割线距离处理
% 因为有可能出现论文题目比较长，需要换行的情况（极少，但是存在），如果把分割线的距离固定了略麻烦
% 但是好在一般不会超过两行，所以只有两种情况，处理起来比较方便
% 解决想法：
%   1、先判断是否多行
%   2、是的话就重新调距离，并且写入 aux 文件，编译第二次的时候读取


% 判断是否是多行
\cs_new:Npn \__whuproposal_if_title_multiline:
  {
    % 把内容存在盒子里
    \hbox_set:Nn \l__whuproposal_tmp_box
      {
        \parbox{\textwidth}{
          \noindent \zihao{-4} 学位论文题目：\g__whuproposal_title_tl
        }
      }
    % 测量总高度
    \dim_set:Nn \l__whuproposal_tmp_dim { \box_ht_plus_dp:N \l__whuproposal_tmp_box }
    % 判断是否是多行
    \dim_compare:nNnT 
      { \l__whuproposal_tmp_dim } > { \normalbaselineskip }
      { \bool_gset_true:N \g__whuproposal_if_title_multiline_bool }
    \bool_if:NT \g__whuproposal_if_title_multiline_bool
      {
        \dim_gset:Nn \g__whuproposal_box_seperate_line_vertical_aux_dim { 9.8ex }
      }
    \AtEndDocument
      {
        \iow_now:cx { @auxout }
          {
            \token_to_str:N \ExplSyntaxOn   % 要加一个token_to_str
            ^^J
            \dim_gset:Nn \exp_not:N \g__whuproposal_box_seperate_line_vertical_dim { \dim_use:N \g__whuproposal_box_seperate_line_vertical_aux_dim }
            ^^J
            \token_to_str:N \ExplSyntaxOff  % 要加一个token_to_str
          }
      }
  }

% 整体的移动
\dim_new:N \g__whuproposal_box_vertical_all_move_dim
\dim_set:Nn \g__whuproposal_box_vertical_all_move_dim {1pt}
\cs_new:Npn \__whuproposal_box_first_page:
  {
    % 判断是否是多行
    \__whuproposal_if_title_multiline:
    \begin{tikzpicture}[ remember~picture, overlay ]
      % 大边框
      \draw ([shift = {(-0.1cm-\g__whuproposal_box_width_extra_dim, \g__whuproposal_box_vertical_all_move_dim)}]current~page~text~area.north~west) 
        -- 
        ([shift = {(0.1cm+\g__whuproposal_box_width_extra_dim, \g__whuproposal_box_vertical_all_move_dim)}]current~page~text~area.north~east)
        --
        ([shift = {(0.1cm+\g__whuproposal_box_width_extra_dim, \g__whuproposal_box_vertical_all_move_dim-\g__whuproposal_box_height_extra_dim)}]current~page~text~area.south~east)
        --
        ([shift = {(-0.1cm-\g__whuproposal_box_width_extra_dim, \g__whuproposal_box_vertical_all_move_dim-\g__whuproposal_box_height_extra_dim)}]current~page~text~area.south~west) -- cycle
        ;
      % 分割线
      \draw ([shift = {(-0.1cm-\g__whuproposal_box_width_extra_dim, \g__whuproposal_box_vertical_all_move_dim-\g__whuproposal_box_seperate_line_vertical_dim)}]current~page~text~area.north~west) 
        -- 
        ([shift = {(0.1cm+\g__whuproposal_box_width_extra_dim, \g__whuproposal_box_vertical_all_move_dim-\g__whuproposal_box_seperate_line_vertical_dim)}]current~page~text~area.north~east);
    \end{tikzpicture}
  }

\cs_new:Npn \__whuproposal_box_after_first_page:
  {
    \begin{tikzpicture}[ remember~picture, overlay ]
      \draw ([shift = {(-\g__whuproposal_box_width_extra_dim, \g__whuproposal_box_height_extra_dim + 2pt)}]current~page~text~area.north~west) 
        -- 
        ([shift = {(\g__whuproposal_box_width_extra_dim, \g__whuproposal_box_height_extra_dim + 2pt)}]current~page~text~area.north~east)
        --
        ([shift = {(\g__whuproposal_box_width_extra_dim, -\g__whuproposal_box_height_extra_dim -4pt)}]current~page~text~area.south~east)
        --
        ([shift = {(-\g__whuproposal_box_width_extra_dim, -\g__whuproposal_box_height_extra_dim -4pt)}]current~page~text~area.south~west) -- cycle
        ;
    \end{tikzpicture}
  }


\cs_new_protected:Npn \__whuproposal_master_doctor_back_matter:
  {
    \newpage
    \begin{tikzpicture} [remember~picture, overlay]
      \node at (current~page.center) 
        {
          \includegraphics
            [ width = \Gm@layoutwidth, height = \Gm@layoutheight ]
              { figures / proposal_master_doctor-comment1.pdf }
        };
    \end{tikzpicture}

    \newpage 
    \begin{tikzpicture} [remember~picture, overlay]
      \node at (current~page.center) 
        {
          \includegraphics
            [ width = \Gm@layoutwidth, height = \Gm@layoutheight ]
              { figures / proposal_master_doctor-comment2.pdf }
        };
    \end{tikzpicture}
  }
\AtEndDocument
  {
    \bool_if:NTF \g__whuproposal_bachelor_type_bool
      {
        \__whuproposal_bachelor_back_matter:
      }
      {
        \__whuproposal_master_doctor_back_matter:
      }
  }

% 页眉和页脚

\tl_set:Nn \headrulewidth { 0pt }
\cs_set_eq:NN \@mkboth \use_none:n
\cs_set_eq:NN \sectionmark \use_none:n
\cs_set_eq:NN \subsectionmark \use_none:n

\pagestyle { fancy }
\fancypagestyle { plain }
  {
    \fancyhf { }
    \fancyfoot [ C ]
      {
        \__whuproposal_lastpage_tmp_set:
        \zihao {-5} \int_eval:n { \thepage }
      }
  }
\pagestyle { plain }


\AtEndPreamble
  {
    % 修改 \printbibliography
    \cs_if_exist:NT \printbibliography
      {
        \cs_set_eq:NN \__whuproposal_printbibliography_old \printbibliography
        \cs_new:Npn \__whuproposal_printbibliography:n #1 
          {
            \__whuproposal_printbibliography_old [ #1 ] 
          }
        \RenewDocumentCommand { \printbibliography } { O{} } 
          {
            \group_begin:
              \sloppy
              \__whuproposal_printbibliography:n { heading = bibintoc, #1 }
            \group_end:
          }
      }
  }

\cs_set_eq:NN \__whuproposal_old_tableofcontents \tableofcontents
\RenewDocumentCommand { \tableofcontents } { }
  {
    \group_begin:
      \ctexset
        {
          section / format = \zihao {-3} \centering \bfseries
        }
      \__whuproposal_old_tableofcontents
      \vspace*{2em}
    \group_end:
  }


% 处理本科生的开题报告：本科毕业论文（设计）任务书


\tl_const:Nn \c__whuproposal_bachelor_heading_tl
  { 武汉大学本科毕业论文（设计） \\ 开　题　报　告 }

% 本科、开题报告左右边距 3 cm，上边距 2.5 cm，下边距 2 cm
\skip_const:Nn \c__whuproposal_bachelor_baseline_skip { 23 pt }

% 行距 23 pt
\cs_new_protected:Npn \__whuproposal_bachelor_baseline_skip:
  {
    
    \skip_set_eq:NN \baselineskip \c__whuproposal_bachelor_baseline_skip
    \skip_zero:N    \parskip
  }


% 开头
\cs_new_protected:Npn \__whuproposal_bachelor_front_matter:
  {
    \pagestyle { plain }
    \begin { center }
      \zihao { -2 } \heiti \c__whuproposal_bachelor_heading_tl
    \end { center }

    \__whuproposal_bachelor_baseline_skip:
    \hbox_set:Nn \l__whuproposal_tmp_box { \zihao{-4}  毕业论文（设计）题目： }
    \dim_gset:Nn \g__whuproposal_title_width_dim
      {
        \dim_eval:n { \textwidth - \box_wd:N \l__whuproposal_tmp_box }
      }
    \noindent
    \begin { minipage } { \textwidth }
    \__whuproposal_bachelor_baseline_skip:
      % 毕业论文（设计）题目： \CJKunderline* { \hfill \g__whuproposal_title_tl \hfill } \\
      毕业论文（设计）题目： 
      \begin{minipage}[t]{\g__whuproposal_title_width_dim}
        \CJKunderline* { \hfill \g__whuproposal_title_tl \hfill }
      \end{minipage}\\[2ex]
      学院： \uline { \hfill \g__whuproposal_department_tl \hfill } \hfill \hfill
      学号： \uline { \hfill \g__whuproposal_student_id_tl \hfill } \hfill
      \hfill 姓名： \uline { \hfill \g__whuproposal_author_tl \hfill }
    \end { minipage }
    \par \skip_vertical:n { 10 pt }
    \raggedbottom
    \__whu_set_table_font:
  }
\cs_new_protected:Npn \__whu_set_table_font:
  {
    \clist_map_inline:nn { tabular , tabularx , longtable , xltabular }
      { \AtBeginEnvironment {##1} { \zihao { 5 } } }
  }

% 落款
\cs_new_protected:Npn \__whuproposal_bachelor_back_matter:
  {
    \skip_vertical:n { 2 \c__whuproposal_bachelor_baseline_skip }
    \needspace { 0.3 \textheight }
    指导老师意见：
    \vfill
    \hfill 指导老师（签名）： \hbox_to_wd:nn { 4 cm } {} \par
    \skip_vertical:N \c__whuproposal_bachelor_baseline_skip
    \hfill 年 \qquad 月 \qquad 日
  }


\AtEndPreamble
  {
    % gb7714-CCNU.cbx
    \DeclareCiteCommand{\parencite}%[\mkbibbrackets]
      {\mkbibleftborder\usebibmacro{cite:init}
        \usebibmacro{prenote}}
      {\usebibmacro{citeindex}
        \usebibmacro{cite:comp}}
      {}
      {\usebibmacro{cite:dump}\setunit{\addcomma\addspace}\printfield{postnote}\mkbibrightborder}

    \DeclareCiteCommand{\cite}[\mkbibsuperscript]%利用mkbibsuperbracket添加方括号
      {\mkbibleftborder\usebibmacro{cite:init}
      \usebibmacro{prenote}}
      {\usebibmacro{citeindex}
      \usebibmacro{cite:comp}}
      {}
      {\usebibmacro{cite:dump}\setunit{\addcomma\addspace}
      \printfield{postnote}\mkbibrightborder}
  }