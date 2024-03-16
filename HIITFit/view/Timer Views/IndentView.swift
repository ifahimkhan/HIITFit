import SwiftUI

struct IndentView<Content: View>: View {
  var content: Content

  init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }

  var body: some View {
    ZStack {
      content
        .background(
          GeometryReader { geometry in
            Circle()
              .inset(by: -4)
              .stroke(Color("background"), lineWidth: 8)
              .shadow(color: Color("drop-shadow").opacity(0.5), radius: 6, x: 6, y: 6)
              .shadow(color: Color("drop-highlight"), radius: 6, x: -6, y: -6)
              .foregroundColor(Color("background"))
              .clipShape(Circle().inset(by: -1))
              .resized(size: geometry.size)
          }
        )
    }
  }
}

private extension View {
  func resized(size: CGSize) -> some View {
    self
      .frame(
        width: max(size.width, size.height),
        height: max(size.width, size.height))
      .offset(y: -max(size.width, size.height) / 2
        + min(size.width, size.height) / 2)
  }
}

struct IndentView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      IndentView {
        Text("5")
          .font(.system(size: 90, design: .rounded))
          .frame(width: 120, height: 120)
      }
      .padding(.bottom, 50)
      IndentView {
        Image(systemName: "hare.fill")
          .font(.largeTitle)
          .foregroundColor(.purple)
          .padding(20)
      }
    }
  }
}
