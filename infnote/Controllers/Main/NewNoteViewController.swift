//
//  NewNoteViewController.swift
//  infnote
//
//  Created by Vergil Choi on 2018/8/14.
//  Copyright © 2018 Vergil Choi. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SVProgressHUD

class NewNoteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let action = { (notification: Notification) in
            if let info = notification.userInfo {
                let frame = info[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                let curve = info[UIResponder.keyboardAnimationCurveUserInfoKey] as! NSNumber
                let time = info[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber
                
                UIView.animate(withDuration: time.doubleValue, delay: 0, options: UIView.AnimationOptions(rawValue: curve.uintValue), animations: {
                    self.bottomConstraint.constant = -frame.height
                    self.view.layoutIfNeeded()
                }, completion: nil)
            }
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: OperationQueue.main, using: action)
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: OperationQueue.main) { notification in
            if let info = notification.userInfo {
                let curve = info[UIResponder.keyboardAnimationCurveUserInfoKey] as! NSNumber
                let time = info[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber
                
                UIView.animate(withDuration: time.doubleValue, delay: 0, options: UIView.AnimationOptions(rawValue: curve.uintValue), animations: {
                    self.bottomConstraint.constant = 0
                    self.view.layoutIfNeeded()
                }, completion: nil)
            }
        }
        
        /* Test signature procedure
        let note = [
            "user_id": "vergil",
            "content": "Some description of blockchain",
            "date_submitted": Int(Date().timeIntervalSince1970),
            "reply_to": "3DHjJB7shUyu8x8xVrNcEdjoA6wQJA1hVxojJ3rk7iQJ"
            ] as [String : Any]
        let key = try! Key(privateKey: "7x8tbToeR2XVfn35T89bXXmxyXiJN9h6BbSnhKoYg1GcuQ4cM75ewmMpzZXr1ttMcUz4u9Wd6AjUwMcEdPfZDr3qwGY68tAuEBnXJgSCT4tv4HqPCeaiGkQW6Zr8HNioDwVJ")
        let signature = try! key.sign(data: JSONSerialization.data(withJSONObject: note, options: .sortedKeys))
        print(key.publicKey.base58)
        print(key.privateKey.base58)
        print(signature.base58)
        print(note)
         */
    }
    
    
    
    @IBAction func sendButtonTouched(_ sender: Any) {
        if textView.textColor != UIColor.lightGray {
            
        }
        else {
            SVProgressHUD.showError(withStatus: "请输入内容")
        }
    }
    
    @IBAction func cancelButtonTouched(_ sender: Any) {
        self.navigationController?.dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "content", for: indexPath) as! NewNoteTextCell
        cell.prepareViews(tableView)
        textView = cell.textView
        return cell
    }

}


class NewNoteTextCell: UITableViewCell, UITextViewDelegate {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    weak var tableView: UITableView!
    
    func prepareViews(_ tableView: UITableView) {
        self.tableView = tableView
        textView.delegate = self
        textView.textColor = .lightGray
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textViewHeightConstraint.constant = textView.sizeThatFits(textView.frame.size).height
        
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "发表自己的想法"
            textView.textColor = .lightGray
        }
    }
}

class TopicButtonCell: UITableViewCell {
    
    @IBOutlet weak var topicButton: UIButton!
    
    func prepareViews() {
        topicButton.layer.borderColor = MAIN_COLOR.cgColor
        topicButton.layer.borderWidth = 0.5
    }
}
