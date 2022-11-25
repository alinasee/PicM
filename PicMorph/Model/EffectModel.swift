//
//  EffectModel.swift
//  PicMorph
//
//  Created by Alina Sitsko on 25.11.22.
//

import Foundation

struct Effect {
    let name: String
    let image: String
}

class EffectModel {
    var effects = [Effect]()
    
    init() {
        setup()
    }
    
    func setup() {
        let firstEffect = Effect(name: "Watercolour", image: "ef1")
        let secondEffect = Effect(name: "Romantic", image: "ef2")
        let thirdEffect = Effect(name: "Dramatic", image: "ef3")
        let fourthEffect = Effect(name: "Sinister", image: "ef4")
        let fifthEffect = Effect(name: "Mysterious", image: "ef5")
        let sixthEffect = Effect(name: "Сomics", image: "ef6")
        let seventhEffect = Effect(name: "Disney", image: "ef7")
        let eighthEffect = Effect(name: "Artistic", image: "ef8")
        let ninthEffect = Effect(name: "Aesthetic", image: "eа9")
        let tenthEffect = Effect(name: "Sensual", image: "ef10")
        let eleventhEffect = Effect(name: "Arcane", image: "ef11")
        
        self.effects = [firstEffect, secondEffect, thirdEffect, fourthEffect, fifthEffect, sixthEffect, seventhEffect, eighthEffect, ninthEffect, tenthEffect, eleventhEffect]
    }
}
