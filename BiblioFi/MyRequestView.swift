//
//  MyRequestView.swift
//  BiblioFi
//
//  Created by Ayushman Singh Rajawat on 09/07/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase

struct MyRequestView: View {
    @State private var requests = [Request]()
    @State private var memberId: String = Auth.auth().currentUser?.uid ?? ""
    
    var body: some View {
        NavigationView {
            List(requests) { request in
                VStack(alignment: .leading) {
                    Text("Book ID: \(request.bookId)")
                    Text("Book Name: \(request.bookName)")
                    Text("Status: \(request.status)")
                        .foregroundColor(statusColor(request.status))
                }
            }
            .onAppear(perform: fetchMyRequests)
            .navigationBarTitle("My Requests", displayMode: .inline)
        }
    }

    func fetchMyRequests() {
        print("fetchrequestfunctionsiscalled")
        let db = Firestore.firestore()
        db.collection("requests")
            .whereField("memberId", isEqualTo: memberId)
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error getting documents: \(error.localizedDescription)")
                } else {
                    self.requests = querySnapshot?.documents.compactMap { document -> Request? in
                        try? document.data(as: Request.self)
                    } ?? []
                }
            }
    }


    func statusColor(_ status: String) -> Color {
        switch status {
        case "pending":
            return .orange
        case "approved":
            return .green
        case "rejected":
            return .red
        default:
            return .black
        }
    }
}
