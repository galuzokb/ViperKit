//
//  Application.swift
//  LaunchKit
//
//  Created by Kirill Galuzo on 1/8/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation
import UIKit
import DiKit

open class Application: UIApplication {
    let _factory: AssembliesFactory
    
    open class var factory: AssembliesFactory {
        fatalError("Override this property")
    }
    
    override public init() {
        _factory = type(of: self).factory
        super.init()
    }
    
    override open var delegate: UIApplicationDelegate? {
        willSet {
            if let delegate = newValue {
                let delegateType = type(of: delegate)
                _factory.launchAssembly.injectProperties(to: delegate, ofType: delegateType)
            }
        }
    }
}
