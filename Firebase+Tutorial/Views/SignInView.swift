//
//  SignInView.swift
//  Firebase+Tutorial
//
//  Created by taekkim on 2023/05/31.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State var retrySignIn = false
    @State var email: String = ""
    @State var password: String = ""
    @State var errorMessage = ""

    var body: some View {
        VStack {
            Form {
                TextField(
                    "이메일을 입력해주세요.",
                    text: $email
                )
                .textInputAutocapitalization(.never)

                SecureField(
                    "비밀번호를 입력해주세요.",
                    text: $password
                )
                .textInputAutocapitalization(.never)
            }

            Button {
                Task {
                    do {
                        try await authViewModel.signInUser(withEmail: email, password: password)
                    } catch {
                        retrySignIn = true
                        errorMessage = error.localizedDescription
                        print("DEBUG: Failed to sign in \(error.localizedDescription)")
                    }
                }
            } label: {
                Text("로그인")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 150)
                    .background(.blue)
                    .cornerRadius(12)
            }

            Button {
                authViewModel.loginState = .notSigned
            } label: {
                Text("아직 회원이 아니신가요?")
            }
        }
        .alert("로그인 실패", isPresented: $retrySignIn) {
            Button {
                retrySignIn = true
            } label: {
                Text("다시 시도하기")
            }
        } message: {
            Text(errorMessage)
        }

    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
