9%dw 2.0
import lines from dw::core::Strings
output application/json

type Gift = {
    l: Number,
    w: Number,
    h: Number
}

fun gift(line): Gift = do {
    var dims = (line splitBy "x") map (s) -> s as Number
    ---
    {l: dims[0], w: dims[1], h: dims[2]}
}

fun paper(g: Gift): Number = do {
    var faces = [g.l * g.w, g.w * g.h, g.h * g.l]
    ---
    sum(faces map (2 * $)) + (min(faces) default 0)
}
var gifts = lines(payload) map gift($)
---
sum(gifts map paper($))
