//
//  SignUpView.swift
//  Firebase+Tutorial
//
//  Created by taekkim on 2023/05/31.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State var fullName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var retrySignUp = false
    @State var errorMessage = ""

    var body: some View {
        VStack {
            Form {
                TextField(
                    "이름을 입력해주세요.",
                    text: $fullName
                )
                .textInputAutocapitalization(.never)
                
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
                        try await authViewModel.registerUser(withEmail: email, password: password, fullName: fullName)
                    } catch {
                        retrySignUp = true
                        errorMessage = error.localizedDescription
                        print("DEBUG: Failed to sign up \(error.localizedDescription)")
                    }
                }
            } label: {
                Text("회원가입")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 150)
                    .background(.blue)
                    .cornerRadius(12)
            }


            Button {
                authViewModel.loginState = .loggedOut
            } label: {
                Text("이미 회원이신가요?")
            }

        }
        .alert("회원가입 실패", isPresented: $retrySignUp) {
            Button {
                retrySignUp = false
            } label: {
                Text("다시 시도하기")
            }
        } message: {
            Text("\(errorMessage)")
        }

    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
