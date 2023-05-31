//
//  User.swift
//  Firebase+Tutorial
//
//  Created by taekkim on 2023/05/31.
//

struct User: Codable {
    let fullName: String
    let email: String
    let uid: String
}

extension User {
    static let sample: User = User(fullName: "",
                                   email: "",
                                   uid: "")
}
