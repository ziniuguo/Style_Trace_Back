package main

//#include <stdlib.h>
import (
	"bufio"
	"fmt"
	"io"
	"os/exec"
)

func main() {
	cmd := exec.Command("python3.10", "predictor.py", "--file", "upload-400237171.png")
	stdout, err := cmd.StdoutPipe()
	if err != nil {
		panic(err)
	}
	stderr, err := cmd.StderrPipe()
	if err != nil {
		panic(err)
	}
	err = cmd.Start()
	if err != nil {
		panic(err)
	}

	// var text string = copyOutput(stdout)
	// fmt.Println(text)
	go copyOutput(stdout)
	go copyOutput(stderr)

	cmd.Wait()
	// cmd.Process.Kill()
}

func copyOutput(r io.Reader) string {
	scanner := bufio.NewScanner(r)
	for scanner.Scan() {
		fmt.Println(scanner.Text())
		// return scanner.Text()
	}
	return ""
}
