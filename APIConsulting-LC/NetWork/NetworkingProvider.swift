//
//  NetworkingProvider.swift
//  APIConsulting-LC
//
//  Created by u633168 on 27/01/2023.
//

import Foundation
import Alamofire

final class NetworkingProvider{

    static let shared = NetworkingProvider()
    
    private let kBaseURL = "https://gorest.co.in/public-api/"
    private let kBaseURL2 = "https://gorest.co.in/public/v2/"
    private let kStatusOk = 200...299
    private let apiToken = "6006e02179db8f1fc1a03296d1269676ec6003824f6c206ac289dc87ea73003f"
    
    
    
    func getUser(id: Int, success: @escaping (_ user: User) -> (), failure: @escaping (_ error: Error?) -> ()) {

        let url = "\(kBaseURL)users/\(id)"
        
        AF.request(url, method: .get).validate(statusCode: kStatusOk).responseDecodable (of: UserResponse.self) {  response in
            
            if let user = response.value?.data {
                success(user)
            } else {
                failure(response.error)
            }
        }
    }
    
    func addUser(user: NewUser, success: @escaping (_ user: User) -> (), failure: @escaping (_ error: Error?) -> () ){
        let url = "\(kBaseURL2)users"
        let headers: HTTPHeaders = [.authorization(bearerToken: apiToken)]
        
        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default, headers: headers).validate(statusCode: kStatusOk).responseDecodable (of: User.self) {  response in
            
            if let user = response.value, user.id != nil {
                print(user)
                success(user)
            } else {
                
                failure(response.error)
            }
            
        }
    }
    
}
