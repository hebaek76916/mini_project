//
//import UIKit
//
//
//private final class QueueNode<T> {
//    // note, not optional – every node has a value
//    var value: T
//    // but the last node doesn't have a next
//    var next: QueueNode<T>? = nil
//
//    init(value: T) { self.value = value }
//}
//
//// Ideally, Queue would be a struct with value semantics but
//// I'll leave that for now
//public final class Queue<T> {
//    // note, these are both optionals, to handle
//    // an empty queue
//    private var head: QueueNode<T>? = nil
//    private var tail: QueueNode<T>? = nil
//
//    public init() { }
//}
//
//extension Queue {
//    // append is the standard name in Swift for this operation
//    public func append(newElement: T) {
//        let oldTail = tail
//        self.tail = QueueNode(value: newElement)
//        if  head == nil { head = tail }
//        else { oldTail?.next = self.tail }
//    }
//
//    public func dequeue() -> T? {
//        if let head = self.head {
//            self.head = head.next
//            if head.next == nil { tail = nil }
//            return head.value
//        }
//        else {
//            return nil
//        }
//    }
//}
//
//var a = Queue<Int>()
//a.append(newElement: 1)
//a.append(newElement: 2)
//a.append(newElement: 3)
//
//print(a.dequeue() )
//print(a)
//struct Queue<T> {
//    private var queue: [T?] = []
//    private var head: Int = 0
//
//    public var count: Int {
//        return queue.count
//    }
//
//    public var isEmpty: Bool {
//        return queue.isEmpty
//    }
//
//    public mutating func enqueue(_ element: T) {
//        queue.append(element)
//    }
//
//    public mutating func dequeue() -> T? {
//        guard head <= queue.count, let element = queue[head] else { return nil }
//        queue[head] = nil
//        head += 1
//
//        if head > 50 {
//            queue.removeFirst(head)
//            head = 0
//        }
//        return element
//    }
//}
public struct Queue<T> {
    internal var data = Array<T>()
    public init() {}
    
    public mutating func dequeue() -> T? {
        return data.removeFirst()
    }
    
    public func peek() -> T? {
        return data.first
    }
    
    public mutating func enqueue(element: T) {
        data.append(element)
    }
    
    public mutating func clear() {
        data.removeAll()
    }
    
    public var count: Int {
        return data.count
    }
    
    public var capacity: Int {
        get {
            return data.capacity
        }
        set {
            data.reserveCapacity(newValue)
        }
    }
    
    public func isFull() -> Bool {
        return count == data.capacity
    }
    
    public func isEmpty() -> Bool {
        return data.isEmpty
    }
}

var z = Queue<Int>()
var q = Queue<Int>()

z.enqueue(element: 1)
z.enqueue(element: 3)
z.dequeue()
z.count
z.dequeue()
z.count

z.isEmpty
z
print(z.isEmpty)
print(q.isEmpty)
let s = "A 3"
print("\(s[s.index(before: s.endIndex)])")

var array = ["a", "b","c","d"]
array.remove(at: 2)
print(array)
array.insert("QQQ", at: 1)
print(array)
for i in 0..<3 {
    print(i)
}
var usingArr = [Int]()

for i in 0..<8 {
    usingArr.append(i)
}

print(usingArr)
var qw: Int = 0
usingArr.insert(100, at: qw)


func solution(_ n:Int, _ k:Int, _ cmd:[String]) -> String {
    
    var deleteSave = Queue<Int>()
    
    var answerStr = String(repeating: "O", count: n)
    var usingArr = [Int]()
    
    for i in 0..<n {
        usingArr.append(i)
    }
    var cursor = k
    var index = 0
    
    for line in cmd {
        print(line)
        
        switch line.first {
            case "D":
                index = Int(String(describing: line[line.index(before: line.endIndex)]))!
                cursor += index
            case "U":
                index = Int(String(describing: line[line.index(before: line.endIndex)]))!
                cursor -= index
            case "C":
                if usingArr.count - 1 < cursor {
                    cursor -= 1
                    print("cursor : \(cursor)")
                    usingArr.remove(at: cursor)
                    deleteSave.enqueue(element: cursor)
                    
                } else {
                    print(" cursor : \(cursor)")
                    usingArr.remove(at: cursor)
                    deleteSave.enqueue(element: cursor)
                }
            case "Z":
                print(line)
                let a = deleteSave.dequeue()!
                usingArr.insert(a, at: a)
            default:
                print("wrong cmd")
        }
    }

    print(usingArr)
    while !deleteSave.isEmpty() {
            //answerStr.insert("X", at: String.Index(encodedOffset: deleteSave.dequeue()!))// deleteSave.dequeue()!)
            //print(answerStr.index)
            answerStr = replace(myString: answerStr, deleteSave.dequeue()!, "X")
        
    }

    print(answerStr)
    print("end")
    
    return ""
}

func replace(myString: String, _ index: Int, _ newChar: Character) -> String {
    var chars = Array(myString)     // gets an array of characters
    chars[index] = newChar
    let modifiedString = String(chars)
    return modifiedString
}
solution(8, 2, ["D 2","C","U 3","C","D 4","C","U 2","Z","Z"])
