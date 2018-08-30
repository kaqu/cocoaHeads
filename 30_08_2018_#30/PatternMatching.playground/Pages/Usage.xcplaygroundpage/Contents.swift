import Foundation

/*:
 Constant / Variable
 ---
 ---
 */

_ = "Anything discarded"

let simple = "some value"

let tuple = ("some", "tuple")

let (one, two) = ("some", "tuple")

/*:
 if / guard
 ---
 ---
 */

let optionalString = Optional("value")

if let unwrapped = optionalString {
    print("if let unwrapped = condValue ; \(unwrapped)")
} else { /* ignore */ }

if optionalString is Optional<Int> {
    print("if optionalString is Optional<Int>")
// you can match to concrete value, optionals are kind of special enum with a lot of sugar
} else if case "someCheck" = optionalString {
    print("if case \"someCheck\" = optionalString")
} else { /* ignore */ }

// Optional is Enum
if case let .some(v) = optionalString {
    print("if case let .some(v) = condValue ; \(v)")
} else if case .none = optionalString {
    print("if case .none = condValue")
} else { /* ignore */ }

// guard allows same constructions as if
// you can ommit enum case values
guard case .some = optionalString else { fatalError() }

//: ---

enum SomeEnum {
    case first
    case second
    case value(Any)
}

let someEnum = SomeEnum.value("secretType")

if case .first = someEnum {
    print("if case .first = someEnum")
// you can match variable types, it allows to avoid type cast later
} else if case let .value(v as Int) = someEnum {
    print("if case let .value(v as Int) = someEnum ; \(v)")
} else if case let .value(v) = someEnum {
    print("if case let .value(v) = someEnum ; \(v)")
} else { /* ignore */ }

//: ---

let someInt = 7

if case 5 = someInt {
    print("if case 5 = someInt")
} else if case 0...5 = someInt {
    print("if case 0...5 = someIn")
// you can also use conditions here
} else if case let x = someInt, x > 9 {
    print("if case let x = someInt, x > 9")
} else { /* ignore */ }

//: ---

let someTuple: (Any, Int) = ("some" , 2)

if case (_, 0) = someTuple {
    print("if case (_, 0) = someTuple")
} else if case (_, 0...5) = someTuple {
    print("if case (_, 0...5) = someTuple")
} else if case let (_ as String, x) = someTuple, x > 9 {
    print("if case let (_ as String, x) = someTuple, x > 9")
// only type checking, allows selective check
} else if case (_ as Int, _) = someTuple {
    print("if case (_ as Int, _) = someTuple")
// only type checking other way, whole type must match
} else if case is (String, Int) = someTuple {
    print("if case is (String, Int) = someTuple")
} else { /* ignore */ }

/*:
 for-in / while
 ---
 ---
 */

let someArray: [Any] = [0, "String", 2, 3.14, 4, ("tuple", "here")]

for case let i as Int in someArray {
    print("Only ints: \(i)")
}

for case let s as String in someArray {
    print("Only strings: \(s)")
}

//: ---

let someOptionalInts = [0, nil, 2, 3, nil, 5]
// filters non nil
for case let x? in someOptionalInts {
    print("Only int: \(x)")
}
// filters only zeros
for case 0 in someOptionalInts {
    print("Only zeros")
}

//: ---

var someWhileCondition = 1
while case 0 = someWhileCondition {
    someWhileCondition = Int(arc4random_uniform(3))
    print("while looping")
}

//: ---

var whileVariable: Any = "whileVariable"
while case let v as String = whileVariable {
    whileVariable = someArray[Int(arc4random_uniform(4))]
    print("crazy while looping with casting: \(v)")
}

// this will be allowed in next version of swift according to docs: https://docs.swift.org/swift-book/ReferenceManual/Patterns.html#ID423
// filters tuple with access to other value
//let someTuplesArray = [(0, "zero"), (1, "one"), (2, "two")]
//for (0, x) in someTuplesArray {
//    print("Only zero tuples: \(x)")
//}

/*:
 switch
 ---
 ---
 */

// switch is like if, but better

// let optionalString = Optional("value") - declared before

switch optionalString {
case "someValue":
    print("case \"someValue\" ")
// this unwraps optional like if let
case let someOptional?:
    print("case let someOptional?  \(someOptional)")
//case 0: // type checker does not allows since 0 is not string
//    print("case 0 ")
//case let (x, y): // type checker does not allows since it is also no a tuple
//    print("case let (x, y) ")
case _: // same as default
    print("case _ ")
}

//: ---

// let someTuple: (Any, Int) = ("some" , 2) - declared before
switch someTuple {
case ("some" as String, 0):
    print("case (\"some\" as String, 0)")
case (_, 7):
    print("case (_, 7)")
case let (s as String, _):
    print("case let (str as String, _) ; \(s)")
case let someTuple:
    print("case let someTuple ; \(someTuple)")
// value binding to identifier matches all cases, so it allows to ommit default case
//case _:
//    print("_ ")
}

let nestedTuple = (0, (0, (0, 0), (0, 0)))
switch nestedTuple {
case (_, (0, _, (0,_))):
    print("nestedTuple")
case _:
    print("case _ ")
}

class Tree {
    let value: Any
    let lTree: Tree?
    let rTree: Tree?
    
    init(value: Any = "", lTree: Tree? = nil, rTree: Tree? = nil) {
        self.value = value
        self.lTree = lTree
        self.rTree = rTree
    }
}

let someTree = Tree()

func ~=(l: Tree, r: Tree) -> Bool {
    return true // do it yourself... but it is like equals between trees
}

switch someTree {
case Tree(value: "", lTree: Tree(value: "", lTree: nil, rTree: Tree(value: "", lTree: nil, rTree: nil)), rTree: Tree(value: "", lTree: nil, rTree: nil)):
    print("TREE")
case _:
    print("case _ ")
}


//: ---

// let someInt = 7 - declared before

switch someInt {
// you can use ranges here
case -10...10:
    print("case -10...10")
case ...0:
    print("case ...0")
case 0...:
    print("case 0...")
// currently swift does not get it that all cases are covered and you must have default here
case _:
    print("case _")
}

//: ---

let mystery: Any = Optional("WOW") as Any

switch mystery {
case let x as String where x == "WOW":
    print("case let x as String where x == \"WOW\"")
case _:
    print("case _")
}

/*:
 do-catch
 ---
 ---
 */


//: ---

enum SomeError : Error {
    case bigError(reason: String)
    case smallError(reason: String)
}

do {
    throw SomeError.bigError(reason: "no big deal...")
} catch SomeError.bigError {
    print("catch CrazyError.bigError")
} catch let SomeError.smallError(reason) {
    print("catch let CrazyError.smallError(reason) ; \(reason)")
} catch {
    print("All other errors with implicit error - \(error)")
}

//: ---

extension Double : Error {}
extension String : Error {}

let errorDouble: Double = 3.14

do {
    throw errorDouble
} catch 0 as Double { // we have extended Double soo... it is allowed
    print("catch 0 as Double")
} catch "ERROR" as String { // we are catching Error type here, so type checker allows us to match with both String and Double
    print("catch \"ERROR\"")
} catch 3.14 as Double {
    print("catch 3.14 as Double")
} // catching allows to be nonexhaustive
catch { // but you can catch to switch...
    switch error {
    case _:
        print("just ignoring some error")
    }
}

/*:
 ---
 
 [Home](Home)
 
 [Next](@next)
 
 [Previous](@previous)
 
 */
