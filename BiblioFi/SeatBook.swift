//
//  SeatBook.swift
//  BiblioFi
//
//  Created by Nikunj Tyagi on 12/07/24.
//

import SwiftUI

struct SeatBook: View {
    @State private var selectedDate = Date()
    @State private var selectedTime = "2 Hours"
    @State private var selectedPurpose = "Reading"
    @State private var showConfirmation = false

    let purposes = ["Reading", "Research", "Studying"]
    let timeOptions = ["2 Hours", "3 Hours", "4 Hours", "5 Hours"] // Adjust time options as needed

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Book a Seat in the Library")
                    .font(.largeTitle)
                    .bold()
                    .padding([.leading, .top])

                VStack(alignment: .leading, spacing: 10) {
                    Text("Select Date")
                        .font(.headline)

                    DatePicker(selection: $selectedDate, in: Date()..., displayedComponents: .date) {
                        Text("")
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Select Time Duration")
                        .font(.headline)

                    Picker("Select Time Duration", selection: $selectedTime) {
                        ForEach(timeOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Purpose of Visit")
                        .font(.headline)

                    Picker("Purpose of Visit", selection: $selectedPurpose) {
                        ForEach(purposes, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                }
                .padding(.horizontal)

                Button(action: {
                    showConfirmation = true
                }) {
                    Text("Book Seat")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#945200"))
                        .cornerRadius(8)
                        .padding(.horizontal)
                }

                if showConfirmation {
                    Text("Your seat has been booked successfully!")
                        .font(.headline)
                        .foregroundColor(.green)
                        .padding(.horizontal)
                }

                Spacer()
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "#ffffff"), Color(hex: "#f1d4cf")]),
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all))
            .navigationBarTitle("Seat Booking", displayMode: .inline)
        }
    }
}

struct SeatBook_Previews: PreviewProvider {
    static var previews: some View {
        SeatBook()
    }
}
