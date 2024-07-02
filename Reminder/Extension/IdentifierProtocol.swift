//
//  IdentifierProtocol.swift
//  Reminder
//
//  Created by NERO on 7/2/24.
//

import UIKit

protocol ldentifierProtocol: AnyObject {
    static var identifier: String { get }
}

extension UIView: ldentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
