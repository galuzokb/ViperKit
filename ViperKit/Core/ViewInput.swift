//
//  ViewInput.swift
//  ViperKit
//
//  Created by Kirill Galuzo on 1/8/18.
//  Copyright © 2018 galuzokb. All rights reserved.
//

public protocol ViewInput {
    func startIndication()
    func stopIndication()
    
    func showSuccess()
    func showMessage(message: String)
    
    func showError()
    func showError(message: String)
}
