# Simple Workflow Diagrams (TikZ)

TikZ flowcharts of the two niBuild validation workflows, intended for paper figures
**6A** and **7A**. Node and edge structure is transcribed directly from the exported
CWL (`flanker_analysis.cwl`, `vbm_alzheimer.cwl`).

- **Figure 6A — Flanker task (full fMRI analysis):** 14 FSL steps from a BIDS dataset
  through preprocessing, first-level GLM (`film_gls`), and group-level statistics
  (`FLAMEO`).
- **Figure 7A — VBM Alzheimer's (structural pipeline):** 10 FSL steps from
  T1-weighted images through reorientation, brain extraction, tissue segmentation,
  registration, Jacobian modulation, spatial smoothing, and group-level permutation
  testing (`fslmerge` + `randomise`).

## Rendering

1. Create a new Overleaf project and paste the LaTeX below into `main.tex`.
2. Compile with **pdfLaTeX**. The `standalone` class emits a **2-page** cropped PDF —
   page 1 = Figure 6A (flanker), page 2 = Figure 7A (VBM).
3. Export to SVG for Figma post-production, e.g. `pdf2svg main.pdf fig-%d.svg`
   (one SVG per page), open the PDF in Inkscape and *Save As → SVG*, or compile with
   `dvisvgm` instead of pdfLaTeX.
4. To keep each panel in its own project, copy the preamble (everything from
   `\documentclass` down to `\begin{document}`) plus a single `tikzpicture`.

Notes:
- The diagrams are monochrome and unlabelled by design — add colour, panel letters,
  and final typography in Figma.
- Tool names follow FSL/CWL casing (`film_gls`, `applywarp`, `slicetimer`, `fslmaths`,
  `fslmerge` lowercase; `BET`, `FAST`, `FLIRT`, `FNIRT`, `SUSAN`, `MCFLIRT`, `FLAMEO`
  acronyms uppercase).
- Reference inputs (MNI152 templates, FNIRT config, GLM design/contrast files) are
  intentionally omitted; only the primary data source, processing chain, and final
  output are drawn.

## LaTeX source

