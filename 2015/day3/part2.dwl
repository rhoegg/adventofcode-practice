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
fun generatePath(moves: Array<Direction>): Array<Point> =
    moves reduce (move, path = [origin]) -> path << go(path[-1], move)

var origin: Point = {x: 0, y: 0}
var moves: Array<Direction> = (payload splitBy "") as Array<Direction>
var santaMoves = moves filter (m, i) -> (i mod 2) == 0
var roboSantaMoves = moves filter (m, i) -> (i mod 2) == 1
var santaPath = generatePath(santaMoves)
var roboSantaPath = generatePath(roboSantaMoves)
var presents = (santaPath ++ roboSantaPath) groupBy write($) mapObject (items, k) -> {(k): sizeOf(items)}
---
sizeOf(presents)
