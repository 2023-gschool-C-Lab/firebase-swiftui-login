//
//  SignOutView.swift
//  Firebase+Tutorial
//
//  Created by taekkim on 2023/05/31.
//

import SwiftUI

struct SignOutView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        VStack(spacing: 32) {

            if let fullName = authViewModel.user?.fullName {
                Text("\(fullName)님 안녕하세요!")
                    .font(.title)
                    .bold()
            } else {
                Text("                      ")
                    .redacted(reason: .placeholder)
            }

            Button {
                do {
                    try authViewModel.signOutUser()
                } catch {
                    print("DEBUG: Failed to sign out: \(error.localizedDescription)")
                }
            } label: {
                Text("Sign Out")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 150)
                    .background(.blue)
                    .cornerRadius(12)
            }
        }
        .task {
            do {
                try await authViewModel.fetchUser()
            } catch {
                print("DEBUG: Failed to fetch user \(error.localizedDescription)")
            }
        }
    }
}

struct SignOutView_Previews: PreviewProvider {
    static var previews: some View {
        SignOutView()
            .environmentObject(AuthViewModel())
    }
}
