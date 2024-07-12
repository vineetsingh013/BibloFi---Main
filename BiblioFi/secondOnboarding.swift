
import SwiftUI

struct secondOnboarding: View {
    @AppStorage("onboarding") var isOnboardingViewActive = false
    @State private var isAnimating = false
    
    
    var body: some View {
        VStack(spacing: 20) {
            
            // MARK: - Header
            Spacer()
            ZStack {
                CircleGroupView(shapeColor: Color(hex: "f1d4cf"), shapeOpacity: 0.2)
                Image("character-2")
                    .resizable()
                    .frame(width: 250, height: 250)
                    .scaledToFit()
                .padding()
                .offset(y: isAnimating ? 35 : -35)
                .animation(Animation.easeOut(duration: 4).repeatForever(), value: isAnimating
                )
            }
            
            // MARK: - Center
            Text("for all ")
                .font(.title3)
                .fontWeight(.black)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            // MARK: - Footer
            Spacer()
            
            Button(action: {
                withAnimation {
                   
                    isOnboardingViewActive = true
                }
            }) {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                
//                Text("Start")
//                    .font(.system(.title3, design: .rounded))
//                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .background(Color("Brown"))
            
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isAnimating = true
            }
        }
    }
}

struct HomeView_Previews3: PreviewProvider {
    static var previews: some View {
        secondOnboarding()
    }
}
