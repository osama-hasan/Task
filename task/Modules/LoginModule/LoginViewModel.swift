//
//  LoginViewModel.swift
//  task
//
//  Created by Osama Walid on 08/10/2023.
//

import Foundation

class LoginViewModel : NSObject {
    
    var emailAddress : String = ""
    var password : String = ""
    
    var onUserLogin: ((_ success:Bool,_ message:String)->Void)?
    
    
    
    func updateEmailTest(text:String){
        emailAddress = text
    }
    
    func updatePasswordTest(text:String){
        password = text
    }
    
    func login(){
        var errorMessage = ""
        
        if !emailAddress.isValidEmail{
            errorMessage = "Please Enter a valid email address"
            onUserLogin?(false,errorMessage)
            return
        }
      
        if !password.isPasswordValid{
            errorMessage = "Password should be more than 8 characters"
            onUserLogin?(false,errorMessage)
            return
        }
        DispatchQueue.main.async {
            DataSource.shared.login(username: self.emailAddress, password: self.password){ [weak self] isSuccess in
                guard let self  else {return}
                if isSuccess {
                    UserDefaultsManager.shared.email = emailAddress
                    self.onUserLogin?(isSuccess,errorMessage)
                    return
                }
                errorMessage = "Email or pasword is wrong!"
                self.onUserLogin?(isSuccess,errorMessage)
            }
        }


    }
    
}
