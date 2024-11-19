%dw 2.0
import countBy from dw::core::Arrays
import lines from dw::core::Strings
import * from MySolution
var puzzles = lines(readUrl("classpath://puzzle-input.txt", "text/plain"))
---
puzzles countBy (s) -> nicer(s)
