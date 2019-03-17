//
//  BaseViewInterface.swift
//  Countries
//
//  Created by Yana on 3/17/19.
//  Copyright © 2019 Yana. All rights reserved.
//

import UIKit
import MBProgressHUD

protocol BaseViewInterface: class {
    
}

extension BaseViewInterface {
    func showActivityIndicator() {
        guard let vc = self as? UIViewController else { return }
        
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: vc.view, animated: true)
            MBProgressHUD.showAdded(to: vc.view, animated: true)
        }
    }
    
    func hideActivityIndicator() {
        guard let vc = self as? UIViewController else { return }
        
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: vc.view, animated: true)
        }
    }
}
