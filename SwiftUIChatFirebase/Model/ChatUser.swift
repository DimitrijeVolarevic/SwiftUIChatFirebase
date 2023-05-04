//
//  ChatUser.swift
//  SwiftUIChatFirebase
//
//  Created by Dimitrije Volarevic on 3.5.23..
//

import Foundation

struct ChatUser: Hashable {
    let uid, email, profileImageURL: String
    
    init(data: [String: Any]) {
        self.uid = data["uid"] as? String ?? ""
        let emailData = data["email"] as? String ?? ""
        let emailComponents = emailData.split(separator: "@")
        self.email = String(emailComponents[0])
        self.profileImageURL = data["profileImageURL"] as? String ?? ""
    }
}
