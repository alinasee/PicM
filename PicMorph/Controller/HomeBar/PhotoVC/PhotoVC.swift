//
//  PhotoVC.swift
//  PicMorph
//
//  Created by Alina Sitsko on 25.11.22.
//

import UIKit

class PhotoVC: UIViewController {
    
    var effect: Effect?
    
    private var morphImage: UIImage?
    private let errorPic = UIImage(named: "errorPic")!
//    можно будет удалить свойство выше
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
        sendPayloadToRequest()
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
    
    func sendPayloadToRequest() {
        self.activityRing.startAnimating()
        if let effectPayload = effect?.payloadVersion {
            switch effectPayload {
            case "version 1 (🔺 stylization, 🔻 robustness)", "version 2 (🔺 robustness,🔻 stylization)":
                animeGanRequest(sessionHash: sessionHash, payloadVersion: effectPayload)
            case "version 0.2", "version 0.3", "version 0.4":
                arcaneGanRequest(sessionHash: sessionHash, payloadVersion: effectPayload)
            case "JoJo", "Disney", "Arcane Multi", "Art", "Spider-Verse":
                jojoGanRequest(sessionHash: sessionHash, payloadVersion: effectPayload)
            default:
                print ("error, payload did not find")
            }
        }
        
    }
    
    func animeGanRequest(sessionHash: String, payloadVersion: String) {
        NetworkManager.postAnimeGan (sessionHash: sessionHash, payloadVersion: payloadVersion) { responce in
            guard let hash  = responce.hash else { return }
            var counter = 0
            Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
                if counter <= 6 {
                    NetworkManager.statusAnimeGan (hash: hash) { [weak self] statusResponse in
                        if statusResponse.status == "COMPLETE" {
                            self?.activityRing.stopAnimating()
                            timer.invalidate()
                            guard let receivedArray = statusResponse.data?.data else { return }
                            let string = receivedArray[0]
                            let beginningOfSentence = string.lastIndex(of: ",")!
                            let slycedSentence = string[string.index(beginningOfSentence, offsetBy: 1)...]
                            let realString = String(slycedSentence)
                            let image = self?.convertBase64ToImage(base64String: realString )
                            let resultVC = ResultVC(nibName: (String(describing: ResultVC.self)), bundle: nil)
                            resultVC.image = image
                            self?.present(resultVC, animated: true)
                        } else {
                            let alert  = UIAlertController(title: nil, message: "Проблемы соединения с сервером", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "Продолжить", style: .default) { _ in self?.sendPayloadToRequest()
                            }
                            let cancelAction = UIAlertAction(title: "Отменить", style: .destructive) { _ in
                                self?.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
                            }
                            alert.addAction(okAction)
                            alert.addAction(cancelAction)
                            self?.present(alert, animated: true)
                        }
                    } failure: {
                        print("все плохо")
                        counter += 1
                    }
                } else {
                    timer.invalidate()}
            }
        } failure: {
            print("хэш не получен")
        }
    }
    
    func arcaneGanRequest(sessionHash: String, payloadVersion: String) {
        NetworkManager.postArcaneGan (sessionHash: sessionHash, payloadVersion: payloadVersion) { responce in
            guard let hash  = responce.hash else { return }
            var counter = 0
            Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
                if counter <= 6 {
                    NetworkManager.statusArcaneGan (hash: hash) { [weak self] statusResponse in
                        if statusResponse.status == "COMPLETE" {
                            self?.activityRing.stopAnimating()
                            timer.invalidate()
                            guard let receivedArray = statusResponse.data?.data else { return }
                            let string = receivedArray[0]
                            let beginningOfSentence = string.lastIndex(of: ",")!
                            let slycedSentence = string[string.index(beginningOfSentence, offsetBy: 1)...]
                            let realString = String(slycedSentence)
                            let image = self?.convertBase64ToImage(base64String: realString )
                            let resultVC = ResultVC(nibName: (String(describing: ResultVC.self)), bundle: nil)
                            resultVC.image = image
                            self?.present(resultVC, animated: true)
                        } else {
                            let alert  = UIAlertController(title: nil, message: "Проблемы соединения с сервером", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "Продолжить", style: .default) { _ in self?.sendPayloadToRequest()
                            }
                            let cancelAction = UIAlertAction(title: "Отменить", style: .destructive) { _ in
                                self?.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
                            }
                            alert.addAction(okAction)
                            alert.addAction(cancelAction)
                            self?.present(alert, animated: true)
                        }
                    } failure: {
                        print("все плохо")
                        counter += 1
                    }
                } else {
                    timer.invalidate()}
            }
        } failure: {
            print("хэш не получен")
        }
    }
    
    func jojoGanRequest(sessionHash: String, payloadVersion: String) {
        NetworkManager.postJojoGan(sessionHash: sessionHash, payloadVersion: payloadVersion) { response in
            guard let receivedArray = response.data else { return }
            self.activityRing.stopAnimating()
            let string = receivedArray[0]
            let beginningOfSentence = string.lastIndex(of: ",")!
            let slycedSentence = string[string.index(beginningOfSentence, offsetBy: 1)...]
            let realString = String(slycedSentence)
            let image = self.convertBase64ToImage(base64String: realString )
            let resultVC = ResultVC(nibName: (String(describing: ResultVC.self)), bundle: nil)
            resultVC.image = image
            self.present(resultVC, animated: true)
            
        } failure: {
            print("ответ не получен")
        }
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
