//
//  SwiftUIChatFirebaseApp.swift
//  SwiftUIChatFirebase
//
//  Created by Dimitrije Volarevic on 1.5.23..
//

import SwiftUI
import Firebase

@main
struct SwiftUIChatFirebaseApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
                MainMessagesView()
                    .environmentObject(viewModel)
        }
        
    }
}
