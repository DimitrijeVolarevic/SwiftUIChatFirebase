//
//  ChatLogView.swift
//  SwiftUIChatFirebase
//
//  Created by Dimitrije Volarevic on 4.5.23..
//

import SwiftUI
import FirebaseAuth

struct ChatLogView: View {
    
    let chatUser: ChatUser?
    
    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
        self.viewModel = .init(chatUser: chatUser)
    }
    
    @ObservedObject var viewModel: ChatLogViewModel
    
    var body: some View {
        
        ZStack {
            messagesView
            Text(viewModel.errorMessage)
            
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
            
            ZStack {
                descriptionPlaceHolder
                TextEditor(text: $viewModel.chatText)
                    .opacity(viewModel.chatText.isEmpty ? 0.5 : 1)
            }
            .frame(height: 40)
            
            
            Button {
                viewModel.handleSend()
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
            ScrollViewReader { proxy in
                VStack {
                    ForEach(viewModel.messages.indices, id: \.self) { index in
                        MessageView(message: viewModel.messages[index])
                        
                        if index == viewModel.messages.count - 1 {
                            Spacer(minLength: 80)
                                .id("LastMessage")
                        }
                    }
                }
                .onReceive(viewModel.$count) { _ in
                    withAnimation(.easeOut(duration: 0.5)) {
                        proxy.scrollTo("LastMessage", anchor: .bottom)
                    }
                }
            }
        }
        .background(Color(.init(white: 0.95, alpha: 1)))
    }

    
    private var descriptionPlaceHolder: some View {
       
        HStack {
            Text("Type your message..")
                .foregroundColor(Color(.gray))
                .font(.system(size: 15))
                .padding(.leading, 5)
                .padding(.top, -4)
            Spacer()
        }
    }
}

struct MessageView: View {
    let message: Message
    
    var body: some View {
        VStack {
            if message.fromId == Auth.auth().currentUser?.uid {
                HStack {
                    Spacer()
                    HStack {
                        Text(message.text)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
                }
            } else {
                HStack {
                    HStack {
                        Text(message.text)
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    Spacer()

                }

            }
        }
        .padding(.horizontal)
        .padding(.top,5)
        
    }
}
