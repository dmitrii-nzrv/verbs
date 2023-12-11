//
//  UIStackView+Ex.swift
//  Verregular
//
//  Created by Dmitrii Nazarov on 11.12.2023.
//

import Foundation
import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { view in
            addArrangedSubview(view)
        }
    }
}
