//
//  AssembliesFactory.swift
//  LaunchKit
//
//  Created by Kirill Galuzo on 1/8/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Foundation

open class AssembliesFactory: Assembly {
    
    var launchAssembly: RootLaunchAssembly {
        return try! container.resolve()
    }
    
    var viperAssembly: RootViperAssembly {
        return try! container.resolve()
    }
    
    var servicesAssembly: RootServicesAssembly {
        return try! container.resolve()
    }
    
    var coreAssembly: RootCoreAssembly {
        return try! container.resolve()
    }
    
    override public init() {
        super.init()
        
        container.register(.eagerSingleton) { RootLaunchAssembly(withCollaborator: $0) }
        container.register(.eagerSingleton) { RootViperAssembly(withCollaborator: $0) }
        container.register(.eagerSingleton) { RootServicesAssembly(withCollaborator: $0) }
        container.register(.eagerSingleton) { RootCoreAssembly() }
        
        registerCoreLayer(root: coreAssembly)
        
        registerServicesLayer(root: servicesAssembly)
        
        registerLaunchLayer(root: launchAssembly)
        
        registerPresentationLayer(root: viperAssembly)
        
        do {
            try container.bootstrap()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    open func registerLaunchLayer(root: RootLaunchAssembly) {
        
    }
    
    open func registerPresentationLayer(root: RootViperAssembly) {
        
    }
    
    open func registerServicesLayer(root: RootServicesAssembly) {
        
    }
    
    open func registerCoreLayer(root: RootCoreAssembly) {
        
    }
}
