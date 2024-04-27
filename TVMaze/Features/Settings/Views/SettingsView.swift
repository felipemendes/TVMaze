//
//  SettingsView.swift
//  TVMaze
//
//  Created by Felipe Mendes on 28/03/24.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel
    @State private var showingPINModal = false

    var body: some View {
        Form {
            Section(header: Text("Security")) {
                Toggle(isOn: $viewModel.isBiometricsEnabled) {
                    Text("Enable Biometrics")
                }
                .onChange(of: viewModel.isBiometricsEnabled, initial: false) { _, newValue in
                    viewModel.toggleBiometricsEnabled(newValue)
                }

                Button(viewModel.isPINSet ? "Change PIN" : "Set PIN") {
                    self.showingPINModal = true
                }

                if viewModel.isPINSet {
                    Button("Remove PIN") {
                        viewModel.removePIN()
                    }
                }

                if viewModel.isBiometricsEnabled && !viewModel.isPINSet {
                    Text("Biometrics enabled without PIN setup. Consider setting up a PIN as a fallback.")
                        .foregroundColor(.orange)
                }
            }
            .listRowBackground(Color.gray.opacity(0.1))
            .alert("Important Messsage", isPresented: $viewModel.showPINAlert) {
                Button("Dismiss", role: .cancel) { }
                Button("Try Again") {
                    self.showingPINModal = true
                }
            } message: {
                if let pinSettingError = viewModel.pinSettingError, !pinSettingError.isEmpty {
                    Text(pinSettingError)
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.theme.background)
        .navigationBarTitle("Settings")
        .sheet(isPresented: $showingPINModal) {
            SettingsPINView(isPresented: $showingPINModal) { newPIN in
                viewModel.setPIN(newPIN)
            }
        }
    }
}
