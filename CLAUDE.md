# Awesome-CV

Personal resume. `master` branch, commits go straight to it. Upstream is `posquit0/Awesome-CV`;
`origin` is `gondyb/Awesome-CV`.

## Building

```sh
make resume        # or: make all   (resume + coverletter)
```

xelatex must run from inside `examples/`, which is what the Makefile does. `examples/awesome-cv.cls`
and `examples/fonts` are symlinks to the repo root, and `resume.tex` uses relative `\input` paths, so
running xelatex from the repo root fails to resolve `resume/experience.tex`.

xelatex writes `! Emergency stop` / `mktexmf FontAwesome` to stderr and exits nonzero on every run. It
is harmless: it fails to build a FontAwesome TFM, then falls back to the bundled
`fonts/FontAwesome.ttf` and the icons render correctly. The Makefile ignores the exit status and
verifies the PDF instead. Don't chase it.

Toolchain is the Homebrew `texlive` formula (`/opt/homebrew/bin/xelatex`), no sudo and no `tlmgr`
needed. The class wants `fontawesome` v4, not `fontawesome5`.

## Structure

`examples/resume.tex` inputs `resume/{summary,experience,education,skills}.tex`. One page — keep it
that way. `examples/coverletter.tex` is the unmodified upstream template, kept for job applications.

Two things in `resume.tex` override the class and should not be reverted:

- `\setbool{acvSectionColorHighlight}{false}` stops the first letter of each section heading rendering
  in the accent colour.
- `\entrypositionstyle` / `\headerpositionstyle` are redefined to use `\MakeUppercase` instead of the
  class's `\scshape`. Real small caps look better but the fonts map their small-cap `I` to a lowercase
  `i` in the PDF text layer, so job titles extracted as `SENiOR SOFTWARE ENGiNEER` and ATS keyword
  search missed them. Verify with `pdftotext examples/resume.pdf - | grep -i "senior software"`.

## Facts on the resume

Sourced from `~/lab/brag-sheet/benjamin.gondange@datadoghq.com/`. Check a number there before adding
it. Known traps, none of which are his results:

- Observability Revamp MTTR / alert-volume figures are a baseline and a target, NOT achieved.
- The ServiceNow "tens of millions ARR" is a third party's estimate inside a design doc.
- The `litellm` 4-minute triage was another team's agent.
- Agent **quality** (evals, accuracy) is owned by a partner team. He owns the platform agents run on:
  identity, permissions, invocation, attribution, retry safety. Don't let the resume imply otherwise.
- He was **one of three** engineers who built Case Management, as a new grad. Not the sole creator.
- He is tech lead, not a people manager.
