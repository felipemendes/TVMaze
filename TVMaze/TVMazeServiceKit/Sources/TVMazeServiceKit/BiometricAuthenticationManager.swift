//
//  BiometricAuthenticationManager.swift
//
//
//  Created by Felipe Mendes on 27/03/24.
//

import UIKit
import LocalAuthentication
import KeychainSwift

public protocol BiometricAuthManagerProtocol {
    func setPIN(_ pin: String)
    func verifyPIN(_ pin: String) -> Bool
    func isPINSet() -> Bool
    func removePIN()
    func authenticateUser(reason: String, completion: @escaping (Bool, Error?) -> Void)
    func authenticateUserIfNeeded(completion: @escaping (Bool, Error?) -> Void)
    func canUseBiometricAuthentication() -> Bool
}

public class BiometricAuthenticationManager: BiometricAuthManagerProtocol {

    // MARK: - Initializer

    public init() { }

    // MARK: - Private

    private let keychain = KeychainSwift()
    private let biometricSwitchKey = "biometricSwitchState"
    private let pinKey = "userPIN"
    private let biometricsEnabledKey = "BiometricsEnabled"
    private let policy = "Authenticate using Face ID or Touch ID"

    // MARK: - Public API PIN Management

    public func setPIN(_ pin: String) {
        keychain.set(pin, forKey: pinKey)
    }

    public func verifyPIN(_ pin: String) -> Bool {
        keychain.get(pinKey) == pin
    }

    public func isPINSet() -> Bool {
        keychain.get(pinKey) != nil
    }

    public func removePIN() {
        keychain.delete(pinKey)
    }

    public func authenticateUser(reason: String, completion: @escaping (Bool, Error?) -> Void) {
        let context = LAContext()

        context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, error in
            DispatchQueue.main.async {
                completion(success, error)
            }
        }
    }

    public func authenticateUserIfNeeded(completion: @escaping (Bool, Error?) -> Void) {
        let isBiometricsEnabled = UserDefaults.standard.bool(forKey: biometricsEnabledKey)

        if isBiometricsEnabled && canUseBiometricAuthentication() {
            authenticateWithBiometrics(completion: completion)
        } else {
            completion(true, nil)
        }
    }

    // MARK: - Public API Biometric Management

    public func canUseBiometricAuthentication() -> Bool {
        let context = LAContext()
        var error: NSError?
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
    }

    // MARK: - Private

    private func authenticateWithBiometrics(completion: @escaping (Bool, Error?) -> Void) {
        let context = LAContext()
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: policy) { success, error in
            DispatchQueue.main.async {
                completion(success, error)
            }
        }
    }
}
