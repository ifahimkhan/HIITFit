import Charts
import SwiftUI

struct BarChartsDayView: View {
    let day: ExerciseDay
    var body: some View {
        Chart{
            ForEach(Exercise.names,id: \.self){name in
                BarMark(x: .value(name, name), y: .value("Total Count",day.countExercise(exe: name)))
                    .foregroundStyle(Color("history-bar"))

            }
            RuleMark(y: .value("exercise", 1))
                .foregroundStyle(.red)
        }.padding()
    }
}

struct BarChartsDayView_Previews: PreviewProvider {
    static var histroy: HistoryStore = HistoryStore(preview: true)
    static var previews: some View {
        BarChartsDayView(day: histroy.exerciseDays[0]).environmentObject(histroy)
    }
}
