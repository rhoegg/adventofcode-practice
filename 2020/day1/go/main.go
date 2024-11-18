package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

func findtwo(target int, expenses []int) (int, int) {
	if len(expenses) < 2 {
		panic(fmt.Sprintf("no expenses sum to %d", target))
	}
	expense1 := expenses[0]
	for _, expense2 := range expenses[1:] {
		if expense1+expense2 == 2020 {
			return expense1, expense2
		}
	}
	return findtwo(target, expenses[1:])
}

func findthree(target int, expenses []int) (int, int, int) {
	for i1 := range expenses {
		for i2 := range expenses[i1+1:] {
			i2 = i2 + i1 + 1
			for i3 := range expenses[i2+1:] {
				i3 = i3 + i2 + 1
				fmt.Printf("Trying %d %d %d\n", expenses[i1], expenses[i2], expenses[i3])
				if expenses[i1]+expenses[i2]+expenses[i3] == target {
					return expenses[i1], expenses[i2], expenses[i3]
				}
			}
		}
	}
	panic(fmt.Sprintf("no three expenses sum to %d", target))
}

// written 2023-12-02
func main() {
	inputdata, err := os.ReadFile("input.txt")
	if err != nil {
		panic(err)
	}
	var expenses []int
	for _, line := range strings.Split(string(inputdata), "\n") {
		i, err := strconv.Atoi(line)
		if err != nil {
			panic(err)
		}
		expenses = append(expenses, i)
	}

	expense1, expense2 := findtwo(2020, expenses)
	fmt.Printf("Part 1: %d\n", expense1*expense2)

	expense1, expense2, expense3 := findthree(2020, expenses)
	fmt.Printf("Part 2: %d\n", expense1*expense2*expense3)
}
