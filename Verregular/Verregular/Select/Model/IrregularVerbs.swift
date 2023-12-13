//
//  IrregularVerbs.swift
//  Verregular
//
//  Created by Dmitrii Nazarov on 11.12.2023.
//

import Foundation

final class IrregularVerbs {
    
    // Singletone
    static var shared = IrregularVerbs()
    private init() {
        configureVerbs()
    }
    
    // MARK: ~ Properties
    var selectedVerbs: [Verb] = []
    private(set) var verbs: [Verb] = []
    
    // MARK: ~ Methods
   private func configureVerbs() {
        verbs = [
            Verb(infinitive: "blow", pastSimple: "blew", pastParticiple: "blown"),
            Verb(infinitive: "eat", pastSimple: "ate", pastParticiple: "eaten"),
            Verb(infinitive: "draw", pastSimple: "drew", pastParticiple: "drawn"),
            Verb(infinitive: "get", pastSimple: "got", pastParticiple: "gotten"),
            Verb(infinitive: "speak", pastSimple: "spoke", pastParticiple: "spoken"),
            Verb(infinitive: "see", pastSimple: "saw", pastParticiple: "seen"),
        
        ]
    }
}
