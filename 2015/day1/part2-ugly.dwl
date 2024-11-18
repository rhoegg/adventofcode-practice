%dw 2.0
import firstWith from dw::core::Arrays
output application/json
var instructions = payload splitBy ""
var counts = instructions groupBy $ mapObject (v, k) ->
{ (k): sizeOf(v) }
var progress = (instructions map (v, i) -> {
    position: i + 1,
    value: v
}) reduce (s, a = []) -> a << (s ++ {floor: ((a[-1].floor default 0) + (s.value match {
    case "(" -> 1
    case ")" -> -1
    }))})
---
progress firstWith $.floor < 0
