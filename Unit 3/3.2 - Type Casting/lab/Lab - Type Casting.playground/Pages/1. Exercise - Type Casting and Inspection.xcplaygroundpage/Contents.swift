/*:
 ## Exercise - Type Casting and Inspection
 
 Create a collection of type [Any], including a few doubles, integers, strings, and booleans within the collection. Print the contents of the collection.
 */
let typeCasting: [Any] = [3.14, 12.39, 12, 199, "무차", "뚜따", false]
print(typeCasting)

/*:
 Loop through the collection. For each integer, print "The integer has a value of ", followed by the integer value. Repeat the steps for doubles, strings and booleans.
 */
for i in typeCasting {
    if let x = i as? Bool {
        print("The integer has a value of \(x)")
    } else {
        
    }
}

/*:
 Create a [String : Any] dictionary, where the values are a mixture of doubles, integers, strings, and booleans. Print the key/value pairs within the collection
 */
var myDic: Dictionary<String, Any> = ["Pi": 3.14, "Size":6.9 , "Age":27, "BirthYear": 1996, "Name":"김태현","Oldies":"Must die","subway Line 1": "Collection of garbage"]
print(myDic)
myDic["Pi"]
/*:
 Create a variable `total` of type `Double` set to 0. Then loop through the dictionary, and add the value of each integer and double to your variable's value. For each string value, add 1 to the total. For each boolean, add 2 to the total if the boolean is `true`, or subtract 3 if it's `false`. Print the value of `total`.
 */


var total :Double = 0


for (_, j) in myDic {
    if let x = j as? Int {
        total += Double(x)
    } else if let x = j as? Double {
        total += x
    } else if let x = j as? String {
        total += 1
    } else if let x = j as? Bool {
        if x == true {
            total += 2
        } else if x == false {
            total -= 3
        }
    }
}

print(total)
/*:
 Create a variable `total2` of type `Double` set to 0. Loop through the collection again, adding up all the integers and doubles. For each string that you come across during the loop, attempt to convert the string into a number, and add that value to the total. Ignore booleans. Print the total.
 */
var total2: Double = 0

for (_, value) in myDic {
    if let number = value as? Int {
        total2 = total2 + Double(number)
    } else if let number = value as? Double {
        total2 = total2 + number
    } else if let string = value as? String {
        if let validNumber = Double(string) {
            total2 = total2 + validNumber
        }
    }
}

print(total2)

//: page 1 of 2  |  [Next: App Exercise - Workout Types](@next)
