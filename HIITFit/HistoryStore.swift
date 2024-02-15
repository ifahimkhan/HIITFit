import Foundation

struct ExerciseDay: Identifiable{
    let id = UUID()
    let date: Date
    var exercise: [String] = []

}
class HistoryStore: ObservableObject{
    @Published var exerciseDays:[ExerciseDay] = []

    init(){
        #if DEBUG
        createDevData()
        #endif
    }
    func addDoneExercise(_ exerciseName:String)	{
        let today = Date()
        if today.isSameDay(as: exerciseDays[0].date){
            print("adding exercise")
            exerciseDays[0].exercise.append(exerciseName)
        }else{
            exerciseDays.insert(ExerciseDay(date: today,exercise: [exerciseName]), at: 0)
        }
    }
}
