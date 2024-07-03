//
//  TagViewController.swift
//  Reminder
//
//  Created by NERO on 7/4/24.
//

import UIKit

final class TagViewController: BaseViewController<TagView> {
    private lazy var tag = rootView.tagTextField.text
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.post(name: NSNotification.Name("toDoInfo"),
                                        object: nil,
                                        userInfo: ["tag": tag])
    }
}
