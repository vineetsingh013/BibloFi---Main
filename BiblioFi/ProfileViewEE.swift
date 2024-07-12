//
//  ProfileViewEE.swift
//  BiblioFi
//
//  Created by Nikunj Tyagi on 12/07/24.
//
import SwiftUI

struct ProfileViewEE: View {
    @State private var isLoggedIn = true // Example state to simulate login/logout
    @State private var showEditProfile = false 
    @State private var showFine = false

    var body: some View {
        NavigationView {
            VStack {
                // Profile Image and Name
                Image("profile_image") // Replace with your profile image asset name
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .shadow(radius: 5)
                    .padding(.top, 20)
                    .onTapGesture {
                        // Handle profile image tap if needed
                    }

                Text("John Doe")
                    .font(.title)
                    .padding(.bottom, 10)

                // Settings and Support Sections in a List
                List {
                    Section(header: Text("Profile").font(.headline)) {
                                        Button(action: {
                                            showEditProfile.toggle() // Show the edit profile sheet
                                        }) {
                                            HStack {
                                                Image(systemName: "person.circle")
                                                Text("Profile")
                                            }
                                        }
                                        .sheet(isPresented: $showEditProfile) {
                                            EditProfileView()
                                        }
                        NavigationLink(destination: Text("Wishlist")) {
                            HStack {
                                Image(systemName: "heart.circle")
                                Text("Wishlist")
                            }
                        }
                      
                        Button(action: {
                            showFine.toggle() // Show the edit profile sheet
                        }) {
                            HStack {
                                Image(systemName: "person.circle")
                                Text("Fine")
                            }
                        }
                        .sheet(isPresented: $showFine) {
                            FineDetail()
                        }
                        NavigationLink(destination: Text("Borrowing History")) {
                            HStack {
                                Image(systemName: "clock.circle")
                                Text("History")
                            }
                        }
                    }

                    Section(header: Text("Support").font(.headline)) {
                        NavigationLink(destination: Text("About Us")) {
                            HStack {
                                Image(systemName: "info.circle")
                                Text("About Us")
                            }
                        }
                        NavigationLink(destination: Text("FAQ")) {
                            HStack {
                                Image(systemName: "questionmark.circle")
                                Text("FAQ")
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())

                // Log Out Button
                Button(action: {
                    // Handle logout action
                }) {
                    Text("Log Out")
                        .font(.headline)
                        .foregroundColor(.red)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemBackground))
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                .padding(.vertical, 20)

                Spacer()
            }
            .navigationBarTitle("Profile", displayMode: .inline)
        }
    }
}

struct ProfileViewEE_Previews: PreviewProvider {
    static var previews: some View {
        ProfileViewEE()
    }
}
