import SwiftUI

extension WelcomeView {
  static var images: some View {
    ZStack {
      Image("hands")
        .resizedToFill(width: 100, height: 100)
        .clipShape(Circle())
        .offset(x: -88, y: 30)
      Image("exercise")
        .resizedToFill(width: 40, height: 40)
        .clipShape(Circle())
        .offset(x: -54, y: -80)
      Image("head")
        .resizedToFill(width: 20, height: 20)
        .clipShape(Circle())
        .offset(x: -44, y: -40)
      Image("arm")
        .resizedToFill(width: 60, height: 60)
        .clipShape(Circle())
        .offset(x: -133, y: -60)
      Image("step-up")
        .resizedToFill(width: 180, height: 180)
        .clipShape(Circle())
        .offset(x: 74)
    }
    .frame(maxWidth: .infinity, maxHeight: 220)
    .shadow(color: Color("drop-shadow"), radius: 6, x: 5, y: 5)
    .padding(.top, 10)
    .padding(.leading, 20)
    .padding(.bottom, 10)
  }

  static var welcomeText: some View {
    return HStack(alignment: .bottom) {
      VStack(alignment: .leading) {
        Text("Get fit")
          .font(.largeTitle)
          .fontWeight(.black)
          .kerning(2)
        Text("by exercising at home")
          .font(.headline)
          .fontWeight(.medium)
          .kerning(2)
          .fixedSize(horizontal: false, vertical: true)
      }
    }
  }
}

struct WelcomeImages_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      WelcomeView.images
      WelcomeView.welcomeText
    }
  }
}
