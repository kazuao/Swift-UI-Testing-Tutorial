//
//  TableViewController.swift
//  UITestingTutorial
//
//  Created by k-aoki on 2021/09/04.
//

// 参考: https://www.youtube.com/watch?v=rmKbsQ41wVY&list=WL&index=1

import UIKit

class TableViewController: UITableViewController {

    // MARK: UI
    @IBOutlet weak var downloadsCell: UITableViewCell!
    
    
    // MARk: Override
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Mockify Music"
        downloadsCell.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserDefaults.standard.bool(forKey: "loggedIn") {
            downloadsCell.isHidden = false
        } else {
            downloadsCell.isHidden = true
        }
    }

    
    // MARK: IBAction
    @IBAction func showLogin(_ sender: Any) {
        if let loginVC = storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController {
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: true)
        }
    }
}

