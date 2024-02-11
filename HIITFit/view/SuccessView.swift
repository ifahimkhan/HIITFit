import SwiftUI

struct SuccessView: View {
    let multiline = """
                Good job completing all four exercises!
                Remember tomorrow's another day.
                So eat well and get some rest.
                """
    var body: some View {

        ZStack() {

            VStack{
                Spacer()
                Button("continue"){}.padding(.bottom)
            }

            VStack{
                Image(systemName: "hand.raised.fill")
                    .resizedToFill(width: 75, height: 75)
                    .foregroundColor(Color.purple)
                    .padding()
                Text("High Five!")
                    .font(.title)
                    .fontWeight(.bold)
                Text(multiline)
                    .font(.headline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                


            }
        }
    }
}





struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView()
    }
}
