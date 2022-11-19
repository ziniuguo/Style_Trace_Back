package main

//#include <stdlib.h>
import (
	"bufio"
	"io"
	"os/exec"
	"strings"
)

func predict(path string) []string {
	cmd := exec.Command("python3.10", "predictor.py", "--file", path)
	stdout, err := cmd.StdoutPipe()
	if err != nil {
		panic(err)
	}
	_, err = cmd.StderrPipe()
	if err != nil {
		panic(err)
	}
	err = cmd.Start()
	if err != nil {
		panic(err)
	}

	// var text string = copyOutput(stdout)
	// fmt.Println(text)
	str := copyOutput(stdout)
	return str

	// cmd.Process.Kill()
}

func copyOutput(r io.Reader) []string {
	scanner := bufio.NewScanner(r)
	arr := []string{}
	for scanner.Scan() {
		// fmt.Println(scanner.Text())
		arr = append(arr, strings.ReplaceAll(scanner.Text(), "\"", ""))
	}
	return arr
}
