//
//  newUser.swift
//  APIConsulting-LC
//
//  Created by u633168 on 27/01/2023.
//

import Foundation

struct NewUser: Encodable {
    let name: String
    let email: String
    let gender: String
    let status: String
}
