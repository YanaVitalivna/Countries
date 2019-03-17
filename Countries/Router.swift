//
//  Router.swift
//  Countries
//
//  Created by Yana on 3/17/19.
//  Copyright © 2019 Yana. All rights reserved.
//

import UIKit

enum PresentationType<T> {
    case present(in: UIViewController)
    case push(in: UINavigationController)
    case custom(presentationHandler: ((T)->()))
}

class Router {
    
    static func present<T>(_ type: T.Type, with data: Any? = nil, animated: Bool = true, using presentationType: PresentationType<T>) {
        
        // assemble mvp structure screen
        let presentedChild: T = ControllersFabric.performAssemnling(type: T.self as! AnyClass, with: data)
        
        self.performPresentation(of: presentedChild, using: presentationType, animated: animated)
    }
    
    
    static func makeRootForWindow(_ controller: UIViewController, with data: Any? = nil) {
        
        let window = UIApplication.shared.keyWindow
        window?.rootViewController?.view.removeFromSuperview()
        
        UIApplication.shared.keyWindow?.rootViewController = controller
    }
    
    private static func performPresentation<T>(of child: T, using presentionType: PresentationType<T>, animated: Bool) {
        
        switch presentionType {
        case .present(let viewController): // present vc
            guard let child = child as? UIViewController else { fatalError("child should be represented as UIViewController") }
            
            viewController.present(child, animated: animated, completion: nil)
            
        case .push(let navigationController): // push in navigation controller
            guard let child = child as? UIViewController else { fatalError("child should be represented as UIViewController") }
            navigationController.pushViewController(child, animated: true)
            
        case .custom(let handler):
            handler(child)
        }
    }
}
