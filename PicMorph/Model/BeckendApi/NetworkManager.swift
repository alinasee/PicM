//
//  NetworkManager.swift
//  PicMorph
//
//  Created by Alina Sitsko on 28.11.22.
//

import Foundation
import Moya
import Moya_ObjectMapper

class NetworkManager {
    private static let provider = MoyaProvider<MorphApi>(plugins: [NetworkLoggerPlugin()])

    static func postAnimeGan( sessionHash: String, payloadVersion: String, success: ((PostApiResponseModel) -> ())?, failure: (() -> ())?) {
        let prefix = "data:image/jpeg;base64,"
        let data = [prefix + PhotoVC.imageBase64toSend, payloadVersion]
        provider.request(.postAnimeGan(data: data, sessionHash: sessionHash)) { result in
            switch result {
            case .success(let response):
                guard let responseInfo = try? response.mapObject(PostApiResponseModel.self) else {
                    print("Не удалось распарсить ответ от сервера")
                    failure?()
                    return
                }
                print("Удалось получить ответ от сервера.")
                success?(responseInfo)
            case .failure(let error):
                print(error.localizedDescription)
                failure?()
            }
        }
    }
    
    static func statusAnimeGan(hash: String, success: ((StatusApiResponseModel) -> ())?, failure: (() -> ())?) {
        provider.request(.statusAnimeGan(hash: hash)) { result in
            switch result {
            case .success(let response):
                guard let responseInfo = try? response.mapObject(StatusApiResponseModel.self) else {
                    print("Не удалось распарсить ответ от сервера")
                    failure?()
                    return
                }
                print("Удалось получить ответ от сервера.")
                print(try! response.mapJSON())
                success?(responseInfo)
            case .failure(let error):
                print(error.localizedDescription)
                failure?()
            }
        }
    }
    
    static func postArcaneGan( sessionHash: String, payloadVersion: String, success: ((PostApiResponseModel) -> ())?, failure: (() -> ())?) {
        let prefix = "data:image/jpeg;base64,"
        let data = [prefix + PhotoVC.imageBase64toSend, payloadVersion]
        provider.request(.postArcaneGan(data: data, sessionHash: sessionHash)) { result in
            switch result {
            case .success(let response):
                guard let responseInfo = try? response.mapObject(PostApiResponseModel.self) else {
                    print("Не удалось распарсить ответ от сервера")
                    failure?()
                    return
                }
                print("Удалось получить ответ от сервера.")
                success?(responseInfo)
            case .failure(let error):
                print(error.localizedDescription)
                failure?()
            }
        }
    }
    
    static func statusArcaneGan(hash: String, success: ((StatusApiResponseModel) -> ())?, failure: (() -> ())?) {
        provider.request(.statusArcaneGan(hash: hash)) { result in
            switch result {
            case .success(let response):
                guard let responseInfo = try? response.mapObject(StatusApiResponseModel.self) else {
                    print("Не удалось распарсить ответ от сервера")
                    failure?()
                    return
                }
                print("Удалось получить ответ от сервера.")
                print(try! response.mapJSON())
                success?(responseInfo)
            case .failure(let error):
                print(error.localizedDescription)
                failure?()
            }
        }
    }
    
    static func postJojoGan( sessionHash: String, payloadVersion: String, success: ((PostJoJoApiModel) -> ())?, failure: (() -> ())?) {
        let prefix = "data:image/jpeg;base64,"
        let data = [prefix + PhotoVC.imageBase64toSend, payloadVersion]
        provider.request(.postJojoGan(data: data, sessionHash: sessionHash)) { result in
            switch result {
            case .success(let response):
                guard let responseInfo = try? response.mapObject(PostJoJoApiModel.self) else {
                    print("Не удалось распарсить ответ от сервера")
                    failure?()
                    return
                }
                print("Удалось получить ответ от сервера.")
                success?(responseInfo)
            case .failure(let error):
                print(error.localizedDescription)
                failure?()
            }
        }
    }
}
