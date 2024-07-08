//
//  ResetPasswordView.swift
//  BiblioFi
//
//  Created by Vineet Chaudhary on 07/07/24.
//

import SwiftUI
import FirebaseAuth

struct ResetPasswordView: View {
    @State private var email: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var shouldNavigateToLogin: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Reset Password")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 100)
            
            Text("Enter your email address to reset your password")
                .font(.subheadline)
                .padding(.bottom, 40)
            
            TextField("Email", text: $email)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .padding(.horizontal, 20)
            
            Button(action: {
                // Handle reset password action
                resetPassword()
            }) {
                Text("Reset Password")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "#945200"))
                    .cornerRadius(8)
            }
            .padding(.horizontal, 20)
            .disabled(email.isEmpty)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Reset Password"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            
            Spacer()
        }
        .padding()
        .background(Color(hex: "#f9edea").edgesIgnoringSafeArea(.all))
        .navigationBarTitle("Forgot Password", displayMode: .inline)
    }
    
    private func resetPassword() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                self.alertMessage = error.localizedDescription
            } else {
                self.alertMessage = "A password reset email has been sent to \(self.email)."
                self.shouldNavigateToLogin = true
            }
            self.showAlert = true
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
