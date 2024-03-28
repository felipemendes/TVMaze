//
//  SettingsViewModel.swift
//  TVMaze
//
//  Created by Felipe Mendes on 28/03/24.
//

import Foundation
import TVMazeServiceKit

class SettingsViewModel: ObservableObject {
    @Published var isBiometricsEnabled: Bool
    @Published var isPINSet: Bool
    @Published var pinSettingError: String?

    private let biometricsPreferenceKey = "BiometricsEnabled"
    private let biometricAuthManager: BiometricAuthenticationManager

    init(biometricAuthManager: BiometricAuthenticationManager) {
        self.biometricAuthManager = biometricAuthManager

        self.isBiometricsEnabled = UserDefaults.standard.bool(forKey: biometricsPreferenceKey)
        self.isPINSet = biometricAuthManager.isPINSet()
    }

    func toggleBiometricsEnabled() {
        isBiometricsEnabled.toggle()
        UserDefaults.standard.set(isBiometricsEnabled, forKey: biometricsPreferenceKey)
    }

    func setPIN(_ pin: String) {
        guard pin.count >= 4 else {
            pinSettingError = "PIN must be at least 4 digits."
            return
        }

        biometricAuthManager.setPIN(pin)

        isPINSet = true
        pinSettingError = nil

        UserDefaults.standard.set(true, forKey: "PINIsSet")
    }

    func removePIN() {
        biometricAuthManager.removePIN()
        isPINSet = false
        UserDefaults.standard.set(false, forKey: "PINIsSet")
    }
}
