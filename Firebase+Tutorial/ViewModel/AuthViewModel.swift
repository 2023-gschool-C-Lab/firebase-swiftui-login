//
//  AuthViewModel.swift
//  Firebase+Tutorial
//
//  Created by taekkim on 2023/05/31.
//

import Foundation

import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var loginState: LoginState

    // 앱의 모델.
    @Published var user: User?

    // 유저의 세션 정보가 담겨져 있음. 앱을 껐다가 다시 들어가도 유지

    private var uid: String {
        Auth.auth().currentUser?.uid ?? ""
    }

    init() {
        loginState = Auth.auth().currentUser != nil ? .loggedIn : .loggedOut
    }

    func registerUser(withEmail email: String, password: String, fullName: String) async throws {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        let user = User(fullName: fullName, email: email, uid: result.user.uid)
        try await storeUser(with: user)
        loginState = .loggedIn
    }

    func signInUser(withEmail email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
        loginState = .loggedIn
    }

    func signOutUser() throws {
        try Auth.auth().signOut()
        self.user = nil
        loginState = .loggedOut
    }

    func fetchUser() async throws {
        guard let user = try? await Firestore.firestore().collection("users").document(uid).getDocument(as: User.self) else {
            return
        }
        self.user = user
    }
}

extension AuthViewModel {
    // MARK: - Helper
    private func storeUser(with user: User) async throws {
        let encodedUser = try Firestore.Encoder().encode(user)
        try await Firestore.firestore().collection("users").document(uid).setData(encodedUser)
    }
}
