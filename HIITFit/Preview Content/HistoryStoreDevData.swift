import Foundation

extension HistoryStore{
    func createDevData(){
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

    // copy history.plist to Documents directory
     func copyHistoryTestData() {
       let filename = "history.plist"
       if let resourceURL = Bundle.main.resourceURL {
         let sourceURL = resourceURL.appending(component: filename)
         let documentsURL = URL.documentsDirectory
         let destinationURL = documentsURL.appending(component: filename)
         do {
           try FileManager.default.copyItem(at: sourceURL, to: destinationURL)
         } catch {
           print("Failed to copy", filename)
         }
         print("Sample History data copied to Documents directory")
       }
     }

     // This method creates random test data.
     func createHistoryTestData() {
       print("Data construction started")
       exerciseDays = []
       let numberOfDays: Int = 720
       for day in 0..<numberOfDays {
         guard let date =
           Calendar.current.date(byAdding: .day, value: -day, to: Date())
         else {
           continue
         }
         var exerciseNames: [String] = []
         // repeat a random number of times (max 6) (max 24 exercises)
         // this will result in eg
         // [Squat, Step Up, Burpee, Step Up, Sun Salute, Step Up, Sun Salute]
         for _ in 0..<Int.random(in: 0...5) {
           for exercise in Exercise.exercises {
             if Bool.random() {
               exerciseNames.append(exercise.exerciseName)
             }
           }
         }
         if !exerciseNames.isEmpty {
             exerciseDays.append(ExerciseDay(date: date, exercise: exerciseNames))
         }
       }
       try? save()
       print("Data construction completed")
     }
}
