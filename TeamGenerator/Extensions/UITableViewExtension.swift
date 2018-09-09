//
//  UITableViewExtension.swift
//  TeamGenerator
//
//  Created by Pedro Lopes on 08/09/2018.
//  Copyright © 2018 Le Team Software. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(cellClass: T.Type) where T: ReusableView {
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func register<T: UITableViewCell>(cellClass: T.Type) where T: ReusableView, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        
        register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueResuableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError(" Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
}
