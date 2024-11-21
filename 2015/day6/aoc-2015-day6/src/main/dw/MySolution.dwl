%dw 2.0
import * from Geometry
import * from dw::core::Arrays
import lines, words from dw::core::Strings


fun parsePoint(s: String) = do {
    var parts = s splitBy ","
    ---
    {
        x: parts[0] as Number,
        y: parts[1] as Number
    }
}

fun splitAround(outer: Rectangle, inner: Rectangle): Array<Rectangle> = do {
    var left: Array<Rectangle> = if (outer.p1.x < inner.p1.x) 
        [{p1: outer.p1, p2: {x: inner.p1.x - 1, y: outer.p2.y}}] else []
    var right: Array<Rectangle> = if (outer.p2.x > inner.p2.x) 
        [{p1: {x: inner.p2.x + 1, y: outer.p1.y}, p2: outer.p2}] else []
    var top: Array<Rectangle> = if (outer.p1.y < inner.p1.y)
        [{p1: {x: inner.p1.x, y: outer.p1.y}, p2: {x: inner.p2.x, y: inner.p1.y - 1}}] else []
    var bottom: Array<Rectangle> = if (outer.p2.y > inner.p2.y)
        [{p1: {x: inner.p1.x, y: inner.p2.y + 1}, p2: {x: inner.p2.x, y: outer.p2.y}}] else []
    ---
    left ++ right ++ top ++ bottom << inner
}

fun splitOne(mask: Rectangle, target: Rectangle): Array<Rectangle> = do {
    // break one non-intersecting rectangle off of the target, and return this plus the remainder
    if (target.p1.x < mask.p1.x) [ // split left
        {p1: target.p1, p2: {x: mask.p1.x - 1, y: target.p2.y}},
        {p1: {x: mask.p1.x, y: target.p1.y}, p2: target.p2} 
    ] else if (target.p2.x > mask.p2.x) [ // split right
        {p1: target.p1, p2: {x: mask.p2.x, y: target.p2.y}},
        {p1: {x: mask.p2.x + 1, y: target.p1.y}, p2: target.p2}
    ] else if (target.p1.y < mask.p1.y) [ // split top
        {p1: target.p1, p2: {x: target.p2.x, y: mask.p1.y - 1}},
        {p1: {x: target.p1.x, y: mask.p1.y}, p2: target.p2}
    ] else [ // split bottom
        {p1: target.p1, p2: {x: target.p2.x, y: mask.p2.y}},
        {p1: {x: target.p1.x, y: mask.p2.y + 1}, p2: target.p2}
    ]
}

fun applyMask(mask: Rectangle, target: Array<Rectangle>) =
    applyMask([mask], target)
fun applyMask(mask: Array<Rectangle>, target: Array<Rectangle>): { mask: Array<Rectangle>, target: Array<Rectangle> } = 
    if (isEmpty(mask) or isEmpty(target)) { mask: mask, target: target }
    else do {
        type Pair = {mask: Rectangle, target: Rectangle}
        var pairings: Array<Pair> = mask flatMap (m) -> target map (t) -> {mask: m, target: t}
        var intersections = pairings filter (pair) -> pair.mask intersects pair.target
        var overlap = intersections firstWith (pair) -> (pair.mask != pair.target)
        ---
        if (overlap == null)
            // all the intersecting rectangles are equal
            {mask: mask, target: target}
        else do { // split and recurse
            var needsSplit = overlap as Pair
            var nextMask = if (needsSplit.mask surrounds needsSplit.target)
                (needsSplit.mask splitAround needsSplit.target) 
                else [needsSplit.mask]
            var nextTarget = if (needsSplit.mask surrounds needsSplit.target)
                [needsSplit.target]
                else (needsSplit.mask splitOne needsSplit.target)
            ---
            // tail recurse
            applyMask(
                mask - needsSplit.mask ++ nextMask, 
                target - needsSplit.target ++ nextTarget)
        }
    }


fun firstNeighbor(r: Rectangle, others: Array<Rectangle>): Rectangle | Null =
    others firstWith (o) -> r adjacent o
    
fun merge(r1: Rectangle, r2: Rectangle): Rectangle =
    {
        p1: {
            x: min([r1.p1.x, r2.p1.x]) default 0,
            y: min([r1.p1.y, r2.p1.y]) default 0
        },
        p2: {
            x: max([r1.p2.x, r2.p2.x]) default 0,
            y: max([r1.p2.y, r2.p2.y]) default 0
        }
    }

fun mergeRects(rects: Array<Rectangle>): Array<Rectangle> = do {
    fun merger(rects: Array<Rectangle>, merged: Array<Rectangle> = []): Array<Rectangle> =
        if (sizeOf(rects) < 2) rects ++ merged
        else do {
            var first = rects[0]
            var remaining = rects drop 1
            var adjacent = firstNeighbor(first, remaining)
            var nextIteration = if (adjacent == null) remaining 
                else remaining - adjacent ++ merged << log("merged",merge(log("first:", first), log("adj:", adjacent)))
            var nextMerged = if (adjacent == null) merged << first
                else []
            ---
            merger(nextIteration, nextMerged)
        }
    ---
    merger(rects)
}

var instructions = do {
    var textLines = lines(readUrl("classpath://puzzle-input.txt", "text/plain"))
    ---
    textLines map (line) -> do {
        var tokens = words(line)
        var action = if (tokens[0] == "toggle") "toggle"
            else if (tokens[1] == "on") "turn on"
            else "turn off"
        // points always the same distance from the end of the string
        var p1 = parsePoint(tokens[-3])
        var p2 = parsePoint(tokens[-1])
        ---
        {
            action: action,
            rectangle: {p1: p1, p2: p2}
        }
    }
}