//
//  String+Ex.swift
//  Verregular
//
//  Created by Dmitrii Nazarov on 11.12.2023.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
