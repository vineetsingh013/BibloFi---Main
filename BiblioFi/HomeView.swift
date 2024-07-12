import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import Firebase

struct HomeView: View {
    @State private var isScaled = false
    @State private var showInfoCards = false
    @State private var booksdetails: [Book] = []
    @State private var showSideMenu = false
    @State private var showLibraryView = false 
    @State private var showProfileView = false
    @State private var showScanner = false
    @State private var isSearching: Bool = false
    @State private var searchText: String = ""
    
    // State variable for presenting LibraryView

    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                HStack {
                    Image("Oreo") // Replace with your actual image name
                        .resizable()
                        .scaledToFit()
                        .frame(width: isScaled ? 400 : 150, height: isScaled ? 300 : 100)

                    Spacer()

                    NavigationLink(destination: ProfileViewEE(), isActive: $showProfileView) {
                                        Button(action: {
                                            showProfileView.toggle()
                                        }) {
                                            Image(systemName: "person.circle")
                                                .font(.title)
                                                .foregroundColor(.black)
                                                .padding()
                                                .frame(width: 40, height: 40)
                                        }
                                    }
                    .padding(.top, 20)
                    .padding(.trailing)
                }

                Text("Welcome to BiblioFi!")
                    .font(.title)
                    .padding(.horizontal)

                HStack {
                    HStack {
                                        Image(systemName: "magnifyingglass")
                                            .foregroundColor(.gray)
                                        TextField("Search by author, title, genre", text: $searchText)
                                            .foregroundColor(.black)
                                            .onTapGesture {
                                                isSearching = true // Set isSearching to true when the text field is tapped
                                            }
                                    }
                                    .padding()
                                    .background(Color(.white))
                                    .cornerRadius(8)
                                    
                                    // NavigationLink to LibraryView
                                    NavigationLink(
                                        destination: LibraryView(), // Destination view
                                        isActive: $isSearching, // Bind isActive to isSearching state
                                        label: {
                                            EmptyView() // Empty view to trigger navigation programmatically
                                        }
                                    )
                                    .hidden() 
                    
                    Button(action: {
                                               showScanner.toggle() // Toggle the state to show the scanner view
                                           }) {
                                               ZStack {
                                                   RoundedRectangle(cornerRadius: 10)
                                                       .fill(Color.white)
                                                       .frame(width: 50, height: 50)
                                                       .shadow(radius: 3)

                                                   Image(systemName: "barcode.viewfinder")
                                                       .font(.title2)
                                                       .foregroundColor(.gray)
                                               }
                                           }
                                           .padding()
                                           .sheet(isPresented: $showScanner) {
                                               ScannerView() // Present ScannerView when showScanner is true
                                           }
                                       }
                

                if showInfoCards {
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

                Text("Trending Books")
                    .font(.custom("Avenir Next Demi Bold", size: 30))
                    .padding(.horizontal)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(booksdetails) { book in
                            NavigationLink(destination: DetailView(book: book)) {
                                BookCard(book: book)
                            }
                            .frame(width: 280, height: 280)
                            .padding(.horizontal, 4)
                        }
                    }
                    .padding(.horizontal)
                }

                Text("Recommendations")
                    .font(.custom("Avenir Next Demi Bold", size: 25))
                    .padding(.horizontal)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(booksdetails) { book in
                            NavigationLink(destination: DetailView(book: book)) {
                                BookCardSmall(book: book)
                            }
                            .frame(width: 180, height: 210)
                            .padding(.horizontal, 4)
                        }
                    }
                    .padding(.horizontal)
                }

                Text("Newspaper")
                    .font(.custom("Avenir Next Demi Bold", size: 25))
                    .padding(.horizontal)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(booksdetails) { book in
                            NavigationLink(destination: DetailView(book: book)) {
                                BookCardSmall(book: book)
                            }
                            .frame(width: 180, height: 210)
                            .padding(.horizontal, 4)
                        }
                    }
                    .padding(.horizontal)
                }

                Text("Membership")
                    .font(.custom("Avenir Next Demi Bold", size: 30))
                    .padding(.horizontal)

                MembershipCard()
                    .padding(.horizontal)
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(hex: "#ffffff"), Color(hex: "#f1d4cf")]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
        )
        .navigationBarHidden(true)
        .onAppear {
            fetchBooks()
        }
    }

    func fetchBooks() {
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
                    let imageLinksData = data["imageLinks"] as? [String: String]
                    let imageLinks = imageLinksData.flatMap { ImageLinksCustom(thumbnail: $0["thumbnail"]) }

                    return Book(title: title, author: author, description: description, imageLinks: imageLinks)
                } ?? []
                print("Fetched \(booksdetails.count) books")
            }
        }
    }
}

