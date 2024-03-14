import Charts
import SwiftUI

struct BarChartWeekView: View {
    @EnvironmentObject var history: HistoryStore
    @State private var weekData:[ExerciseDay]=[]
    var body: some View {

        Chart(weekData) { day in
            ForEach(Exercise.names,id: \.self){
                name in
                BarMark(x: .value("Date", day.date,unit: .day), y: .value("Total Count",day.countExercise(exe: name)))
                    .foregroundStyle(by: .value("Exercise", name))


            }

        }
        .chartForegroundStyleScale([
            "Burpee": Color("chart-burpee"),
            "Squat": Color("chart-squat"),
            "Step Up": Color("chart-step-up"),
            "Sun Salute": Color("chart-sun-salute")
          ])
        .onAppear{
            let firstDate = history.exerciseDays.first?.date ?? Date()
            let dates = firstDate.previousSevenDays
            weekData = dates.map{
                date in
                history.exerciseDays.first(where: {
                    $0.date.isSameDay(as: date)
                }) ?? ExerciseDay(date: date)
            }
        }
        .padding()
    }
}

struct BarChartWeelView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartWeekView()
            .environmentObject(HistoryStore(preview: true))
    }
}
