%dw 2.0
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

fun ribbon(gift: Gift): Number = do {
    var perimeters = [
        2 * gift.l + 2 * gift.w,
        2 * gift.w + 2 * gift.h,
        2 * gift.l + 2 * gift.h
        ]
    var volume = gift.l * gift.w * gift.h
    ---
    (min(perimeters) default 0) + volume
}
var gifts = lines(payload) map gift($)
---
sum(gifts map ribbon($))
