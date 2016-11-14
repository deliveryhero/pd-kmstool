package main

import (
	"github.com/foodpanda/kmstool/src"
	"os"
)

func main() {
	a := kmstool.NewApp()
	a.Run(os.Args)
}
