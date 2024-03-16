
import SwiftUI
import AVKit

struct ExerciseView: View {
    @EnvironmentObject var history: HistoryStore
    let index:Int
    var exercise: Exercise{
        Exercise.exercises[index]
    }
    let interval: TimeInterval = 30
    @Binding var selectedTab: Int
    
    //    @AppStorage("rating") private var rating = 0
    @State private var showHistory = false
    @State private var showSuccess = false
    @State private var timerDone = false
    @State private var showTimer = false
    
    
    
    var lastExercise: Bool{
        index + 1 == Exercise.exercises.count
    }
    
    var doneButton: some View{
        Button("Done"){
            history.addDoneExercise(exercise.exerciseName)
            if(lastExercise){
                showSuccess.toggle()
            }else{
                selectedTab = lastExercise ? 9 : selectedTab + 1
            }
            timerDone = false
            showTimer.toggle()
        }
    }
    var startButton: some View{
        RaisedButton(buttonText: "Start Exercise"){
            showTimer.toggle()
        }
        
    }

    var historyButton: some View{
        Button(action: {
            showHistory = true
        }, label: {
            Text("History")
                .fontWeight(.bold)
                .padding([.leading,.trailing],5)
        })
        .padding(.bottom,10)
        .buttonStyle(EmbossedButtonStyle())
    }
    var body: some View {
        let exerciseName = Exercise.exercises[index].exerciseName
        
        GeometryReader { geometry in
            VStack{
                HeaderView(selectedTab: $selectedTab,titleText: exercise.exerciseName)
                    .padding(.bottom)
                Spacer()
                ContainerView{
                    VStack{
                        VideoPlayerView(videoName:exercise.videoName).frame(height: geometry.size.height * 0.45)
                            .padding(20)
                        HStack (spacing:150){
                            startButton
                                .padding([.leading, .trailing], geometry.size.width * 0.1)
                                .sheet(isPresented: $showTimer) {
                                    TimerView(
                                        timerDone: $timerDone,
                                        exerciseName: exerciseName)
                                    .onDisappear {
                                        if timerDone {
                                            history.addDoneExercise(Exercise.exercises[index].exerciseName)
                                            timerDone = false
                                            if lastExercise {
                                                showSuccess.toggle()
                                            } else {
                                                withAnimation {
                                                    selectedTab += 1
                                                }
                                            }
                                        }
                                    }
                                }
                                .sheet(isPresented: $showSuccess) {
                                    SuccessView(selectedTab: $selectedTab)
                                        .presentationDetents([.medium, .large])
                                }
                        }
                        .font(.title3)
                        .padding()
                        Spacer()
                        RatingView(exerciseIndex: index)
                            .padding()
                        historyButton
                            .sheet(isPresented: $showHistory) {
                                HistoryView(showHistory: $showHistory)
                            }
                            .padding(.bottom)

                    }

                }.frame(height:geometry.size.height*0.8)
            }

        }

    }

}
struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView(index: 3, selectedTab: .constant(1))
            .environmentObject(HistoryStore(preview: true))
    }
}



