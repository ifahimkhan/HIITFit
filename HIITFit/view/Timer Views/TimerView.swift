
import SwiftUI

struct CountdownView: View {
    let date: Date
    @Binding var timeRemaining: Int
    let size: Double

    var body: some View {
        Text("\(timeRemaining)")
            .font(.system(size: 90, design: .rounded))
            .fontWeight(.heavy)
            .frame(
                minWidth: 180,
                maxWidth: 200,
                minHeight: 180,
                maxHeight: 200)
            .padding()
            .onChange(of: date) { _ in
                timeRemaining -= 1
            }
    }
}

struct TimerView: View {
    @Environment(\.dismiss) var dismiss
    @State private var timeRemaining: Int = 3
    @Binding var timerDone: Bool
    let exerciseName: String

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color("background")
                    .ignoresSafeArea()
                let gradient = Gradient(
                    stops: [
                        Gradient.Stop(color: Color("gradient-top"), location: 0.7),
                        Gradient.Stop(color: Color("gradient-bottom"), location: 1.1)
                    ])
                Circle()
                    .foregroundStyle(gradient)
                    .position(
                        x: geometry.size.width * 0.5,
                        y: -geometry.size.width * 0.2)
                VStack {
                    Text(exerciseName)
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    Spacer()
                }
                TimelineView(
                    .animation(
                        minimumInterval: 1.0,
                        paused: timeRemaining <= 0)) { context in
                            IndentView {
                                CountdownView(
                                    date: context.date,
                                    timeRemaining: $timeRemaining,
                                    size: geometry.size.width)
                            }
                        }
                        .onChange(of: timeRemaining) { _ in
                            if timeRemaining < 1 {
                                timerDone = true
                            }
                        }
                VStack {
                    Spacer()
                    RaisedButton(buttonText: "Done") {
                        dismiss()
                    }
                    .opacity(timerDone ? 1 : 0)
                    .padding([.leading, .trailing], 30)
                    .padding(.bottom, 60)
                    .disabled(!timerDone)
                }
            }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(
            timerDone: .constant(false),
            exerciseName: "Step Up")
    }
}
