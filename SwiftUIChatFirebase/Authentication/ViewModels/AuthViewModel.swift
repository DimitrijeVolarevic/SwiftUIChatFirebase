//
//  AuthViewModel.swift
//  SwiftUIChatFirebase
//
//  Created by Dimitrije Volarevic on 1.5.23..
//

import Foundation
import Firebase
import SwiftUI
import FirebaseStorage
import FirebaseAuth

class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var loginStatusMessage = ""
    var didAuthenticateUser: (() -> Void)?
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        print("User session is \(self.userSession)")
    }
    
    func logIn(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to login with error: ", error)
                self.loginStatusMessage = "Failed to login with error: \(error)"
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            
            print("Successfully logged in as user: \(result?.user.uid ?? "")")
            
            self.loginStatusMessage = "Successfully logged in as user: \(result?.user.uid ?? "")"
        }
    }
    
    func register(withEmail email: String, password: String, image: UIImage) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to register with error: ", error)
                self.loginStatusMessage = "Failed to register with error: \(error)"
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            
            print("Registered user successfully: \(result?.user.uid ?? "")")
            
            self.loginStatusMessage = "Registered user successfully: \(result?.user.uid ?? "")"
            
            self.persistImageToStorage(image: image) { imageURL in
                let data = ["email": email,
                            "uid": user.uid,
                            "profileImageURL": imageURL]
                
                Firestore.firestore().collection("users")
                    .document(user.uid)
                    .setData(data) { _ in
                        self.didAuthenticateUser?()
                    }
            }
            
        }
    }
    
    func persistImageToStorage(image: UIImage, completion: @escaping (String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            print("Could not convert image to data.")
            return
        }

        // Create a unique identifier for the image
        let imageName = UUID().uuidString
        let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).jpg")

        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Failed to upload image to Firebase Storage with error: ", error)
                return
            }

            storageRef.downloadURL { url, error in
                if let error = error {
                    print("Failed to fetch downloadURL: ", error)
                    return
                }

                guard let imageUrl = url?.absoluteString else {
                    print("URL is nil.")
                    return
                }

                print("Successfully uploaded image to Firebase Storage.")
                completion(imageUrl)
            }
        }
    }

}
