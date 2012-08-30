" Vim syntax file

" Setup
if version >= 600
  if exists("b:current_syntax")
    finish
  endif
else
  syntax clear
endif


syntax match log_io     "> .*"

syntax match log_error    "^! \d\d[:.]\d\d[:.]\d\d.*"
syntax match log_warn     "^? \d\d[:.]\d\d[:.]\d\d.*"
syntax match log_progress "^% \d\d[:.]\d\d[:.]\d\d.*"
syntax match log_info     "^  \d\d[:.]\d\d[:.]\d\d.*"
syntax match log_config  "^\. \d\d[:.]\d\d[:.]\d\d.*"
syntax match log_fine     "^1 \d\d[:.]\d\d[:.]\d\d.*"
syntax match log_finer    "^2 \d\d[:.]\d\d[:.]\d\d.*"
syntax match log_finest   "^3 \d\d[:.]\d\d[:.]\d\d.*"

" for bta.log
syntax match log_error    "^! \d\d\d\d-\d\d-\d\d \d\d[:.]\d\d[:.]\d\d .*"
syntax match log_warn     "^? \d\d\d\d-\d\d-\d\d \d\d[:.]\d\d[:.]\d\d .*"
syntax match log_progress "^% \d\d\d\d-\d\d-\d\d \d\d[:.]\d\d[:.]\d\d .*"
syntax match log_info     "^  \d\d\d\d-\d\d-\d\d \d\d[:.]\d\d[:.]\d\d .*"
syntax match log_config   "^\. \d\d\d\d-\d\d-\d\d \d\d[:.]\d\d[:.]\d\d .*"
syntax match log_fine     "^1 \d\d\d\d-\d\d-\d\d \d\d[:.]\d\d[:.]\d\d .*"
syntax match log_finer    "^2 \d\d\d\d-\d\d-\d\d \d\d[:.]\d\d[:.]\d\d .*"
syntax match log_finest   "^3 \d\d\d\d-\d\d-\d\d \d\d[:.]\d\d[:.]\d\d .*"

syntax match log_error    "^\d\d\d\d-\d\d-\d\d \d\d[:.]\d\d[:.]\d\d ! .*"
syntax match log_warn     "^\d\d\d\d-\d\d-\d\d \d\d[:.]\d\d[:.]\d\d ? .*"
syntax match log_progress "^\d\d\d\d-\d\d-\d\d \d\d[:.]\d\d[:.]\d\d % .*"
syntax match log_info     "^\d\d\d\d-\d\d-\d\d \d\d[:.]\d\d[:.]\d\d   .*"
syntax match log_config   "^\d\d\d\d-\d\d-\d\d \d\d[:.]\d\d[:.]\d\d \. .*"
syntax match log_fine     "^\d\d\d\d-\d\d-\d\d \d\d[:.]\d\d[:.]\d\d 1 .*"
syntax match log_finer    "^\d\d\d\d-\d\d-\d\d \d\d[:.]\d\d[:.]\d\d 2 .*"
syntax match log_finest   "^\d\d\d\d-\d\d-\d\d \d\d[:.]\d\d[:.]\d\d 3 .*"

highlight log_error         ctermfg=DarkRed
highlight log_warn          ctermfg=Brown
highlight log_progress      ctermfg=Yellow
highlight log_info          ctermfg=White
highlight log_config        ctermfg=DarkGreen
highlight log_fine          ctermfg=Gray
highlight log_finer         ctermfg=Blue
highlight log_finest        ctermfg=DarkBlue

highlight log_io            ctermfg=DarkGray

let b:current_syntax = "mszlog"
