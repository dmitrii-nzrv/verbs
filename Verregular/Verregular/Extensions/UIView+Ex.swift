//
//  UIView+Ex.swift
//  Verregular
//
//  Created by Dmitrii Nazarov on 11.12.2023.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { view in
            addSubview(view)
        }
    }
}
