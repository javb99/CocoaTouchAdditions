//
//  IdentifiableButton.swift
//  CocoaTouchAdditions
//
//  Created by Joseph Van Boxtel on 12/28/18.
//  Copyright © 2018 Joseph Van Boxtel. All rights reserved.
//

import UIKit

public class IdentifiableButton<ID>: UIButton {
    public var identifier: ID
    public init(id: ID) {
        identifier = id
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
