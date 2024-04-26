//
//  SettingsPINView.swift
//  TVMaze
//
//  Created by Felipe Mendes on 28/03/24.
//

import SwiftUI

struct SettingsPINView: View {
    @Binding var isPresented: Bool
    @State private var pin: String = ""
    var setPINAction: (String) -> Void

    var body: some View {
        NavigationView {
            Form {
                SecureField("Enter PIN", text: $pin)
                    .padding()
                    .keyboardType(.numberPad)
                    .listRowBackground(Color.gray.opacity(0.1))

                HStack {
                    Button("Cancel") {
                        isPresented = false
                    }
                    .foregroundColor(.red)

                    Spacer()

                    Button("Set") {
                        setPINAction(pin)
                        isPresented = false
                    }
                    .disabled(pin.isEmpty)
                }
                .listRowBackground(Color.gray.opacity(0.1))
                .padding()
            }
            .scrollContentBackground(.hidden)
            .background(Color.theme.background)
            .navigationBarTitle(Text("Set PIN"))
        }
    }
}
