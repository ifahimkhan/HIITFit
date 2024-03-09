import SwiftUI

struct RatingView: View {
    let exerciseIndex: Int
    @AppStorage("ratings") private var ratings = ""
    @State private var rating = 0
    let maximumRating = 5
    
    let onColor = Color.red
    let offColor = Color.gray
    
    init(exerciseIndex: Int) {
        self.exerciseIndex = exerciseIndex
        let desiredLength = Exercise.exercises.count
        if ratings.count < desiredLength {
            ratings = ratings.padding(
                toLength: desiredLength,
                withPad: "0",
                startingAt: 0)
        }
    }
    
    
    fileprivate func convertRating() {
        let index = ratings.index(
            ratings.startIndex,
            offsetBy: exerciseIndex)
        let character = ratings[index]
        rating = character.wholeNumberValue ?? 0
    }
    var ratingButton: some View{
        Button(action:{},label: {
            Image(systemName: "waveform.path.ecg")
        }).buttonStyle(EmbossedButtonStyle())
    }
    
    var body: some View {
        HStack {
            ForEach(1 ..< maximumRating + 1, id: \.self) { index in
                
                Button(action: {
                    updateRating(index: index)
                    
                }, label: {
                    Image(systemName: "waveform.path.ecg")
                })
                .buttonStyle(EmbossedButtonStyle(buttonShape: EmbossedButtonShape.round))
                .foregroundColor(
                    index > rating ? offColor : onColor)
                .onChange(of: ratings) { _ in
                    convertRating()
                }
                .onAppear {
                    convertRating()
                }
            }
        }
        .font(.largeTitle)
    }
    
    func updateRating(index: Int) {
        rating = index
        let index = ratings.index(
            ratings.startIndex,
            offsetBy: exerciseIndex)
        ratings.replaceSubrange(index...index, with: String(rating))
    }
}

struct RatingView_Previews: PreviewProvider {
    @AppStorage("ratings") static var ratings: String?
    static var previews: some View {
        ratings = nil
        return RatingView(exerciseIndex: 0)
            .previewLayout(.sizeThatFits)
    }
}
