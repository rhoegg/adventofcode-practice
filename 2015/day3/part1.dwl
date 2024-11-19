%dw 2.0

output application/json
type Point = {
    x: Number,
    y: Number,
}
type Direction = "^"| "v" | "<" | ">"
fun write(p: Point): String = "$(p.x),$(p.y)"
fun go(p: Point, d: Direction): Point =
    d match {
        case "^" -> p update { case y at .y -> y + 1}
        case "v" -> p update { case y at .y -> y - 1}
        case "<" -> p update { case x at .x -> x - 1}
        case ">" -> p update { case x at .x -> x + 1}
    }
var origin: Point = {x: 0, y: 0}
var moves = payload splitBy ""
var santaPath = moves reduce (move, path = [origin]) -> path << go(path[-1], move)
var presents = santaPath groupBy write($) mapObject (items, k) -> {(k): sizeOf(items)}
---
sizeOf(presents)
