import every, some from dw::core::Arrays

type Point = {
    x: Number,
    y: Number
}

type Rectangle = {
    p1: Point,
    p2: Point
}

fun manhattanDistance(p1: Point, p2: Point) = 
    abs(p1.x - p2.x) + abs(p1.y - p2.y)

fun corners(r: Rectangle): Array<Point> =
    [r.p1, {x: r.p1.x, y: r.p2.y}, r.p2, {x: r.p2.x, y: r.p1.y}]

fun intersects(p: Point, r1: Rectangle): Boolean = 
    p.x >= r1.p1.x and p.x <= r1.p2.x and p.y >= r1.p1.y and p.y <= r1.p2.y

fun intersects(r1: Rectangle, r2: Rectangle): Boolean = 
    (corners(r1) some (p) -> p intersects r2) or
    (corners(r2) some (p) -> p intersects r1)

fun surrounds(r1: Rectangle, r2: Rectangle): Boolean =
    corners(r2) every (p) -> p intersects r1

fun height(r: Rectangle): Number = r.p2.y - r.p1.y
fun width(r: Rectangle): Number = r.p2.x - r.p1.x
fun adjacent(r1: Rectangle, r2: Rectangle): Boolean =
    if (r1.p1.y == r2.p1.y)
        (r1.p2.y == r2.p2.y) and (
            r2.p1.x - 1 == r1.p2.x or r1.p1.x - 1 == r2.p2.x
        )
    else if (r1.p1.x == r2.p1.x)
        (r1.p2.x == r2.p2.x) and (
            r2.p1.y - 1 == r1.p2.y or r1.p1.y - 1 == r2.p2.y
        )
    else false
    