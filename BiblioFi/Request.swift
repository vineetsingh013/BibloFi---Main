//
//  SwiftUIView.swift
//  BiblioFi
//
//  Created by Ayushman Singh Rajawat on 09/07/24.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
struct Request: Identifiable, Codable {
    @DocumentID var id: String?
    var memberId: String
    var memberName: String
    var bookId: String
    var bookName: String
    var status: String
    var timestamp: Timestamp?
}
