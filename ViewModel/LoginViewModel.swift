//
//  LoginViewModel.swift
//  EmailAuthFirebase
//
//  Created by Maxim Macari on 31/3/21.
//

import SwiftUI
import Firebase

class LoginViewModel: ObservableObject {
   
    //login properties
    @Published var userName = ""
    @Published var password = ""
    
    @Published var isNewUser = false
    @Published var registerUserName = ""
    @Published var registerPassword = ""
    @Published var reEnterPassword = ""
    
    //Loading screen
    @Published var isLoading = false
    
    //Error
    @Published var errorMsg = ""
    @Published var showError: Bool = false
    
    //Log status
    @AppStorage("log_Status") var status = false
    
    func loginUser(){
        
        withAnimation{
            isLoading = true
        }
        
        Auth.auth().signIn(withEmail: userName, password: password) { [self] (result, err) in
            if let error = err {
                self.errorMsg = error.localizedDescription
                self.showError.toggle()
                return
            }
            
            guard let _ = result else {
                errorMsg = "Please try again or later"
                showError.toggle()
                return
            }
            
            //Success
            print("Success logging in")
            withAnimation{
                status = true
            }
        }
    }
    
    func resetPassword(){
        Auth.auth().sendPasswordReset(withEmail: userName) { [self] (err) in
            if let error = err {
                errorMsg = error.localizedDescription
                showError.toggle()
                return
            }
            errorMsg = "Reset link sent successfully"
            showError.toggle()
        }
    }
    
    func registerUser(){
        //Cheking password mathc
        if reEnterPassword == registerPassword {
            withAnimation{isLoading = true}
            Auth.auth().createUser(withEmail: registerUserName, password: reEnterPassword) { [self] (result, err) in
                if let error = err {
                    errorMsg = error.localizedDescription
                    showError.toggle()
                    return
                }
                
                guard let _ = result else {
                    errorMsg = "Please try again or later"
                    showError.toggle()
                    return
                }
                
                print("Success registering")
                // promoting useer back
                errorMsg = "Account created successfully"
                showError.toggle()
                withAnimation{
                    status = false
                }
            }
        } else {
            errorMsg = "Password Mismatch"
            showError.toggle()
        }
    }
}
