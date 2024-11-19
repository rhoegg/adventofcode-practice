%dw 2.0
import duration from dw::util::Timer
import findBlock from MySolution
output application/json
---
// 45.474 seconds for my puzzle input on Macbook M3
duration(() -> findBlock("000000", "pqrstuv"))