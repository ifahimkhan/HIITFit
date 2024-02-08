
import SwiftUI

struct HIstoryView: View {
    let today = Date()
    let yesterday = Date().addingTimeInterval(-86400)
    let exerciese1 = ["Squat","Step Up","Burpee","Sun Salute"]
    let exerciese2 = ["Squat","Step Up","Burpee"]

    var body: some View {
        VStack{
            Text("History")
                .font(.title)
                .padding()
            Form{
                Section(
                    header:Text(today.formatted(as: "MMM d"))
                        .font(.headline)
                ){
                    ForEach(exerciese1,id:\.self){
                        exercise in
                        Text(exercise)
                    }

                }

                Section(
                    header:Text(yesterday.formatted(as: "MMM d"))
                        .font(.headline)
                ){
                    ForEach(exerciese2, id: \.self){
                        exercise in
                        Text(exercise)
                    }

                }
            }
        }

    }
}

struct HIstoryView_Previews: PreviewProvider {
    static var previews: some View {
        HIstoryView()
    }
}
