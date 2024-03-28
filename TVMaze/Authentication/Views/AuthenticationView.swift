//
//  AuthenticationViewModel.swift
//  TVMaze
//
//  Created by Felipe Mendes on 27/03/24.
//

import SwiftUI
import TVMazeServiceKit

struct AuthenticationView<Content: View>: View {
    @EnvironmentObject var appEnvironment: AppEnvironment
    @State private var isPresentingPINView = false
    private var viewModel: AuthenticationViewModel

    var content: Content

    init(
        viewModel: AuthenticationViewModel,
        @ViewBuilder content: () -> Content
    ) {
        self.viewModel = viewModel
        self.content = content()
    }

    var body: some View {
        Group {
            if appEnvironment.isAuthenticated {
                content
            } else {
                VStack {
                    Text("Please authenticate to continue")
                        .onAppear {
                            authenticateUser()
                        }

                    Button(action: {
                        isPresentingPINView = true
                    }) {
                        Text("Use PIN")
                            .foregroundColor(Color.theme.accent)
                            .padding()
                    }
                }
            }
        }
        .sheet(isPresented: $isPresentingPINView) {
            AuthenticationPINView(isAuthenticated: $appEnvironment.isAuthenticated, isPresented: $isPresentingPINView, viewModel: viewModel)
        }
    }
}

// MARK: - Authenticate User

extension AuthenticationView {
    private func authenticateUser() {
        if viewModel.biometricAuthManager.canUseBiometricAuthentication() {
            viewModel.biometricAuthManager.authenticateUserIfNeeded { success, error in
                if success {
                    appEnvironment.isAuthenticated = true
                } else {
                    if viewModel.biometricAuthManager.isPINSet() {
                        isPresentingPINView = true
                    }
                }
            }
        } else if viewModel.biometricAuthManager.isPINSet() {
            isPresentingPINView = true
        }
    }
}
