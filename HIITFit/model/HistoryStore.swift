import Foundation

struct ExerciseDay: Identifiable{
    let id = UUID()
    let date: Date
    var exercise: [String] = []

}
enum FileError: Error{
    case loadFailure
    case saveFailure
}
class HistoryStore: ObservableObject{
    @Published var loadingError = false
    @Published var exerciseDays:[ExerciseDay] = []
    var dataUrl: URL{
        URL.documentsDirectory
            .appendingPathComponent("history.plist")
    }


    init(){
#if DEBUG
        createDevData()
#endif
        do{
            try  load()
        }catch{
            print("Error: ",error)
            loadingError = true
        }
    }
    func addDoneExercise(_ exerciseName:String)    {
        let today = Date()
        if let firstDate = exerciseDays.first?.date,
           today.isSameDay(as: firstDate){
            print("adding exercise")
            exerciseDays[0].exercise.append(exerciseName)
        }else{
            exerciseDays.insert(ExerciseDay(date: today,exercise: [exerciseName]), at: 0)
        }
        print("Histroy",exerciseDays)
    }
    func load() throws{
//        throw FileError.loadFailure
    }

    func save() throws{
        let plistData = exerciseDays.map {
            [$0.id.uuidString,$0.date,$0.exercise]
        }
        do{
            let data = try PropertyListSerialization.data(fromPropertyList: plistData, format: .binary, options: .zero)
            try data.write(to: dataUrl,options: .atomic)

        }catch{
            FileError.saveFailure
        }

    }
}
