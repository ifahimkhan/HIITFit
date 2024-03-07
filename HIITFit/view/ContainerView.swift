import SwiftUI

struct ContainerView<Content:View>: View {
    var content:Content
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(Color("background"))
            VStack{
                Spacer()
                Rectangle()
                    .frame(height: 25.0)
                    .foregroundColor(Color("background"))
            }
            content
        }
    }

}

struct Container_Previews: PreviewProvider{
    static var previews: some View{
        ContainerView{
            VStack{
                RaisedButton(buttonText: "Hello World", action: {})
                    .padding(50)
                Button("Tap Me"){}
                    .buttonStyle(EmbossedButtonStyle())
            }
        }
        .padding(50)
        .previewLayout(.sizeThatFits)
    }
}


