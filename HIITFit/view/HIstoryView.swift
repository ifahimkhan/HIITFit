
import SwiftUI

struct HIstoryView: View {
    let history = HistoryStore()

    var body: some View {
        ZStack (alignment: .topTrailing){
            Button(action:{}){
                Image(systemName: "xmark.circle")
            }.font(.title)
                .padding(.trailing)
            VStack{
                Text("History")
                    .font(.title)
                    .padding()
                Form{
                    ForEach(history.exerciseDays){  day in
                        Section(header: Text(day.date.formatted(as: "MMM d")).font(.headline)){
                            ForEach(day.exercise,id:\.self){    exercise in
                                Text(exercise)
                            }
                        }
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
