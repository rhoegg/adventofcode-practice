%dw 2.0
output application/json

import take from dw::core::Arrays
import duration from dw::util::Timer
import * from Geometry
import * from MySolution

---
// 60 steps took me 113.361s, we should take a reverse approach. Start with the last step,
// and mask the step before... turn off/turn on will mask all previous steps, making things additive
duration(() -> instructions take 60 reduce (instruction, last = []) -> do {
    var splitRects = applyMask(instruction.rectangle as Rectangle, last)
    var target = instruction.action match {
        case "turn on" -> (splitRects.mask reduce (r, t = splitRects.target) -> t - r) ++ splitRects.mask
        case "turn off" -> splitRects.mask reduce (r, t = splitRects.target) -> t - r
        case "toggle" -> splitRects.mask reduce (r, t = splitRects.target) -> 
            if (t contains r) t - r
            else t << r
    }
    ---
    mergeRects(target)
})


