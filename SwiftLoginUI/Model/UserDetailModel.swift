//
//  UserDetailModel.swift
//  SwiftLoginUI
//
//  Created by Abdul Aleem on 06/04/26.
//

import Foundation

struct UserDetail: Codable, Hashable {
    var id: Int
    var firstName: String?
    var lastName: String?
    var maidenName: String?
    var email: String?
    var phone: String?
    var username: String?
    var image:String?
    var company : Company
    var role: String?
}

struct Company: Codable, Hashable{
    var company: String?
    var name:String?
}


extension UserDetail {
    init() {
        self.id = 0
        self.firstName = "Test"
        self.lastName = "User"
        self.maidenName = nil
        self.email = "test@test.com"
        self.phone = "0000000000"
        self.image = nil
        self.company = Company(company: "Technology", name: "Tech Corp")
    }
}
