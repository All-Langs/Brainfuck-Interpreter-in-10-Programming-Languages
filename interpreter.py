#!/usr/bin/python

import sys, getopt

def interpreter(sourceCode):
    i = 0
    RAM = {0:0}
    indexInRAM = 0
    whileArray = []
    while i < len(sourceCode):
        if sourceCode[i] == "[":
            if (i+1) not in whileArray:
                whileArray.append(i+1)
        elif sourceCode[i] == "]":
            if RAM[indexInRAM] == 0:
                whileArray.pop()
            else:
                i = whileArray[len(whileArray)-1]
                continue
        elif sourceCode[i] == ">":
            indexInRAM = indexInRAM + 1
            if indexInRAM not in RAM.keys():
                RAM[indexInRAM] = 0
        elif sourceCode[i] == "<":
            indexInRAM = indexInRAM - 1
        elif sourceCode[i] == "+":
            RAM[indexInRAM] = RAM[indexInRAM] + 1
        elif sourceCode[i] == "-":
            try:
                RAM[indexInRAM] = RAM[indexInRAM] - 1
            except:
                RAM[indexInRAM] = -1
        elif sourceCode[i] == ".":
            print chr(RAM[indexInRAM])
        elif sourceCode[i] == ",":
            while True:
                try:
                    RAM[i] = input()
                    break
                except:
                    print "You should enter integer"
        i += 1



def read_SourceCode(file_name):
    with open(file_name, "r") as ins:
        sourceCode = []
        for line in ins:
            for c in line:
                if c != "\n":
                    sourceCode.append(c)

        interpreter(sourceCode)




def main(argv):
    inputfile = ''
    outputfile = ''
    try:
        opts, args = getopt.getopt(argv,"hi:o:",["ifile="])
    except getopt.GetoptError:
        print 'interpreter.py -i <inputfile>'
        sys.exit(2)
    for opt, arg in opts:
       if opt == '-h':
           print 'interpreter.py -i <inputfile>'
           sys.exit()
       elif opt in ("-i", "--ifile"):
           inputfile = arg
           read_SourceCode(inputfile)


if __name__ == "__main__":
    main(sys.argv[1:])
