//
//  AuthenticationViewModel.swift
//  TVMaze
//
//  Created by Felipe Mendes on 28/03/24.
//

import Foundation
import LocalAuthentication
import TVMazeServiceKit

protocol AuthenticationViewModelProtocol {
    var authErrorMessage: String? { get }
    var biometricAuthManager: BiometricAuthenticationManager { get }

    func authenticateWithBiometrics(completion: @escaping (Bool) -> Void)
    func verifyPIN(_ pin: String, completion: @escaping (Bool) -> Void)
}

class AuthenticationViewModel: ObservableObject, AuthenticationViewModelProtocol {

    // MARK: - Initializer

    init(biometricAuthManager: BiometricAuthenticationManager) {
        self.biometricAuthManager = biometricAuthManager
    }

    // MARK: - Public API

    @Published var authErrorMessage: String? = nil
    var biometricAuthManager: BiometricAuthenticationManager

    func authenticateWithBiometrics(completion: @escaping (Bool) -> Void) {
        biometricAuthManager.authenticateUserIfNeeded { success, error in
            if success {
                DispatchQueue.main.async {
                    completion(true)
                }
            } else {
                if let laError = error as? LAError, laError.code == LAError.biometryNotEnrolled {
                    self.authErrorMessage = "Biometric authentication is not set up on this device."
                } else {
                    self.authErrorMessage = error?.localizedDescription ?? "An unknown error occurred."
                }
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }

    func verifyPIN(_ pin: String, completion: @escaping (Bool) -> Void) {
        let isCorrect = biometricAuthManager.verifyPIN(pin)
        DispatchQueue.main.async {
            completion(isCorrect)
        }
    }
}
