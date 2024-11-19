%dw 2.0
import MD5 from dw::Crypto

fun findBlock(prefix: String, key: String, start: Number = 0) = do {
    var candidate = start + 1
    var hash = MD5(key ++ candidate as String)
    ---
    if (hash startsWith prefix) candidate
    else findBlock(prefix, key, candidate)
}
