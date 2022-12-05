//
//  Base64Convert.swift
//  PicMorph
//
//  Created by Alina Sitsko on 28.11.22.
//

import UIKit

class Base64Convert {
    
    func convertImageToBase64(morphImage: UIImage?) -> String {
        guard let image = morphImage else { return "image not found" }
        UIGraphicsBeginImageContext(image.size)
        image.draw(at: .zero)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let finalImage = newImage  else { return "image not found"}
        let imageData = finalImage.jpegData(compressionQuality: 1)
        let convertedToString = imageData?.base64EncodedString()
        //                print( convertedToString ?? "Could not encode image to Base64")
        return convertedToString ?? "Could not encode image to Base64"
    }
    
    func convertBase64ToImage(base64String: String) -> UIImage {
        guard let stringData = Data(base64Encoded: base64String),
              let image = UIImage(data: stringData) else {
            return UIImage(named: "errorPic")! }
        return image
        
    }
    
}
