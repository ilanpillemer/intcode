package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	f, _ := os.ReadFile("sample")
	str := strings.Repeat(string(f), 10_000)
	xs := strings.Split(str, "")
	next := phase(xs)
	fmt.Println(next)
}

func phase(input []string) []string {
	ret := []string{}
	for i := len(input) - 1; i >= 0; i-- {
		str := input[i:]
		digit := sum(str) % 10
		_ = digit
		//ret = append(ret, fmt.Sprintf("%d", digit))
		//fmt.Printf("%s\n", ret)
		//fmt.Println(i)
	}
	return ret
}

func sum(input []string) int {
	total := 0
	for _, s := range input {
		total = total + atoi(s)

	}
	return total
}

func atoi(x string) int {
	i, err := strconv.Atoi(x)
	if err != nil {
		panic(err)
	}
	return i
}
