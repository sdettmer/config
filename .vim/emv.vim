" emv formatting of BMP55 (tries)

" we want "write" bmp55 only
" we assume our messages always have a MAC
"   and kill text from "^read" to "^\s\+64"
" (visual read)
map ,vr :set nowrapscan<CR>/^read<CR>v/^\s\+\(CRC\\|64\)<CR>
" (kill read) --- must be repeated
map ,kr :set nowrapscan<CR>/^read<CR>v/^\s\+\(CRC\\|64\)<CR>d


" map ,q qq:set nowrapscan<CR>/^read<CR>v/^\s\+\(CRC\\|64\)<CR>dq
" kill all except bmp 55
map ,k5 :%!grep -e "^[[:space:]]\+55"
" hex only
map ,ho :%s/^\(.*\)\s\(\S\+\)\s*$/\2
" join all lines, kill blanks
map ,ja :%j<CR>:%s/\s\+//g<CR>
" parse tlv
map ,pt :%!/cygdrive/x/users/giorgio/tools/parsetlv/parse-tlv --atos-emv

