//
//  ContentView.swift
//  BiblioFi
//
//  Created by Vineet Chaudhary on 03/07/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                Text("Welcome")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                Text("Please login or create an account to continue")
                    .font(.subheadline)
                    .padding(.bottom, 40)
                Image("Boarding")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                    .padding(.top, 100)
                
                NavigationLink(destination: SignUpView().navigationBarBackButtonHidden(true)) {
                    Text("Create Account")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#945200"))
                        .cornerRadius(8)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                NavigationLink(destination: LoginPage().navigationBarBackButtonHidden(true)) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#945200"))
                        .cornerRadius(8)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                Spacer()
            }
            .padding()
        }
    }
}



//extension Color {
//    init(hex: String) {
//        let scanner = Scanner(string: hex)
//        _ = scanner.scanString("#")
//        
//        var rgbValue: UInt64 = 0
//        scanner.scanHexInt64(&rgbValue)
//        
//        let red = Double((rgbValue & 0xff0000) >> 16) / 255.0
//        let green = Double((rgbValue & 0x00ff00) >> 8) / 255.0
//        let blue = Double(rgbValue & 0x0000ff) / 255.0
//        
//        self.init(red: red, green: green, blue: blue)
//    }
//}

#Preview {
    ContentView()
}