struct BookCard: View {
    let book: Book

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.3))
                .background(Blur(style: .systemMaterial))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(radius: 3)

            VStack {
                if let urlString = book.imageLinks?.thumbnail, let url = URL(string: urlString) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 180)
                    } placeholder: {
                        ProgressView()
                    }
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }

                Text(book.title)
                    .font(.headline)
                    .foregroundColor(.black)

                Text(book.author)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding()
        }
    }
}

struct BookCardSmall: View {
    let book: Book

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white.opacity(0.3))
                .background(Blur(style: .systemMaterial))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(radius: 3)

            VStack {
                if let urlString = book.imageLinks?.thumbnail, let url = URL(string: urlString) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 120)
                    } placeholder: {
                        ProgressView()
                    }
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }

                Text(book.title)
                    .font(.headline)
                    .foregroundColor(.black)

                Text(book.author)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding()
        }
    }
}

struct MembershipCard: View {
    var body: some View {
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
    }
}

struct InfoCard: View {
    let title: String
    let description: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.3))
                .background(Blur(style: .systemMaterial))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(radius: 3)

            VStack {
                Text(title)
                    .font(.title)
                    .foregroundColor(.black)
                    .padding()

                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .padding()
        }
    }
}

struct Book: Identifiable {
    let id = UUID()
    let title: String
    let author: String
    let description: String
    let imageLinks: ImageLinksCustom?
}

struct ImageLinksCustom {
    let thumbnail: String?
}



 struct DetailView: View {
     @State private var showConfirmationSheet = false
     @State private var statusMessage: String = ""
     @State private var availableCopies: Int = 0
     var book: Book

     var body: some View {
         VStack {
             ScrollView {
                 // Book image and details
                 HStack(alignment: .top) {
                     if let urlString = book.imageLinks?.thumbnail, let url = URL(string: urlString) {
                         AsyncImage(url: url) { image in
                             image
                                 .resizable()
                                 .scaledToFit()
                                 .frame(width: 150, height: 180)
                         } placeholder: {
                             ProgressView()
                         }
                     } else {
                         Image(systemName: "photo")
                             .resizable()
                             .scaledToFit()
                             .frame(width: 50, height: 50)
                     }

                     VStack(alignment: .leading, spacing: 7) {
                         Text(book.title)
                             .font(.custom("AvenirNext-Bold", size: 30))
                             .fontWeight(.bold)

                         Text(book.author)
                             .font(.custom("AvenirNext-Regular", size: 15))
                             .foregroundColor(.gray)

                         HStack {
                             ForEach(0..<5) { index in
                                 Image(systemName: index < 4 ? "star.fill" : "star")
                                     .foregroundColor(.yellow)
                             }
                         }
                         Text(availableCopies > 0 ? "Available" : "Out of Stock")
                             .font(.custom("AvenirNext-Regular", size: 15))
                             .foregroundColor(availableCopies > 0 ? .green : .red)
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
                         Text(availableCopies > 0 ? "Available" : "Out of Stock")
                             .font(.custom("AvenirNext-Regular", size: 16))
                     }

                     HStack {
                         Text("Number of copies")
                             .font(.custom("AvenirNext-Bold", size: 16))
                         Text("\(availableCopies) available")
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
                 Button(action: {
                     showConfirmationSheet = true
                 }) {
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
                 .sheet(isPresented: $showConfirmationSheet) {
                     ConfirmationSheet(isPresented: $showConfirmationSheet, book: book, statusMessage: $statusMessage)
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
         }
         .background(Color(hex: "#F9EDEA"))
         .onAppear {
             fetchAvailableCopies()
         }
     }

     func fetchAvailableCopies() {
         let db = Firestore.firestore()
         db.collection("Books").document(book.title).getDocument { snapshot, error in
             if let error = error {
                 print("Error fetching document: \(error)")
             } else if let snapshot = snapshot, let data = snapshot.data() {
                 availableCopies = data["availableCopies"] as? Int ?? 0
             }
         }
     }
 }

struct ConfirmationSheet: View {
    @Binding var isPresented: Bool
    var book: Book
    @Binding var statusMessage: String
    @State private var selectedDuration = 1

    var body: some View {
        VStack(spacing: 20) {
            Text("Select Duration")
                .font(.headline)
            Picker("Duration", selection: $selectedDuration) {
                ForEach(1...7, id: \.self) { day in
                    Text("\(day) \(day == 1 ? "day" : "days")")
                }
            }
            .pickerStyle(WheelPickerStyle())

            Button(action: {
                // Handle checkout logic
                isPresented = false
            }) {
                Text("Confirm")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            Button(action: {
                isPresented = false
            }) {
                Text("Cancel")
                    .font(.headline)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