```latex
% niBuild validation workflows -- TikZ flowcharts for figures 6A and 7A.
% Compile with pdfLaTeX (standalone -> one cropped page per tikzpicture).
\documentclass[tikz,border=12pt]{standalone}
\usetikzlibrary{arrows.meta, shapes.geometric}

\tikzset{
  % processing step (FSL tool)
  tool/.style = {
    draw, thick, fill=white, rounded corners=2.5pt,
    minimum width=22mm, minimum height=13mm,
    align=center, font=\sffamily, inner sep=4pt
  },
  % data source / workflow output (parallelogram = I/O glyph)
  io/.style = {
    draw, thick, fill=white,
    trapezium, trapezium left angle=70, trapezium right angle=110,
    trapezium stretches body,
    minimum width=22mm, minimum height=12mm,
    align=center, font=\sffamily, inner sep=4pt
  },
  % data-flow edge
  flow/.style = {-{Stealth[length=2.6mm, width=2.2mm]}, thick},
  % edge label
  elab/.style = {font=\sffamily\footnotesize, fill=white, inner sep=1.5pt}
}

\begin{document}

% =====================================================================
%  FIGURE 6A -- Flanker task: full fMRI analysis workflow
% =====================================================================
\begin{tikzpicture}

  % -- data source --
  \node[io]   (bids)   at (0,0)        {BIDS\\{\footnotesize ds000102}};

  % -- structural lane (top) --
  \node[tool] (bet)    at (3.2,2.5)    {BET};
  \node[tool] (flirt1) at (6.4,2.5)    {FLIRT\\{\footnotesize struct\,$\to$\,MNI}};
  \node[tool] (fnirt)  at (9.6,2.5)    {FNIRT};

  % -- bridge (functional-to-structural registration) --
  \node[tool] (flirt2) at (6.4,0)      {FLIRT\\{\footnotesize func\,$\to$\,struct}};

  % -- functional lane (bottom) --
  \node[tool] (mcf)    at (3.2,-2.5)   {MCFLIRT};
  \node[tool] (slt)    at (6.4,-2.5)   {slicetimer};
  \node[tool] (susan)  at (9.6,-2.5)   {SUSAN};
  \node[tool] (fm1)    at (12.8,-1.25) {fslmaths\\{\footnotesize temporal mean}};
  \node[tool] (fm2)    at (12.8,-3.25) {fslmaths\\{\footnotesize high-pass}};

  % -- convergence and statistics --
  \node[tool] (warp)   at (16,0)       {applywarp};
  \node[tool] (film)   at (19.2,0)     {film\_gls};
  \node[tool] (mrg1)   at (22.4,1.2)   {fslmerge\\{\footnotesize COPEs}};
  \node[tool] (mrg2)   at (22.4,-1.2)  {fslmerge\\{\footnotesize VARCOPEs}};
  \node[tool] (flam)   at (25.6,0)     {FLAMEO};
  \node[io]   (out)    at (28.8,0)     {Output\\{\footnotesize group activation}};

  % -- edges --
  \draw[flow] (bids) -- node[elab]{t1w}  (bet);
  \draw[flow] (bids) -- node[elab]{bold} (mcf);

  \draw[flow] (bet)    -- (flirt1);
  \draw[flow] (flirt1) -- (fnirt);
  \draw[flow] (bet)    to[out=44,in=136] (fnirt);
  \draw[flow] (bet)    -- (flirt2);

  \draw[flow] (mcf)    -- (slt);
  \draw[flow] (slt)    -- (susan);
  \draw[flow] (mcf)    -- (flirt2);

  \draw[flow] (susan)  -- (fm1);
  \draw[flow] (susan)  -- (fm2);
  \draw[flow] (fm1)    -- (fm2);

  \draw[flow] (fm2)    -- (warp);
  \draw[flow] (fnirt)  -- (warp);
  \draw[flow] (flirt2) -- (warp);

  \draw[flow] (warp)   -- (film);
  \draw[flow] (film)   -- (mrg1);
  \draw[flow] (film)   -- (mrg2);
  \draw[flow] (mrg1)   -- (flam);
  \draw[flow] (mrg2)   -- (flam);
  \draw[flow] (flam)   -- (out);

\end{tikzpicture}

% =====================================================================
%  FIGURE 7A -- VBM Alzheimer's: structural analysis workflow
% =====================================================================
\begin{tikzpicture}

  % -- main spine --
  \node[io]   (t1w)      at (0,0)      {Input\\{\footnotesize T1w images}};
  \node[tool] (reorient) at (3.2,0)    {fslreorient2std};
  \node[tool] (bet)      at (6.4,0)    {BET};
  \node[tool] (flirt)    at (9.6,0)    {FLIRT};
  \node[tool] (fnirt)    at (12.8,0)   {FNIRT};
  \node[tool] (warp)     at (16,0)     {applywarp};
  \node[tool] (fm1)      at (19.2,0)   {fslmaths\\{\footnotesize modulation}};
  \node[tool] (fm2)      at (22.4,0)   {fslmaths\\{\footnotesize smoothing}};
  \node[tool] (merge)    at (25.6,0)   {fslmerge};
  \node[tool] (rand)     at (28.8,0)   {randomise};
  \node[io]   (out)      at (32,0)     {Output\\{\footnotesize group statistics}};

  % -- tissue segmentation branch --
  \node[tool] (fast)     at (11.2,2.6) {FAST};

  % -- edges: spine --
  \draw[flow] (t1w)      -- (reorient);
  \draw[flow] (reorient) -- (bet);
  \draw[flow] (bet)      -- (flirt);
  \draw[flow] (flirt)    -- (fnirt);
  \draw[flow] (fnirt)    -- (warp);
  \draw[flow] (warp)     -- (fm1);
  \draw[flow] (fm1)      -- (fm2);
  \draw[flow] (fm2)      -- (merge);
  \draw[flow] (merge)    -- (rand);
  \draw[flow] (rand)     -- (out);

  % -- edges: segmentation branch --
  \draw[flow] (bet)  -- (fast);
  \draw[flow] (fast) -- (warp);

  % -- edges: skip connections (arc below the spine) --
  \draw[flow] (bet)   to[out=-44,in=-136] (fnirt);
  \draw[flow] (fnirt) to[out=-44,in=-136] (fm1);

\end{tikzpicture}

\end{document}
```
