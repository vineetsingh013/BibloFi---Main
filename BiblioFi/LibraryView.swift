//
//  LibraryView.swift
//  BiblioFi
//
//  Created by Nikunj Tyagi on 05/07/24.
//
import SwiftUI

// MARK: - Data Models

struct Book2: Identifiable {
    var id = UUID()
    var title: String
    var author: String
    var image: String
}

struct Author: Identifiable {
    var id = UUID()
    var name: String
    var image: String
}

struct Audiobook: Identifiable {
    var id = UUID()
    var title: String
    var coverImage: String
    var rating: Double
}

// MARK: - Sample Data Arrays

let recentSearches: [String] = ["Search 1", "Search 2", "Search 3", "Search 4", "Search 5"]

let topCategories: [Book2] = [
    Book2(title: "Book 1", author: "Author 1", image: "Book"),
    Book2(title: "Book 2", author: "Author 2", image: "Book"),
    Book2(title: "Book 3", author: "Author 3", image: "Book"),
    Book2(title: "Book 4", author: "Author 4", image: "Book"),
    Book2(title: "Book 5", author: "Author 5", image: "Book")
]

let topAuthors: [Author] = [
    Author(name: "Author A", image: "author1"),
    Author(name: "Author B", image: "author2"),
    Author(name: "Author C", image: "author3"),
    Author(name: "Author D", image: "author4"),
    Author(name: "Author E", image: "author5")
]

let audiobooks: [Audiobook] = [
    Audiobook(title: "Audiobook 1", coverImage: "audiobook1", rating: 4.5),
    Audiobook(title: "Audiobook 2", coverImage: "audiobook2", rating: 4.2),
    Audiobook(title: "Audiobook 3", coverImage: "audiobook3", rating: 4.7)
]

// MARK: - Library View

struct LibraryView: View {
    var body: some View {
        
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(hex: "#ffffff"), Color(hex: "#f1d4cf")]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all) // Apply gradient background to whole screen
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        SearchBar()
                            .padding(.horizontal)
                            .padding(.top, 20)

                        RecentSearchesSection(recentSearches: recentSearches)
                            .padding(.horizontal)

                        TopCategoriesSection(books: topCategories)
                            .padding(.horizontal)

                        TopAuthorsSection(authors: topAuthors)
                            .padding(.horizontal)

                        AudiobookSection(audiobooks: audiobooks)
                            .padding(.horizontal)

                        Spacer()
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }


// MARK: - Custom Views

struct SearchBar: View {
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.leading, 8) // Adjust left padding for space
            
            TextField("Search by title, topics and author", text: .constant(""))
                .padding(.vertical, 12) // Increase vertical padding
                .padding(.horizontal, 12) // Increase horizontal padding
                .font(.body) // Adjust font size
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .background(Color.white.opacity(0.2)) // Adjust background opacity
            
            NavigationLink(destination: Text("Wishlist")) {
                Image(systemName: "heart")
                    .foregroundColor(.black)
                    .font(.system(size: 24)) // Increase the size of the heart icon
            }
            .padding(.trailing, 8) // Adjust right padding for space
        }
        .padding(.horizontal, 20)
    }
}

struct RecentSearchesSection: View {
    var recentSearches: [String]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Recent Searches")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 20)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(recentSearches, id: \.self) { search in
                        RecentSearchCard(search: search)
                    }
                }
            }
        }
    }
}

struct RecentSearchCard: View {
    var search: String

    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white.opacity(0.3))
                .frame(width: 110, height: 50)
                .overlay(
                    HStack {
                        Text(search)
                            .foregroundColor(.black)
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                    .padding(8)
                )
        }
    }
}

struct TopCategoriesSection: View {
    var books: [Book2]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Top Categories")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 20)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.flexible())], spacing: 20) {
                    ForEach(books) { book in
                        CategoryCard(book: book)
                    }
                }
                .padding(.vertical, 10)
            }
        }
    }
}

struct CategoryCard: View {
    var book: Book2

    var body: some View {
        VStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white.opacity(0.9))
                .frame(width: 130, height: 150)
                .overlay(
                    VStack(alignment: .leading, spacing: 4) {
                        Image(book.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        Text(book.title)
                            .font(.headline)
                            .foregroundColor(.black)
                        Text(book.author)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                )
        }
    }
}

struct TopAuthorsSection: View {
    var authors: [Author]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Top Authors")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 20)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.flexible())], spacing: 20) {
                    ForEach(authors) { author in
                        AuthorCard(author: author)
                    }
                }
                .padding(.vertical, 10)
            }
        }
    }
}

struct AuthorCard: View {
    var author: Author

    var body: some View {
        VStack {
            Image(author.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.blue, lineWidth: 2)
                )
            Text(author.name)
                .font(.headline)
                .foregroundColor(.black)
                .padding(.top, 8)
        }
    }
}

struct AudiobookSection: View {
    var audiobooks: [Audiobook]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Audiobooks")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 20)

            ForEach(audiobooks) { audiobook in
                AudiobookCard(audiobook: audiobook)
                    .padding(.bottom, 20)
            }
        }
    }
}

struct AudiobookCard: View {
    var audiobook: Audiobook

    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.8))
                .frame(height: 120)
                .overlay(
                    HStack(spacing: 15) {
                        Image(audiobook.coverImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        VStack(alignment: .leading) {
                            Text(audiobook.title)
                                .font(.headline)
                                .foregroundColor(.black)
                            Text("Rating: \(audiobook.rating)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 8)
                    }
                    .padding()
                )
        }
    }
}

// MARK: - Glass Morphism Modifier

struct GlassMorphism: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.1), Color.gray.opacity(0.1)]), startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 5, y: 5)
            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
    }
}

// MARK: - Preview

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}



