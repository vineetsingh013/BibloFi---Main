//
//  ContentView.swift
//  BiblioFi
//
//  Created by Nikunj Tyagi on 10/07/24.
//

import SwiftUI

//struct ContentView: View {
//    var body: some View {
//        OnboardingView()
//    }
//}
//
//#Preview {
//    ContentView()
//}

struct ContentView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    var body: some View {
        ZStack {
            Button(action: {
                           // Handle restart action
                           // Perform segue to next view controller
                           NotificationCenter.default.post(name: NSNotification.Name("RestartSegue"), object: nil)
                       }) {
//                           Text("Start")
                       }
           if isOnboardingViewActive {
                OnboardingView()
            } else {
              LoginPage()

           }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
