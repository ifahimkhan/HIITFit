import Foundation

struct ExerciseDay: Identifiable{
    let id = UUID()
    let date: Date
    var exercise: [String] = []

}
struct HistoryStore{
    var exerciseDays:[ExerciseDay] = []

    init(){
        #if DEBUG
        createDevData()
        #endif
    }
}
