//
//  ChatLogView.swift
//  SwiftUIChatFirebase
//
//  Created by Dimitrije Volarevic on 4.5.23..
//

import SwiftUI

struct ChatLogView: View {
    
    let chatUser: ChatUser?
    
    var body: some View {
        ScrollView {
            ForEach(0..<10) { num in
                Text("FAKE MESSAGES")
            }
        }
        .navigationTitle(chatUser?.email ?? "")
    }
}
