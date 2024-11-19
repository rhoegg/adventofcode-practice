%dw 2.0
import * from dw::test::Tests
import * from dw::test::Asserts

import * from MySolution

fun beTrue() = equalTo(true)
fun beFalse() = equalTo(false)

---
"MySolution" describedBy [
    "nice" describedBy [
        "Sample input 1 should be nice" in do {
            nice("ugknbfddgicrmopn") must beTrue()
        },
        "Sample input 2 should be nice" in do {
            nice("aaa") must beTrue()
        },
        "Sample input 3 should be naughty" in do {
            nice("jchzalrnumimnmhp") must beFalse()
        },
        "Sample input 4 should be naughty" in do {
            nice("haegwjzuvuyypxyu") must beFalse()
        },
        "Sample input 5 should be naughty" in do {
            nice("dvszwmarrgswjxmb") must beFalse()
        }
    ],
    "nicer" describedBy [
        "Sample 1 input should be nicer" in do {
            nicer("qjhvhtzxzqqjkmpb") must beTrue()
        },
        "Sample 2 input should be nicer" in do {
            nicer("xxyxx") must beTrue()
        },
        "Sample 3 input should be naughty" in do {
            nicer("uurcxstgmygtbstg") must beFalse()
        },
        "Sample 4 input should be naughty" in do {
            nicer("ieodomkazucvgmuy") must beFalse()
        }
    ],
]
