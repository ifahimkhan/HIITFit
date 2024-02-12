
import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 9
    
    var body: some View {
        TabView(selection:$selectedTab){
            WelcomeView(selectionTab: $selectedTab)
                .tag(9)
            ForEach(Exercise.exercises.indices,id: \.self){
                index in
                ExerciseView(index: index, selectedTab: $selectedTab)
            }
        }.tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
