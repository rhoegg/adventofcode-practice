%dw 2.0
import findBlock from MySolution

output application/json

var secretKey = "pqrstuv"
---
findBlock("00000", secretKey)
