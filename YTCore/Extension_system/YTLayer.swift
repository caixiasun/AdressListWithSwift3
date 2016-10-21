//
//  YTLayer.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 16/10/21.
//  Copyright © 2016年 yatou. All rights reserved.
//

import Foundation
import UIKit

extension CALayer {
    public func setBorderColorFromUIColor(color:UIColor) {
        self.borderColor = color.cgColor
    }
}
