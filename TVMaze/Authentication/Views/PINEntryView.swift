//
//  PINEntryView.swift
//  TVMaze
//
//  Created by Felipe Mendes on 28/03/24.
//

import SwiftUI

struct PINEntryView: View {
    @Binding var isAuthenticated: Bool
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: AuthenticationViewModel
    @FocusState private var isSecureFieldFocused: Bool

    @State private var pin: String = ""
    @State private var showError: Bool = false

    var body: some View {
        VStack {
            Text("Enter PIN")
                .font(.title2)
                .padding()

            SecureField("PIN", text: $pin)
                .keyboardType(.numberPad)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .focused($isSecureFieldFocused)

            if showError {
                Text("Incorrect PIN. Please try again.")
                    .foregroundColor(.red)
            }

            Button("Authenticate") {
                viewModel.verifyPIN(pin) { success in
                    if success {
                        isAuthenticated = true
                        isPresented = false
                    } else {
                        showError = true
                        pin = ""
                    }
                }
            }
            .padding()
            .disabled(pin.isEmpty)
        }
        .padding()
        .onAppear {
            DispatchQueue.main.async {
                self.isSecureFieldFocused = true
            }
        }
    }
}
