import Charts
import SwiftUI

struct BarChartWeekView: View {
    @EnvironmentObject var history: HistoryStore
    @State private var weekData:[ExerciseDay]=[]
    @State private var isBarChartEnabled:Bool = true
    var body: some View {

        VStack {
            Text("History For Last Week")
                .font(.title)
                .padding()

            if isBarChartEnabled {
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
            }else{

                Chart(weekData) { day in
                    ForEach(Exercise.names,id: \.self){
                        name in
                        LineMark(x: .value("Date", day.date,unit: .day), y: .value("Total Count",day.countExercise(exe: name)))
                            .foregroundStyle(by: .value("Exercise", name))


                    }

                }
                .padding()
            }

            Toggle("Bar Chart",isOn: $isBarChartEnabled).padding()

        }
    }
}

struct BarChartWeelView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartWeekView()
            .environmentObject(HistoryStore(preview: true))
    }
}
