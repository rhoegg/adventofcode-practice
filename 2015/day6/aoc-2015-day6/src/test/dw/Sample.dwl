%dw 2.0
import duration from dw::util::Timer
import * from Geometry
import * from MySolution
output application/json
var after40 = readUrl("classpath://sample-rectangles.json")
var mergedTimer = duration(() -> mergeRects(after40))
var r1 = {
  p1: {
    x: 756,
    y: 959
  },
  p2: {
    x: 759,
    y: 965
  }
}
var r2 = {
  p1: {
    x: 760,
    y: 965
  },
  p2: {
    x: 789,
    y: 965
  }
}
---
{
    time: mergedTimer.time,
    size: sizeOf(mergedTimer.result),
    result: mergedTimer.result
        // instructions: instructions map (i) -> 
        //     i.rectangle.p1.x < i.rectangle.p2.x and i.rectangle.p1.y < i.rectangle.p2.y,
}