%dw 2.0
output application/json
import countBy from dw::core::Arrays
import lines from dw::core::Strings
import * from MySolution
var puzzles = lines(readUrl("classpath://puzzle-input.txt", "text/plain"))
---
puzzles countBy (s) -> nice(s)
