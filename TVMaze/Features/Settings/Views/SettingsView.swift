//
//  SettingsView.swift
//  TVMaze
//
//  Created by Felipe Mendes on 28/03/24.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel
    @State private var showingPINAlert = false
    @State private var pinInput = ""
    @State private var alertMessage = ""
    @State private var showingAlertMessage = false
    @State private var showingPINModal = false

    var body: some View {
        Form {
            Section(header: Text("Security")) {
                Toggle(isOn: $viewModel.isBiometricsEnabled) {
                    Text("Enable Biometrics")
                }
                .onChange(of: viewModel.isBiometricsEnabled) { newValue in
                    viewModel.toggleBiometricsEnabled(newValue)
                }

                Button(viewModel.isPINSet ? "Change PIN" : "Set PIN") {
                    self.showingPINModal = true
                }

                if viewModel.isBiometricsEnabled && !viewModel.isPINSet {
                    Text("Biometrics enabled without PIN setup. Consider setting up a PIN as a fallback.")
                        .foregroundColor(.orange)
                }
            }
        }
        .navigationBarTitle("Settings")
        .sheet(isPresented: $showingPINModal) {
            SettingsPINView(isPresented: $showingPINModal) { newPIN in
                viewModel.setPIN(newPIN)
            }
        }
    }
}
