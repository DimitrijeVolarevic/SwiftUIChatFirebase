//
//  ChatLogView.swift
//  SwiftUIChatFirebase
//
//  Created by Dimitrije Volarevic on 4.5.23..
//

import SwiftUI

struct ChatLogView: View {
    
    let chatUser: ChatUser?
    @State var chatText = ""
    
    var body: some View {
        
        ZStack {
            messagesView
            
            VStack {
                Spacer()
                chatBottomBar
                    .background(.white)
                
            }
            
            
        }
        
        .navigationTitle(chatUser?.email ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChatLogView_Previews1: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatLogView(chatUser: .init(data: ["uid": "TV09hqHAuTQ6dYPYaszcfN7ONON2", "email": "Test7@gmail.com"]))
            
        }
    }
}

extension ChatLogView {
    private var chatBottomBar: some View {
        HStack(spacing: 15) {
            Image(systemName: "photo.on.rectangle")
                .resizable()
                .frame(width: 27, height: 24)
                .foregroundColor(Color(.darkGray))
            TextField("Description", text: $chatText)
            Button {
                
            } label: {
                Text("Send")
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color.blue)
            .cornerRadius(5)


        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
    
    private var messagesView: some View {
        ScrollView {
            ForEach(0..<15) { num in
                HStack {
                    Spacer()
                    HStack {
                        Text("FAKE MESSAGES")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
                }
                .padding(.horizontal)
                .padding(.top,5)

            }
            HStack{ Spacer() }
        }
        .background(Color(.init(white: 0.95, alpha: 1)))
    }
}
