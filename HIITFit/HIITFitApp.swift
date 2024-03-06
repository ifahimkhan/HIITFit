import SwiftUI

@main
struct HIITFitApp: App {
    @StateObject var historyStore = HistoryStore(preview: true)
    var body: some Scene {
        WindowGroup {
            ContentView()
                .alert(isPresented:$historyStore.loadingError){
                    Alert(title: Text("History"),
                          message: Text("""
unfortunately we can't load your past history.
Email support: abxcd@gmail,comå
"""))
                }
                .environmentObject(historyStore)
        }
    }
}
