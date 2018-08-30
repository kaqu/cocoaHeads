import Foundation
/*:
 You can define custom patterns simply by implementing ~= function
 */

struct Regex {
    let pattern: String
    
    init(_ pattern: String) {
        self.pattern = pattern
    }
}

func ~=(lhs: Regex, rhs: String) -> Bool {
    return rhs.range(of: lhs.pattern, options: .regularExpression) != nil
}

let someString = "0123456789"

switch someString {
case Regex("^[a-z]"):
    print("case Regex(\"^[a-z]\")")
case Regex("[0-9]{10}"):
    print("case Regex(\"[0-9]{10}\")")
case _:
    print("case _:")
}

//: ---

struct CrazyStruct {
    let x: Int
    let y: Double
    let s: String
}

enum CrazyMatcher {
    case good
    case notGood
    case whoKnows
}

func ~=(lhs: CrazyMatcher, rhs: CrazyStruct) -> Bool {
    switch lhs {
    case .good:
        return rhs.x > 0 && rhs.y > 0 && !rhs.s.isEmpty
    case .notGood:
        return rhs.x < 0 && rhs.y < 0 && rhs.s.isEmpty
    case .whoKnows:
        return rhs.x == 0 || rhs.y == 0
    }
}

let someCrazy = CrazyStruct(x: 10, y: 0, s: "crazy")

// according to: https://stackoverflow.com/questions/47060366/custom-pattern-matching-fails-with-enum-case-is-not-a-member-of-type
// there is compiler error now which forces tu use auxiliary variables/constants
let crazyMatcherGood = CrazyMatcher.good
let crazyMatcherNotGood = CrazyMatcher.notGood
let crazyMatcherWhoKnows = CrazyMatcher.whoKnows

switch someCrazy {
//case CrazyMatcher.good: // this will work after compiler fix
case crazyMatcherGood:
    print("case CrazyMatcher.good")
case crazyMatcherNotGood:
    print("case CrazyMatcher.notGood")
case crazyMatcherWhoKnows:
    print("case CrazyMatcher.whoKnows")
case _:
    print("case _")
}

//: ---

extension CrazyStruct : Error {}
enum CrazyErrorMatcher {
    case bad
    case whoKnows
}

// gotcha - you match with error here, not with CrazyStruct
func ~=(lhs: CrazyErrorMatcher, rhs: Error) -> Bool {
    switch lhs {
    case .bad:
        return rhs.localizedDescription.isEmpty
    case .whoKnows:
        return true
    }
}

// let someCrazy = CrazyStruct(x: 10, y: 0, s: "crazy") - declared before

let crazyErrorMatcherWhoKnows = CrazyErrorMatcher.whoKnows

do {
    throw someCrazy
} catch CrazyErrorMatcher.whoKnows { // it compiles, but does not match... another swift error?
    print("catch CrazyErrorMatcher.whoKnows")
} catch crazyErrorMatcherWhoKnows {
    print("catch crazyErrorMatcherWhoKnows")
} catch let error as CrazyErrorMatcher {
    print("catch error as CrazyErrorMatcher ; \(error)")
} catch {
    print("\(error)")
}

/*:
 
 ---

 [Home](Home)
 
 [Next](@next)
 
 [Previous](@previous)

*/
