%dw 2.0

fun containsThreeVowels(s: String): Boolean = do {
    var vowels = s filter (c) -> c matches /[aeiou]/
    ---
    sizeOf(vowels) >= 3
}

fun containsDoubleLetter(s: String): Boolean =
    if (sizeOf(s) < 2) false
    else if (s[0] == s[1]) true
    else containsDoubleLetter(s[1 to -1])

fun containsForbiddenText(s: String): Boolean =
    s matches /.*(ab|cd|pq|xy).*/
    
fun nice(s: String): Boolean = 
    containsThreeVowels(s) and containsDoubleLetter(s) and ! containsForbiddenText(s)

fun containsRepeatedPair(s: String): Boolean = do {
    if (sizeOf(s) < 2) false
    else do {
        var pair = s[0 to 1]
        var firstPairRepeats = s[2 to -1] contains pair
        ---
        if (firstPairRepeats) true
        else containsRepeatedPair(s[1 to -1])
    }
}

fun containsLetterSandwich(s: String): Boolean =
    if (sizeOf(s) < 3) false
    else if (s[0] == s[2]) true
    else containsLetterSandwich(s[1 to -1])

fun nicer(s: String): Boolean =
    containsRepeatedPair(s) and containsLetterSandwich(s)