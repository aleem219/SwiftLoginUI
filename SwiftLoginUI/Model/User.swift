//
//  User.swift
//  SwiftLoginUI
//
//  Created by Abdul Aleem on 04/04/26.
//

import Foundation



struct User: Codable, Hashable {
    var id: Int
    var firstName: String?
    var lastName: String?
    var maidenName: String?
    var email: String?
    var phone: String?
    var username: String?
    var image:String?
    var address : Address
   
}

struct Address: Codable, Hashable{
    var address: String?
}


struct UserResponse: Codable {
    var users: [User]?
    var total: Int?
    var skip: Int?
    var limit: Int?
}


extension User {
    init() {
        self.id = 0
        self.firstName = "Test"
        self.lastName = "User"
        self.maidenName = nil
        self.email = "test@test.com"
        self.phone = "0000000000"
        self.image = nil
        self.address = Address(address: "Okhla vihar")
    }
}
