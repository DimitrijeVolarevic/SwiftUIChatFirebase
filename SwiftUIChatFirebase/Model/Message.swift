//
//  Message.swift
//  SwiftUIChatFirebase
//
//  Created by Dimitrije Volarevic on 5.5.23..
//

import Foundation

struct Message: Identifiable {
    
    var id: String { documentID }
    var fromId: String
    var toId: String
    var text: String
    var documentID: String
    
    init(documentID: String, data: [String: Any]) {
        self.documentID = documentID
        self.fromId = data["fromId"] as? String ?? ""
        self.toId = data["toId"] as? String ?? ""
        self.text = data["text"] as? String ?? ""
    }
}
