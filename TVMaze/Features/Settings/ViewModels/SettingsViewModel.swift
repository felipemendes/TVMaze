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
    @Published var showPINAlert: Bool = false
    @Published var pinSettingError: String?

    private let biometricAuthManager: BiometricAuthenticationManager
    private let biometricsPreferenceKey = "BiometricsEnabled"
    private let pinIsSetKey = "PINIsSet"
    private let pinSettingErrorMessage = "PIN must be at least 4 digits."
    private let minimumPINDigits = 4

    init(biometricAuthManager: BiometricAuthenticationManager) {
        self.biometricAuthManager = biometricAuthManager

        self.isBiometricsEnabled = UserDefaults.standard.bool(forKey: biometricsPreferenceKey)
        self.isPINSet = biometricAuthManager.isPINSet()
    }

    func toggleBiometricsEnabled(_ newValue: Bool) {
        isBiometricsEnabled = newValue
        UserDefaults.standard.set(newValue, forKey: biometricsPreferenceKey)
        UserDefaults.standard.synchronize()
    }

    func setPIN(_ pin: String) {
        guard pin.count >= minimumPINDigits else {
            pinSettingError = pinSettingErrorMessage
            showPINAlert = true
            return
        }

        biometricAuthManager.setPIN(pin)

        isPINSet = true
        pinSettingError = nil
        showPINAlert = false

        UserDefaults.standard.set(true, forKey: pinIsSetKey)
    }

    func removePIN() {
        biometricAuthManager.removePIN()
        isPINSet = false
        UserDefaults.standard.set(false, forKey: pinIsSetKey)
    }
}
