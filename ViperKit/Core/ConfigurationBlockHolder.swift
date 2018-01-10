//
//  ConfigurationBlockHolder.swift
//  ViperKit
//
//  Created by Kirill Galuzo on 1/8/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

internal class ConfigurationBlockHolder {
    let block: (ModuleInput) -> Void
    
    init(block: @escaping (ModuleInput) -> Void) {
        self.block = block
    }
}
