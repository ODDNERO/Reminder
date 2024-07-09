//
//  IdentifierProtocol.swift
//  Reminder
//
//  Created by NERO on 7/2/24.
//

import UIKit

protocol IdentifierProtocol: AnyObject {
    static var identifier: String { get }
}

extension UIView: IdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
