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
                            
                        } label: {
                            Image(systemName: "person.fill")
                                .font(.system(size: 64))
                                .padding()
                                .foregroundColor(.black)
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
                    
                    // correct later
                    Text(self.viewModel.loginStatusMessage)
                        .foregroundColor(.red)
                }
                .padding()
                .background(Color(.init(gray: 0, alpha: 0.10)))
                
            }
            .navigationTitle(isLoginMode ? "Log In" : "Create Account")
        }
    }
    
    private func handleAction() {
        if isLoginMode {
            viewModel.logIn(withEmail: email, password: password)
        } else {
            viewModel.register(withEmail: email, password: password)
        }
    }
    
}

//struct ContentView_Previews1: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
