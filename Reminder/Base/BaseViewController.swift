//
//  ViewController.swift
//  Reminder
//
//  Created by NERO on 7/2/24.
//

import UIKit

class BaseViewController<RootView: UIView>: UIViewController {
    let rootView = RootView()
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addEventHandler()
    }
    
    func addEventHandler() {
        
    }
}
