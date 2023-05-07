//
//  MainMessagesView.swift
//  SwiftUIChatFirebase
//
//  Created by Dimitrije Volarevic on 2.5.23..
//

import SwiftUI
import Kingfisher

struct MainMessagesView: View {
    
    @State var chatUser: ChatUser?
    @State var showLogOutOptions = false
    @ObservedObject var viewModel = MainMessagesViewModel()
    @State var showNewMessageScreen = false
    @State var navigateToChatLogView = false
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                navBar
                
                messagesView
            
                NavigationLink("", isActive: $navigateToChatLogView) {
                    ChatLogView(chatUser: self.chatUser)
                }

            }
            .overlay(
                newMessageButton , alignment: .bottom
            )
            .toolbar(.hidden)
        }
        .accentColor(.primary)
    }
}



extension MainMessagesView {
   private var navBar: some View {
        HStack(spacing: 16){
            
            KFImage(URL(string: viewModel.chatUser?.profileImageURL ?? ""))
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 65, height: 65)
                .overlay(RoundedRectangle(cornerRadius: 44).stroke(lineWidth: 1))
                .shadow(radius: 5)
                
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(viewModel.chatUser?.email ?? "")")
                    .font(.system(size: 24, weight: .bold))
                
                HStack{
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 10, height: 14)
                    Text("online")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                
            }
            
            Spacer()
            Button {
                showLogOutOptions.toggle()
            } label: {
                Image(systemName: "gear")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.primary)
            }

            
        }
        .padding()
        .actionSheet(isPresented: $showLogOutOptions) {
            ActionSheet(title: Text("Settings"), message: Text("What do you want to do?"), buttons: [
                .destructive(Text("Sign Out"), action: {
                    viewModel.signOut()
                }),
                .cancel()
            ])
        }
        .fullScreenCover(isPresented: $viewModel.isUserCurrentlyLoggedOut) {
            LoginView().onAppear(perform: viewModel.fetchCurrentUser)
        }
    }
    
    private var newMessageButton: some View {
        Button {
            showNewMessageScreen.toggle()
        } label: {
            HStack {
                Spacer()
                Text("+ New Message")
                    .font(.system(size: 16, weight: .bold))
                Spacer()
            }
            .foregroundColor(.white)
            .padding(.vertical)
            .background(Color.blue)
            .cornerRadius(32)
            .padding(.horizontal)
            .padding(.bottom)
            .shadow(radius: 15)
                
        }
        .fullScreenCover(isPresented: $showNewMessageScreen) {
            NewMessageView(didSelectNewUser: { user in
                print(user.email)
                self.navigateToChatLogView.toggle()
                self.chatUser = user
            })
        }
    }
    
    private var messagesView: some View {
        ScrollView {
            ForEach(viewModel.recentMessages) { recentMessage in
                VStack{
                    NavigationLink {
                        Text("Destination")
                    } label: {
                        HStack(spacing: 16) {
                            KFImage(URL(string: recentMessage.profileImageURL))
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .frame(width: 50, height: 50)
                                .overlay(RoundedRectangle(cornerRadius: 44).stroke(lineWidth: 1))
                                .shadow(radius: 5)
                            VStack(alignment: .leading, spacing: 8) {
                                Text(recentMessage.email)
                                    .font(.system(size: 16, weight: .bold))
                                Text(recentMessage.text)
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Text("22d")
                                .font(.system(size: 14, weight: .semibold))
                        }
                    }
                    Divider()
                        .padding(.vertical, 8)
                }
                .padding(.horizontal)
                
            }
            .padding(.bottom, 50)
        }
    }
    
}

//struct MainMessagesView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            MainMessagesView()
//                .preferredColorScheme(.dark)
//            MainMessagesView()
//                .preferredColorScheme(.light)
//        }
//
//    }
//}
