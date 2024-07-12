//
//  EditProfileView.swift
//  BiblioFi
//
//  Created by Nikunj Tyagi on 12/07/24.
//
import SwiftUI

struct EditProfileView: View {
    @State private var fullName: String = "John Doe"
    @State private var phoneNumber: String = "123-456-7890"
    @State private var showConfirmation = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("Full Name", text: $fullName)
                    TextField("Phone Number", text: $phoneNumber)
                }
            }

            Button(action: {
                // Save changes
                print("Profile updated: \(fullName), \(phoneNumber)")
                showConfirmation = true
            }) {
                Text("Save Changes")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding()
            }
            .alert(isPresented: $showConfirmation) {
                Alert(
                    title: Text("Profile Updated"),
                    message: Text("Your profile has been successfully updated."),
                    dismissButton: .default(Text("OK")) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                )
            }
            Spacer()
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}


