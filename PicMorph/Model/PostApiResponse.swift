//
//  PostApiResponse.swift
//  PicMorph
//
//  Created by Alina Sitsko on 28.11.22.
//

import Foundation
import ObjectMapper

class PostJoJoApiModel: Mappable {
    var data:[String]!
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        data              <- map ["data"]
    }
    
}

class PostApiResponseModel: Mappable {
    var hash: String!
    var queuePosition: Int!
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        hash             <- map ["hash"]
        queuePosition    <- map ["queue_position"]
    }
}


class StatusApiResponseModel: Mappable {
    var status: String!
    var data: NestedServerData?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        status             <- map ["status"]
        data               <- map ["data"]
    }
}

class NestedServerData: Mappable {
    var data = [String]()
    var duration = 0.0
    var averageDuration = 0.0
    
    required init?(map: Map) {
        mapping(map: map)
    }
    func mapping(map: Map) {
        data             <- map ["data"]
        duration         <- map ["duration"]
        averageDuration  <- map ["average_duration"]
    }
}

