package main

import "C"
import "fmt"

//export Sum
func Sum(arg1, arg2 int32) int32 {
	return arg1 + arg2
}

//export Hello
func Hello() {
	fmt.Println("hello world from go dll!")
}

//export GetStr
func GetStr() string {
	return "Hello 世界!"
}

//export GetBytes
func GetBytes() []byte {
	return []byte(fmt.Sprintf("%s\n%s",GetStr(),"世界、こんにちは！"))
}

func main(){}