import Foundation

struct ExerciseDay: Identifiable{
    let id = UUID()
    let date: Date
    var exercise: [String] = []
    //dataset
    var uniqueExercises: [String] {
     Array(Set(exercise)).sorted(by: <)
   }


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


    init(preview: Bool = false){
        do{
            try  load()
        }catch{
            print("Error: ",error)
            loadingError = true
        }

        #if DEBUG
        if preview{
            createDevData()
        }else{
            if exerciseDays.isEmpty{
                copyHistoryTestData()
                try? load()
            }
        }
            #endif

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
        do{
            try save()
        }catch{
            fatalError(error.localizedDescription)
        }
    }
    func load() throws{
        do{
            guard let data  = try? Data(contentsOf: dataUrl)else{
                return
            }
            let plistData =  try PropertyListSerialization.propertyList(from: data, options: [],format: nil)
            let convertedPlistData = plistData as? [[Any]] ?? []

            exerciseDays = convertedPlistData.map{
                ExerciseDay(date: $0[1] as? Date ?? Date(),
                            exercise: $0[2] as? [String] ?? [])
            }

        }catch{
            throw FileError.loadFailure
        }

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


    func countExercise(exercise: String) -> Int {
     exercises.filter { $0 == exercise }.count
   }
}
