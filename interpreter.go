/**
  @MDDemirci
**/


package main

import "os"
import "fmt"
import "io/ioutil"
import "reflect"

func in_array(val interface{}, array interface{}) (exists bool, index int) {
    exists = false
    index = -1

    switch reflect.TypeOf(array).Kind() {
    case reflect.Slice:
        s := reflect.ValueOf(array)

        for i := 0; i < s.Len(); i++ {
            if reflect.DeepEqual(val, s.Index(i).Interface()) == true {
                index = i
                exists = true
                return
            }
        }
    }

    return
}

func check(e error) {
    if e != nil {
        fmt.Println("Error : %s",e)
    }
}

func read_SourceCode(file_name string){
    dat, err := ioutil.ReadFile(file_name)
    check(err)
    interpreter(string(dat))
}

func stringToArray(sourceCode string) []string{
  array := []string{}
  for _, r := range sourceCode {
      c := string(r)
      array = append(array,c)
  }
  return array
}

func interpreter(sourceCode string) {
  i := 0
  RAM := []int{0}
  indexInRAM := 0
  whileArray := []int{}

  codeArray := stringToArray(sourceCode)
  for i < len(codeArray) {
    if codeArray[i] == "["{
      inArray,_ := in_array(i+1,whileArray)
      if !inArray{
        whileArray = append(whileArray,i+1)
      }
    }else if codeArray[i] == "]"{
      if RAM[indexInRAM] == 0{
          whileArray = whileArray[:len(whileArray)-1]
      }else {
        i = whileArray[len(whileArray)-1]
        continue
      }
    }else if codeArray[i] == ">"{
      indexInRAM = indexInRAM + 1
      if len(RAM) >= indexInRAM{
        RAM = append(RAM,0)
      }
    }else if codeArray[i] == "<"{
      indexInRAM = indexInRAM - 1
    }else if codeArray[i] == "+"{
      RAM[indexInRAM] = RAM[indexInRAM] + 1
    }else if codeArray[i] == "-"{
      RAM[indexInRAM] = RAM[indexInRAM] - 1
    }else if codeArray[i] == "."{
      fmt.Printf("%c\n", RAM[indexInRAM])
    }else if codeArray[i] == ","{
      // TO DO
    }
    i += 1
  }
}

func main() {
    // `os.Args` provides access to raw command-line
    // arguments. Note that the first value in this slice
    // is the path to the program, and `os.Args[1:]`
    // holds the arguments to the program.

    argsWithoutProg := os.Args[1:]

    if len(argsWithoutProg) == 1 {
      read_SourceCode(argsWithoutProg[0])
    }else {
      fmt.Println("go run interpreter.go <inputfile>")
    }
}
