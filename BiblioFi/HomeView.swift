////
////  HomeView.swift
////  BiblioFi
////
////  Created by Nikunj Tyagi on 05/07/24.
////
import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import Firebase
//


struct HomeView: View {
    @State private var isScaled = false
    @State private var showInfoCards = false
    @State private var books1: [[String: Any]] = [[:]]
    @State private var image1: UIImage?
    @State private var booksdetails: [Book] = []
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                // Owl Image (Scaled)
                Image("picture") // Replace with your actual image name
                    .resizable()
                    .scaledToFit()
                    .frame(width: isScaled ? 400 : 150, height: isScaled ? 300 : 100)
                
                if showInfoCards {
                    // Info Cards Section
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            InfoCard(title: "About BiblioFi", description: "BiblioFi is your go-to library management app.")
                            InfoCard(title: "Features", description: "Browse trending books, recommendations, and more.")
                            InfoCard(title: "Membership", description: "Become a member to unlock exclusive content.")
                        }
                        .padding(.horizontal)
                    }
                    .transition(.scale)
                }
                
                Text("Welcome")
                    .font(.custom("Avenir Next Bold", size: 35))
                    .padding(.horizontal)
                
                Text("Trending Books")
                    .font(.custom("Avenir Next Bold", size: 20))
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(booksdetails) { book in
                            NavigationLink(destination: DetailView(book: book)) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.white.opacity(0.3))
                                        .background(Blur(style: .systemMaterial))
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .shadow(radius: 3)
                                        .frame(width: 200, height: 300)
                                    
                                    VStack {
                                        Image("Book")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 150, height: 180)
                                        Text(book.title)
                                            .font(.headline)
                                            .foregroundColor(.black)
                                        Text(book.author)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    .padding()
                                }
                                .frame(width: 200, height: 300)
                                .padding(.horizontal, 4)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                    .onAppear {
                        fetchCourses()
                    }
//                }
//                
                Text("Membership")
                    .font(.custom("Avenir Next Bold", size: 20))
                    .padding(.horizontal)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.3))
                        .background(Blur(style: .systemMaterial))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .shadow(radius: 3)
                        .padding()
                    
                    VStack {
                        Text("Become a Member")
                            .font(.title)
                            .foregroundColor(.black)
                            .padding()
                        Text("Join our library to get exclusive access to more content and features.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding()
                        Button(action: {
                            // Action for membership button
                        }) {
                            Text("Join Now")
                                .font(.headline)
                                .padding()
                                .background(Color(hex: "#8B551B"))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .padding()
                        }
                    }
                    .padding()
                }
                .padding(.horizontal)
            }
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "#ffffff"), Color(hex: "#f1d4cf")]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all))
        .navigationBarHidden(true)
    }

    func fetchCourses() {
        let db = Firestore.firestore()
        db.collection("Books").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching documents: \(error)")
            } else {
                booksdetails = snapshot?.documents.compactMap { doc in
                    let data = doc.data()
                    let author = (data["authors"] as? [String])?.first ?? "Unknown Author"
                    let title = data["title"] as? String ?? "No Title"
                    let description = data["description"] as? String ?? "No Description"
//                    let image = data["image"] as? String ?? "placeholder"
                    return Book(title: title, author: author, description: description)
                } ?? []
            }
            //print(booksdetails)
        }
    }


    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Failed to load image from \(url): \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            DispatchQueue.main.async {
                print("join")
                self.image1 = UIImage(data: data)!
            }
        }.resume()
    }

}
struct Book: Identifiable {
    var id = UUID()
    var title: String
    var author: String
    var description: String // Added description field
//    var image: String
}


struct InfoCard: View {
    var title: String
    var description: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.8))
                .frame(width: 300, height: 200)
                .shadow(radius: 3)
            VStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.bottom, 5)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            .padding()
        }
        .padding(.horizontal, 10)
    }
}

