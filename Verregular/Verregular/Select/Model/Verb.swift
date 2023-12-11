//
//  Verb.swift
//  Verregular
//
//  Created by Dmitrii Nazarov on 11.12.2023.
//

import Foundation

struct Verb {
    let infinitive: String
    let pastSimple: String
    let pastParticiple: String
    
    var translate: String {
        infinitive.localized
    }
}

