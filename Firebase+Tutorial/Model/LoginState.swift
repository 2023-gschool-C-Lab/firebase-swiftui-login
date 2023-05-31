//
//  LoginState.swift
//  Firebase+Tutorial
//
//  Created by taekkim on 2023/05/31.
//

import Foundation

enum LoginState {
    case loggedIn
    case loggedOut
    case notSigned

    var navigationTitle: String {
        switch self {
        case .loggedIn:
            return "로그아웃"
        case .loggedOut:
            return "로그인"
        case .notSigned:
            return "회원가입"
        }
    }
}
