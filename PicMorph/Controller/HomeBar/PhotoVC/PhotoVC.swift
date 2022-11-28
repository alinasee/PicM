//
//  PhotoVC.swift
//  PicMorph
//
//  Created by Alina Sitsko on 25.11.22.
//

import UIKit

class PhotoVC: UIViewController {
    
    private var effect: Effect?
    private var morphImage: UIImage?
    private let errorPic = UIImage(named: "errorPic")!
    private var imageBase64Received: UIImage?
    private var sessionHash: String!
    static var imageBase64toSend: String!
    
    @IBOutlet weak var effectPicImage: UIImageView!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var chosenPhotoImage: UIImageView!
    @IBOutlet weak var activityRing: UIActivityIndicatorView!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var morphButton: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        morphImage = nil
        if chosenPhotoImage.image == nil {
            morphButton.isEnabled = false
        }
    }
    
    @IBAction func takePhotoAction(_ sender: Any) {
        let cameraVC = UIImagePickerController()
        cameraVC.sourceType = .camera
        cameraVC.delegate = self
        present(cameraVC, animated: true)
    }
    
    @IBAction func selectPhotoAction(_ sender: Any) {
        let imageVC = UIImagePickerController()
        imageVC.delegate = self
        present(imageVC, animated: true)
    }
    
    @IBAction func morphAction(_ sender: Any) {
    }
    
    
}

private extension PhotoVC {
    
    func setupUI(){
        effectPicImage .layer.cornerRadius = 8
        effectPicImage.layer.borderWidth = 1
        effectPicImage.layer.borderColor = UIColor.darkGray.cgColor
        if let image = effect?.image {
            effectPicImage.image = UIImage(named: image) }
        
        backImage.image = UIImage(named: "placeholder-1")
        backImage.layer.cornerRadius = 8
        backImage.layer.borderWidth = 2
        backImage.layer.borderColor = UIColor.systemGray2.cgColor
        backLabel.textColor = UIColor.systemGray
        
        morphButton.layer.cornerRadius = 8
        morphButton.layer.borderWidth = 1
        morphButton.layer.borderColor = UIColor.systemGray2.cgColor
        
        chosenPhotoImage.layer.cornerRadius = 8
        chosenPhotoImage.layer.borderWidth = 1
        chosenPhotoImage.layer.borderColor = UIColor.systemGray2.cgColor
        chosenPhotoImage.layer.cornerRadius = 8
    }
    
    func generateRandomString() {
        let charSet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let charactersArray = Array(charSet)
        var randomString: String = ""
        for _ in (1...11) {
            randomString.append(charactersArray[Int(arc4random()) % charactersArray.count])
        }
        sessionHash = randomString
    }
        
    func convertImageToBase64(){
        guard let image = morphImage else { return }
        UIGraphicsBeginImageContext(image.size)
        image.draw(at: .zero)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let finalImage = newImage {
            let imageData = finalImage.jpegData(compressionQuality: 1)
            PhotoVC.imageBase64toSend = imageData?.base64EncodedString()
            print( PhotoVC.imageBase64toSend ?? "Could not encode image to Base64")
        }
    }
    
    func convertBase64ToImage(base64String: String) -> UIImage {
        guard let stringData = Data(base64Encoded: base64String),
              let image = UIImage(data: stringData) else {
            return errorPic }
        return image
        
    }
}

extension PhotoVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage {
            chosenPhotoImage.image = image
            morphImage = image
            convertImageToBase64()
            generateRandomString()
            if chosenPhotoImage.image != nil {
                morphButton.isEnabled = true
            }
        }
        picker.dismiss(animated: true)
    }
}
