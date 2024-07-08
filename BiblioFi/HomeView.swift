//
//  HomeView.swift
//  BiblioFi
//
//  Created by Nikunj Tyagi on 05/07/24.
//

import SwiftUI

struct Book: Identifiable {
    var id = UUID()
    var title: String
    var author: String
    var image: String
}

struct HomeView: View {
    @State private var isScaled = false
    @State private var showInfoCards = false

    // Top picks Book array
    let books: [Book] = [
        Book(title: "Book Title 1", author: "Author 1", image: "Book"),
        Book(title: "Book Title 2", author: "Author 2", image: "book2"),
        Book(title: "Book Title 3", author: "Author 3", image: "book3"),
        Book(title: "Book Title 4", author: "Author 4", image: "book4"),
        Book(title: "Book Title 5", author: "Author 5", image: "book5")
    ]

    // Recommendation of book array
    let recommendations: [Book] = [
        Book(title: "R-Book 1", author: "Author A", image: "Book"),
        Book(title: "R-Book 2", author: "Author B", image: "book7"),
        Book(title: "R-Book 3", author: "Author C", image: "book8"),
        Book(title: "R-Book 4", author: "Author D", image: "book9")
    ]

    // Newspaper and magazine array
    let newspapersAndMagazines: [Book] = [
        Book(title: "Newspaper 1", author: "Publisher 1", image: "Book"),
        Book(title: "Magazine 1", author: "Publisher 2", image: "mag1"),
        Book(title: "Newspaper 2", author: "Publisher 3", image: "news2"),
        Book(title: "Magazine 2", author: "Publisher 4", image: "mag2"),
        Book(title: "Magazine 5 ", author: "Publisher 5", image: "mag2")
    ]

    var body: some View {
        
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    // Owl Image (Scaled)
                    Image("picture") // Replace with your actual image name
                        .resizable()
                        .scaledToFit()
                        .frame(width: isScaled ? 400 : 150, height: isScaled ? 300 : 100)
//                        .animation(.easeInOut(duration: 1), value: isScaled)
                        

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
                            ForEach(books) { book in
                                NavigationLink(destination: DetailView(book: book)) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color.white.opacity(0.3))
                                            .background(Blur(style: .systemMaterial))
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                            .shadow(radius: 3)
                                            .frame(width: 200, height: 300)

                                        VStack {
                                            Image(book.image)
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

                    Text("Recommendations")
                        .font(.custom("Avenir Next Bold", size: 20))
                        .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(recommendations) { book in
                                NavigationLink(destination: DetailView(book: book)) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.white.opacity(0.3))
                                            .background(Blur(style: .systemMaterial))
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                            .shadow(radius: 3)
                                            .frame(width: 150, height: 200)

                                        VStack {
                                            Image(book.image)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 90, height: 150)
                                            Text(book.title)
                                                .font(.caption)
                                                .foregroundColor(.black)
                                            Text(book.author)
                                                .font(.caption2)
                                                .foregroundColor(.gray)
                                        }
                                        .padding()
                                    }
                                    .frame(width: 150, height: 200)
                                    .padding(.horizontal, 4)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }

                    Text("Newspapers and Magazines")
                        .font(.custom("Avenir Next Bold", size: 20))
                        .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(newspapersAndMagazines) { item in
                                NavigationLink(destination: DetailView(book: item)) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.white.opacity(0.3))
                                            .background(Blur(style: .systemMaterial))
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                            .shadow(radius: 3)
                                            .frame(width: 150, height: 200)

                                        VStack {
                                            Image(item.image)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 90, height: 150)
                                            Text(item.title)
                                                .font(.caption)
                                                .foregroundColor(.black)
                                            Text(item.author)
                                                .font(.caption2)
                                                .foregroundColor(.gray)
                                        }
                                        .padding()
                                    }
                                    .frame(width: 150, height: 200)
                                    .padding(.horizontal, 4)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }

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
    var book: Book

    var body: some View {
        VStack {
            Image(book.image)
                .resizable()
                .scaledToFit()
                .frame(height: 300)
            Text(book.title)
                .font(.largeTitle)
                .padding()
            Text(book.author)
                .font(.title)
                .foregroundColor(.gray)
            Spacer()
        }
        .navigationBarTitle(book.title, displayMode: .inline)
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
