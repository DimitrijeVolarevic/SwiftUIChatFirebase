//
//  RecentMessage.swift
//  SwiftUIChatFirebase
//
//  Created by Dimitrije Volarevic on 7.5.23..
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct RecentMessage: Codable, Identifiable {
    
    @DocumentID var id: String?
    let text: String
    let fromId, toId: String
    let profileImageURL: String
    let email: String
    let timestamp: Date
    
    var timeAgo: String {
            let formatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .abbreviated
            return formatter.localizedString(for: timestamp, relativeTo: Date())
        }
    
}
