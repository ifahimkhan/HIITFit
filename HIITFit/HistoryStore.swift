import Foundation

struct ExerciseDay: Identifiable{
    let id = UUID()
    let date: Date
    var exercise: [String] = []

}
struct HistoryStore{
    var exerciseDays:[ExerciseDay] = []
}

extension HistoryStore{
    mutating func createDevData(){
        exerciseDays = [
            ExerciseDay(
                date: Date().addingTimeInterval(-86400),
                exercise: [
                    Exercise.exercises[0].exerciseName,
                    Exercise.exercises[1].exerciseName,
                    Exercise.exercises[2].exerciseName
                ]),
            ExerciseDay(
                date: Date().addingTimeInterval(-86400 * 2),
                exercise: [
                    Exercise.exercises[0].exerciseName,
                    Exercise.exercises[1].exerciseName
                ])


        ]
    }
}
