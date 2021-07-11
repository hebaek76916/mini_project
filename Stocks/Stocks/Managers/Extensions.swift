//
//  Extensions.swift
//  Stocks
//
//  Created by 현은백 on 2021/07/11.
//

import Foundation
import UIKit

extension UIView {
    var width: CGFloat {
        frame.size.width
    }

    var height: CGFloat {
        frame.size.height
    }

    var left: CGFloat {
        frame.origin.x
    }

    var right: CGFloat {
        left + width
    }

    var top: CGFloat {
        frame.origin.y
    }
    var bottom: CGFloat {
        top + height
    }

    
}
