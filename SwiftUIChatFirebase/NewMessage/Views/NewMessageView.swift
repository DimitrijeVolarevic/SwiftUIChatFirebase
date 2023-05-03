//
//  NewMessageView.swift
//  SwiftUIChatFirebase
//
//  Created by Dimitrije Volarevic on 3.5.23..
//

import SwiftUI
import Kingfisher

struct NewMessageView: View {
    
    @ObservedObject var viewModel = NewMessageViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(viewModel.users, id: \.uid) { user in
                    HStack(spacing: 16) {
                        KFImage(URL(string: user.profileImageURL))
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 50, height: 50)
                            .overlay(RoundedRectangle(cornerRadius: 44).stroke(lineWidth: 1))
                        Text(user.email)
                        Spacer()
                    }
                    .padding(.horizontal)
                    Divider()
                        .padding(.vertical,10)
                    
                }
                .onAppear {
                    viewModel.fetchAllUsers()
                }
                .navigationTitle("New Message")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Cancel")
                        }

                    }
                }
            }
        }
    }
    
    struct NewMessageView_Previews: PreviewProvider {
        static var previews: some View {
            NewMessageView()
        }
    }
}
