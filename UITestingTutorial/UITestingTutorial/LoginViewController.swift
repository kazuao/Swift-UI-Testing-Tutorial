//
//  LoginViewController.swift
//  UITestingTutorial
//
//  Created by k-aoki on 2021/09/04.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: UI
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var loadingActivity: UIActivityIndicatorView!
    
    
    // MARK:  Variables
    let expectedUserName = "CodePro"
    let expectedPassword = "abc123"
    
    
    // MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()

        username.delegate = self
        password.delegate = self
        navigationBar.delegate = self
        statusLabel.text = ""
        loadingActivity.hidesWhenStopped = true
    }
    
    
    // MARK: IBActions
    @IBAction func didTapLogin(_ sender: Any) {
        
        statusLabel.text = "Logging In"
        
        loadingActivity.startAnimating()
        
        guard let userName = username.text, !userName.isEmpty,
            let password = password.text, !password.isEmpty else {
                presentAlert(with: "Missing Credentials", message: "Missing User Name Or Password")
                return
        }
        
        guard expectedUserName == userName else {
            presentAlert(with: "Invalid Credentials", message: "Invalid User Name")
            return
        }
        
        guard expectedPassword == password else {
            presentAlert(with: "Invalid Credentials", message: "Invalid Password")
            return
        }
        
        UserDefaults.standard.set(true, forKey: "loggedIn")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.statusLabel.text = "Logged In"
            self.loadingActivity.stopAnimating()
            self.dismiss(animated: true, completion: nil)
        }
    }
}


// MARK: - Private Functions
private extension LoginViewController {
    
    func presentAlert(with title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(.init(title: "Ok", style: .default, handler: {_ in
                                    self.dismiss(animated: true, completion: nil)}))
        
        self.loadingActivity.stopAnimating()
        UserDefaults.standard.set(false, forKey: "loggedIn")

        present(alertVC, animated: true)
    }
}


// MARK: - UINavigationBarDelegate
extension LoginViewController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}


// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
