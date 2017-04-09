// @MDDemirci

import Cocoa

extension String {

    var length: Int {
        return self.characters.count
    }

    subscript (i: Int) -> String {
        return self[Range(i ..< i + 1)]
    }

    func substring(from: Int) -> String {
        return self[Range(min(from, length) ..< length)]
    }

    func substring(to: Int) -> String {
        return self[Range(0 ..< max(0, to))]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return self[Range(start ..< end)]
    }

}

extension UInt8 {
    var char: Character {
        return Character(UnicodeScalar(self))
    }
}

extension Int {
    var char: Character {
        return Character(UnicodeScalar(self)!)
    }
}

func isInArray(value: Int, array: [Int]) -> Bool {

    for a in array {
        if a == value {
            return true
        }
    }
    return false
}


func interpreter(sourceCode: String) {
    var i = -1
    var RAM: [Int: Int] = [0: 0]
    var indexInRAM = 0
    var whileArray: [Int] = []
    while i < sourceCode.length && i <= 100 {
        i += 1
        switch sourceCode[i] {
        case "[":
            if !isInArray(value: i, array: whileArray) {
                whileArray.append(i)
            }
        case "]":
            if RAM[indexInRAM] == 0 {
                whileArray.removeLast()
            } else {
                i = whileArray.last!
            }
            continue
        case ">":
            indexInRAM = indexInRAM + 1

            if RAM[indexInRAM] == nil { //nil check
                RAM[indexInRAM] = 0
            }
        case "<":
            indexInRAM = indexInRAM - 1
        case "+":
            if let r = RAM[indexInRAM] { //nil check
                RAM[indexInRAM] = r + 1
            }
        case "-":
            RAM[indexInRAM] = RAM[indexInRAM]! - 1
        case ".":
            if let r = RAM[indexInRAM] {
                print(r.char)
            }
        case ",":
            //TODO input
            break
        default:
            break
        }

    }
}

func readFile(name: String) -> String? {

    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {

        let path = dir.appendingPathComponent(name)

        //reading
        do {
            let text = try String(contentsOf: path, encoding: String.Encoding.utf8)
            return text
        }
        catch { /* error handling here */ }
    }
    return nil
}

let name = ProcessInfo.processInfo.arguments[1]
let text = readFile(name: name)
if let t = text {
    interpreter(sourceCode: t)
}



