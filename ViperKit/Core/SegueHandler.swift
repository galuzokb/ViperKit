//
//  SegueHandler.swift
//  ViperKit
//
//  Created by Kirill Galuzo on 1/8/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

public typealias ConfigurationBlock = (ModuleInput) -> Void

public protocol SegueHandler: class {
    func openModule(segueIdentifier: String)
    func openModule(segueIdentifier: String, configurationBlock: @escaping ConfigurationBlock)
    func closeModule()
}
