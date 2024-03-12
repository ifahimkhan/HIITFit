import SwiftUI

struct AddHistoryView: View {
    @State private var exerciseDate = Date()
    @Binding var addMode:Bool
    var body: some View {


        VStack{
            ZStack{
                Text("Add Exercise").font(.title)
                Button("Done"){
                    addMode=false
                }.frame(maxWidth: .infinity,alignment: .trailing)
            }
            ButtonViews(date: $exerciseDate)
            DatePicker("Choose Date",
                       selection: $exerciseDate,
                       in: ...Date(),
                       displayedComponents: .date)
            .datePickerStyle(.graphical)
        }.padding()
    }

}
struct ButtonViews: View{
    @EnvironmentObject var historyStore: HistoryStore
    @Binding var date: Date
    var body: some View{
        HStack{
            ForEach(Exercise.exercises.indices,id:\.self){
                index in
                let exerciseName =  Exercise.exercises[index].exerciseName
                Button(exerciseName){
                    historyStore.addExercise(date: date, exerciseName: exerciseName)
                }
            }
        }.buttonStyle(EmbossedButtonStyle(buttonScale: 1.5))
    }
}

struct AddHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddHistoryView(addMode: .constant(true)).environmentObject(HistoryStore(preview: true))
    }
}
