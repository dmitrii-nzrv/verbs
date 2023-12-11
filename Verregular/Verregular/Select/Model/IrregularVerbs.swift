//
//  IrregularVerbs.swift
//  Verregular
//
//  Created by Dmitrii Nazarov on 11.12.2023.
//

import Foundation

class IrregularVerbs {
    private(set) var verbs: [Verb] = []
    var selectedVerbs: [Verb] = []
    
    func configureVerbs() {
        verbs = [
            Verb(infinitive: "blow", pastSimple: "blew", pastParticiple: "blown"),
            Verb(infinitive: "blow", pastSimple: "blew", pastParticiple: "blown"),
            Verb(infinitive: "blow", pastSimple: "blew", pastParticiple: "blown"),
            Verb(infinitive: "blow", pastSimple: "blew", pastParticiple: "blown"),
            Verb(infinitive: "blow", pastSimple: "blew", pastParticiple: "blown"),
            Verb(infinitive: "blow", pastSimple: "blew", pastParticiple: "blown"),
            Verb(infinitive: "blow", pastSimple: "blew", pastParticiple: "blown"),
            Verb(infinitive: "blow", pastSimple: "blew", pastParticiple: "blown"),
            Verb(infinitive: "blow", pastSimple: "blew", pastParticiple: "blown"),
        
        ]
    }
}
