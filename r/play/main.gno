package main

import (
	"workspace/p/play"
)

var Play *play.Play

func Render(path string) string { return "" }

func main() {
	Play = play.NewPlay()
}
