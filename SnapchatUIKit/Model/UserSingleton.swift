//
//  UserSingleton.swift
//  SnapchatUIKit
//
//  Created by Italo Stuardo on 3/5/23.
//

import Foundation

class UserSingleton {
    static let sharedInstance = UserSingleton()
    
    var email = ""
    var username = ""
    
    private init() {}
}
