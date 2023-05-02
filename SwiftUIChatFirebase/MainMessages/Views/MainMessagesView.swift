//
//  MainMessagesView.swift
//  SwiftUIChatFirebase
//
//  Created by Dimitrije Volarevic on 2.5.23..
//

import SwiftUI

struct MainMessagesView: View {
    
    @State var showLogOutOptions = false
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                navBar
                
                messagesView
            
            }
            .overlay(
                newMessageButton , alignment: .bottom
            )
            .toolbar(.hidden)
        }
    }
}



extension MainMessagesView {
   private var navBar: some View {
        HStack(spacing: 16){
            
            Image(systemName: "person.fill")
                .font(.system(size: 34, weight: .heavy))
            
            VStack(alignment: .leading, spacing: 4) {
                Text("USERNAME")
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
                    // sign out logic
                }),
                .cancel()
            ])
        }
    }
    
    private var newMessageButton: some View {
        Button {
            
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
    }
    
    private var messagesView: some View {
        ScrollView {
            ForEach(0..<10, id: \.self) { num in
                VStack{
                    HStack(spacing: 16) {
                        Image(systemName: "person.fill")
                            .font(.system(size: 32))
                            .padding(8)
                            .overlay(RoundedRectangle(cornerRadius: 44).stroke(lineWidth: 1))
                        VStack(alignment: .leading) {
                            Text("Username")
                                .font(.system(size: 16, weight: .bold))
                            Text("Message sent to user")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text("22d")
                            .font(.system(size: 14, weight: .semibold))
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

struct MainMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainMessagesView()
                .preferredColorScheme(.dark)
            MainMessagesView()
                .preferredColorScheme(.light)
        }
        
    }
}
