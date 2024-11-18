%dw 2.0
output application/json
var counts = payload splitBy "" groupBy $ mapObject (v, k) ->
{ (k): sizeOf(v) }
---
counts['('] - counts[')']
