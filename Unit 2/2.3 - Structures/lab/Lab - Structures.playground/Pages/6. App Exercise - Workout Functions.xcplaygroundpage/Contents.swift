/*:
 ## App Exercise - Workout Functions
 
 >These exercises reinforce Swift concepts in the context of a fitness tracking app.
 
 A `RunningWorkout` struct has been created for you below. Add a method on `RunningWorkout` called `postWorkoutStats` that prints out the details of the run. Then create an instance of `RunningWorkout` and call `postWorkoutStats()`.
 */
struct RunningWorkout {
    var distance: Double
    var time: Double
    var elevation: Double
    
    func postWorkoutStats() {
        print("You ran total distance of \(distance) in \(time/60) mintues. The elevation was \(elevation)")
    }
}
var runner: RunningWorkout = RunningWorkout(distance: 13.14, time: 12000, elevation: 3.1)
runner.postWorkoutStats()
/*:
 A `Steps` struct has been created for you below, representing the day's step-tracking data. It has the goal number of steps for the day and the number of steps taken so far. Create a method on `Steps` called `takeStep` that increments the value of `steps` by one. Then create an instance of `Steps` and call `takeStep()`. Print the value of the instance's `steps` property before and after the method call.
 */
struct Steps { 
    var steps: Int {
        willSet { print("Steps until is \(steps)") }
        
        didSet { print("Steps now is \(steps)") }
    }
    var goal: Int
    
    mutating func takeStep() {
        steps += 1
        
    }
}

var newSteps = Steps(steps: 350, goal: 10_000)
newSteps.takeStep()

//: [Previous](@previous)  |  page 6 of 10  |  [Next: Exercise - Computed Properties and Property Observers](@next)
