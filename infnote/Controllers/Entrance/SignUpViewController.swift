//
//  SignUpViewController.swift
//  infnote
//
//  Created by Vergil Choi on 2018/8/4.
//  Copyright © 2018 Vergil Choi. All rights reserved.
//

import UIKit
import InfnoteChain
import SVProgressHUD

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var nicknameField: UITextField!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        nextButton.isEnabled = false
        nextButton.backgroundColor = .gray
    }
    
    @IBAction func textFieldChanged(_ sender: UITextField) {
        if let _ = emailField.text?.range(of: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$", options: .regularExpression, range: nil, locale: nil),
            let _ = nicknameField.text?.range(of: ".{1,30}", options: .regularExpression, range: nil, locale: nil) {
            nextButton.isEnabled = true
            nextButton.backgroundColor = MAIN_COLOR
        }
        else {
            nextButton.isEnabled = false
            nextButton.backgroundColor = .gray
        }
    }
    
    @IBAction func nextButtonTouched(_ sender: Any) {
        guard let email = emailField.text, let nickname = nicknameField.text,
            email.count > 0 && nickname.count > 0 else {
            SVProgressHUD.showError(withStatus: __("SignUp.error.user.input"))
            return
        }
        
        let key = Key()
        var info = [
            "email": email,
            "nickname": nickname
        ]
        if let bio = bioTextView.text.count > 0 ? bioTextView.text : nil {
            info["bio"] = bio
        }
        let data = try! JSONSerialization.data(withJSONObject: info, options: .sortedKeys)
        let signatureData = key.sign(message: data)
        let user = User(JSON: info)!
        user.signature = signatureData.base58
        user.id = key.address
        user.key = key
        
        SVProgressHUD.show()
        Networking.shared.create(user: user, complete: { _ in
            SVProgressHUD.dismiss()
            key.save()
            User.current = user
            guard let controller = self.storyboard?.instantiateViewController(withIdentifier: NSStringFromClass(PrivateKeyViewController.self)) as? PrivateKeyViewController else {
                return
            }
            controller.key = key
            self.navigationController?.pushViewController(controller, animated: true)
        }) { error in
            print(error)
            SVProgressHUD.showError(withStatus: __("SignUp.user.create.failed"))
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "term" {
            let controller = segue.destination as! WebViewController
            controller.url = URL(string: "http://infnote.com/term.html")
        }
        else if segue.identifier == "privacy" {
            let controller = segue.destination as! WebViewController
            controller.url = URL(string: "http://infnote.com/privacy.html")
        }
    }
}
