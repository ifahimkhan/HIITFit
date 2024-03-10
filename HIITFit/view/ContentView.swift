
import SwiftUI

struct ContentView: View {
    @SceneStorage("selectedTab") private var selectedTab = 9
    @State private var showHistory = false
    var body: some View {
        ZStack {
            GradientBackground()
            TabView(selection:$selectedTab){
                WelcomeView(selectedTab: $selectedTab)
                    .tag(9)
                ForEach(Exercise.exercises.indices,id: \.self){
                    index in
                    ExerciseView(index: index, selectedTab: $selectedTab)
                }
            }.onAppear{
                print(URL.documentsDirectory)
            }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
