//
//  BasePageViewController.swift
//  ViperKit
//
//  Created by Kirill Galuzo on 1/24/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import UIKit

open class BasePageViewController: UIPageViewController, SegueHandler {
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let configurationBlock = sender as? ConfigurationBlockHolder else {
            return
        }
        
        let potentialModuleInputProvider: UIViewController
        
        if segue.destination is ModuleInputProvider {
            potentialModuleInputProvider = segue.destination
        } else if let destination = segue.destination as? UINavigationController {
            guard let top = destination.topViewController else {
                fatalError("It isn't allowed to push empty navigation controller")
            }
            potentialModuleInputProvider = top
        } else if let destination = segue.destination as? UITabBarController {
            guard let selected = destination.selectedViewController else {
                fatalError("It isn't allowed to push empty tab bar controller")
            }
            potentialModuleInputProvider = selected
        } else {
            fatalError("ModuleInput can't be found")
        }
        
        guard let controller = potentialModuleInputProvider as? ModuleInputProvider else {
            fatalError("Controller should be an ModuleInputProvider")
        }
        
        configurationBlock.block(controller.moduleInput)
    }
    
    open func openModule(segueIdentifier: String) {
        performSegue(withIdentifier: segueIdentifier, sender: nil)
    }
    
    open func openModule(segueIdentifier: String, configurationBlock: @escaping ConfigurationBlock) {
        performSegue(withIdentifier: segueIdentifier, sender: ConfigurationBlockHolder(block: configurationBlock))
    }
    
    open func closeModule() {
        if let parentVC = self.parent {
            if let navigationVC = parentVC as? UINavigationController {
                if navigationVC.viewControllers.count > 1 {
                    navigationVC.popViewController(animated: true)
                } else {
                    navigationVC.dismiss(animated: true, completion: nil)
                }
            }
            return
        }
        
        guard presentingViewController != nil else {
            fatalError("Current VC can't be dismissed")
        }
        
        return self.dismiss(animated: true, completion: nil)
    }
}
