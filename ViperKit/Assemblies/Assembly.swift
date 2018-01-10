//
//  Assembly.swift
//  DiKit
//
//  Created by Kirill Galuzo on 1/8/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

import Dip
import Foundation

open class Assembly {
    
    public let container = DependencyContainer()
    
    public init() {}
    
    public init(withCollaborator collaborator: Assembly) {
        container.collaborate(with: collaborator.container)
    }
    
    public func resolve<T>(tag: String? = nil) -> T {
        do {
            return try container.resolve(tag: tag)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    public func bootstrap() {
        do {
            try container.bootstrap()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}