struct DetailView: View {
    //@State private var bookId: String = ""
    @State private var memberId: String = Auth.auth().currentUser?.uid ?? ""
    @State private var statusMessage: String = ""
    var book: Book
    var body: some View {
        VStack {
            ScrollView {
                
                // Book image and details
                HStack(alignment: .top) {
                    Image("Book") // Replace with the actual image name
                        .resizable()
                        .frame(width: 120, height: 180)
                        .cornerRadius(8)
                    
                    VStack(alignment: .leading, spacing: 7) {
                        Text(book.title)
                            .font(.custom("AvenirNext-Bold", size: 30))
                            .fontWeight(.bold)
                        
                        Text(book.author)
                            .font(.custom("AvenirNext-Regular", size: 15))                            .foregroundColor(.gray)
                        
                        HStack {
                            ForEach(0..<5) { index in
                                Image(systemName: index < 4 ? "star.fill" : "star")
                                    .foregroundColor(.yellow)
                            }
                        }
                        Text(true ? "Available" : "Out of Stock")
                            .font(.custom("AvenirNext-Regular", size: 15))
                            .foregroundColor(true ? .green : .red)
                    }
                    Spacer()
                    
                    // Heart button
                    Button(action: {
                        // Action for the heart button
                    }) {
                        Image(systemName: "heart")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.black)
                    }
                }
                .padding()
                Divider()
                
                // Book information
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Title: ")
                            .font(.custom("AvenirNext-Bold", size: 16))
                        Text(book.title)
                            .font(.custom("AvenirNext-Regular", size: 16))
                    }
                    
                    HStack {
                        Text("Author: ")
                            .font(.custom("AvenirNext-Bold", size: 16))
                        Text(book.author)
                            .font(.custom("AvenirNext-Regular", size: 16))
                    }
                    
                    HStack {
                        Text("Status: ")
                            .font(.custom("AvenirNext-Bold", size: 16))
                        Text("Available")
                            .font(.custom("AvenirNext-Regular", size: 16))
                    }
                    
                    HStack {
                        Text("Number of Copies: ")
                            .font(.custom("AvenirNext-Bold", size: 16))
                        Text("3 available")
                            .font(.custom("AvenirNext-Regular", size: 16))
                    }
                    
                    Text("Description: ")
                        .font(.custom("AvenirNext-Bold", size: 16))
                        .padding(.top, 1)
                    
                    Text(book.description)
                        .font(.custom("AvenirNext-Regular", size: 16))
                }
                .padding()
                
                
            }
            
            
            // Checkout and Add to Cart buttons
            Divider()
            HStack {
                
                Button(action: sendIssueRequest
                    //                        showDurationPicker = true
                    // Action for the Checkout button
                )
                {
                    HStack {
                        Image(systemName: "cart")
                        Text("Checkout")
                            .font(.custom("AvenirNext-Bold", size: 18))
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "#945200"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                
                
                Button(action: {
                    // Action for the Add to Cart button
                }) {
                    HStack {
                        Image(systemName: "bag")
                        Text("Add to Cart")
                            .font(.custom("AvenirNext-Bold", size: 18))
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "#945200"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
            .padding()
            //                .sheet(isPresented: $showDurationPicker) {
            //                                DurationPickerView(isPresented: $showDurationPicker)
            //                            }
        }
        .background(Color(hex: "#F9EDEA"))
        .navigationBarHidden(true)
    }
    func sendIssueRequest() {
        print("function is called")
//        guard !bookId.isEmpty else {
//            statusMessage = "Please fill in all fields"
//            return
//        }
        
        guard let user = Auth.auth().currentUser else {
            statusMessage = "User not authenticated"
            print(statusMessage)
            return
        }

        print(user)
        let memberId = user.uid
        let memberName = user.displayName ?? "not found"
        print(memberName)
        let bookName = book.title
        let memberEmail = user.email ?? "unknown@example.com"
        print(memberId)
        let db = Firestore.firestore()
        let request = [
            "memberId": memberId,
            "memberName": memberName, // Include memberEmail
            "bookId": book.id.uuidString,
            "bookName": bookName,
            "status": "pending",
            "timestamp": FieldValue.serverTimestamp()
        ] as [String : Any]
        
        db.collection("requests").addDocument(data: request) { error in
            if let error = error {
                statusMessage = "Error: \(error.localizedDescription)"
            } else {
                statusMessage = "Request Sent"
            }
        }
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

// Helper for Blur effect
struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
