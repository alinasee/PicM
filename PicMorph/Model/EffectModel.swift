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
    let payloadVersion: String
}

class EffectModel {
    var effects = [Effect]()
    
    init() {
        setup()
    }
    
    func setup() {
        let firstEffect = Effect(name: "Watercolour", image: "ef1", payloadVersion: "version 1 (🔺 stylization, 🔻 robustness)")
        let secondEffect = Effect(name: "Romantic", image: "ef2", payloadVersion: "version 2 (🔺 robustness,🔻 stylization)")
        let thirdEffect = Effect(name: "Dramatic", image: "ef3", payloadVersion: "version 0.2")
        let fourthEffect = Effect(name: "Sinister", image: "ef4", payloadVersion: "version 0.3")
        let fifthEffect = Effect(name: "Mysterious", image: "ef5", payloadVersion: "version 0.4")
        let sixthEffect = Effect(name: "Сomics", image: "ef6", payloadVersion: "JoJo")
        let seventhEffect = Effect(name: "Disney", image: "ef7", payloadVersion: "Disney")
        let eighthEffect = Effect(name: "Artistic", image: "ef8", payloadVersion: "Yasuho")
        let ninthEffect = Effect(name: "Aesthetic", image: "ef9", payloadVersion: "Arcane Multi")
        let tenthEffect = Effect(name: "Sensual", image: "ef10", payloadVersion: "Art")
        let eleventhEffect = Effect(name: "Arcane", image: "ef11", payloadVersion: "Spider-Verse")
        
        self.effects = [firstEffect, secondEffect, thirdEffect, fourthEffect, fifthEffect, sixthEffect, seventhEffect, eighthEffect, ninthEffect, tenthEffect, eleventhEffect]
    }
}
