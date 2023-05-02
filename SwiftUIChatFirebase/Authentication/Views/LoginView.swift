//
//  ContentView.swift
//  SwiftUIChatFirebase
//
//  Created by Dimitrije Volarevic on 1.5.23..
//

import SwiftUI

struct LoginView: View {
    
    @State var isLoginMode: Bool = false
    @State var email = ""
    @State var password = ""
    @State var showImagePicker = false
    @State private var image: UIImage?
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    
                    Picker(selection: $isLoginMode, label: Text("Picker here")) {
                        Text("Login").tag(true)
                        Text("Create Account").tag(false)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    if !isLoginMode {
                        Button {
                            showImagePicker.toggle()
                        } label: {
                            
                            VStack {
                                if let image = self.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                } else {
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 64))
                                        .padding()
                                        .foregroundColor(.primary)
                                }
                            }
                            
                        }
                    }
                    
                    
                    Group {
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .padding(.leading)
                            .padding(.vertical)
                            .background(.white)
                            .cornerRadius(10)
                        SecureField("Password", text: $password)
                            .padding(.leading)
                            .padding(.vertical)
                            .background(.white)
                            .cornerRadius(10)
                    }
                    
                    
                    Button {
                        handleAction()
                    } label: {
                        HStack {
                            Spacer()
                            Text(isLoginMode ? "Log In" : "Create Account")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(.vertical, 10 )
                            Spacer()
                        }
                        .background(Color.blue)
                        
                    }
                    .cornerRadius(10)
                    .padding(.vertical,6)
                    
                    Text(self.viewModel.loginStatusMessage)
                        .foregroundColor(.black)
                }
                .padding()
                .background(Color(.init(gray: 0, alpha: 0.10)))
                
            }
            .navigationTitle(isLoginMode ? "Log In" : "Create Account")
        }
        .fullScreenCover(isPresented: $showImagePicker, onDismiss: nil) {
            ImagePicker(image: $image)
        }
    }
    
    private func handleAction() {
        if isLoginMode {
            viewModel.logIn(withEmail: email, password: password)
        } else {
            if let image = self.image {
                viewModel.register(withEmail: email, password: password, image: image)
            } else {
                viewModel.loginStatusMessage = "Image not selected"
            }
        }
    }
}
