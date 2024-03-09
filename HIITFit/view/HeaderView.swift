import SwiftUI

struct HeaderView: View {
    @Binding var selectedTab: Int
    
    let titleText: String
    var body: some View {
        VStack {
            Text(titleText)
                .foregroundColor(.white)
                .fontWeight(.black)
                .font(.largeTitle)
            HStack{
                ForEach(Exercise.exercises.indices, id:\.self){ index in
                    let fill = index == selectedTab
                    ZStack{
                        Circle().frame(width: 32,height: 32).opacity(fill ? 0.5 : 0.0)
                            .foregroundColor(.white)
                        Circle()
                            .frame(width: 16,height: 16).foregroundColor(.white)

                    }.onTapGesture {
                        selectedTab = index
                    }
                }
            }.font(.title2)
        }
    }
}
struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(selectedTab : .constant(0),titleText: "Squat").previewLayout(.sizeThatFits)
    }
}

