//
//  LoginViewController.swift
//  task
//
//  Created by Osama Walid on 08/10/2023.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var textFieldsBackgroundView: [UIView]!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var buttonTextField: UIButton!
    
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        viewModelLiseners()
    }

    
    func setupUI(){
        buttonTextField.layer.cornerRadius = 12
        textFieldsBackgroundView.forEach({$0.layer.cornerRadius = 8})
    }
    
    func viewModelLiseners(){
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        viewModel.onUserLogin = { isSuccess, message in
            if isSuccess {
                Router.setTabBar(for: AppDelegate.shared.window!)
                return
            }
            
            showErrorMessage(message)
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else {return}
        if  textField == emailTextField {
            viewModel.updateEmailTest(text:text)
        }
        if textField == passwordTextField {
            viewModel.updatePasswordTest(text: text)
        }
    }
    
    
    @IBAction func loginTap(_ sender: Any) {
        viewModel.login()
    }
    
}

