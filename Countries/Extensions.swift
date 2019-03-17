//
//  Extensions.swift
//  Countries
//
//  Created by Yana on 3/17/19.
//  Copyright © 2019 Yana. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    enum storyboards: String {
        case countriesFlow = "Countries"
        
        func initiate(with bundle: Bundle = .main) -> UIStoryboard {
            return UIStoryboard.init(name: self.rawValue, bundle: bundle)
        }
    }
    
    func initiateVC<T: UIViewController>(_ type: T.Type) -> T {
        guard let vc = self.instantiateViewController(withIdentifier: T.describing) as? T else {
            fatalError("Some error with initiating view controller with specified type, check if cpecified right storyboard id for it!")
        }
        return vc
    }
}

extension UIViewController {
   
    static var describing: String {
        return String.init(describing: self.self)
    }
}
