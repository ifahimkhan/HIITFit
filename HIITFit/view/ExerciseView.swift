
import SwiftUI

struct ExerciseView: View {
    let videosNames = ["squat","step-up","burpee","sun-salute"]
    let exerciseNames = ["Squat","Step Up","Burpee","Sun Salute"]
    let index:Int
    var body: some View {
        VStack{
            HeaderView(exerciseName: exerciseNames[index])
            Text("Video Player")
            Text("Timer")
            Text("Start/Done button")
            Text("Rating")
            Text("History button")

        }
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView(index: 0)
    }
}

