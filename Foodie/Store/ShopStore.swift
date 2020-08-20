//
//  ShopStore.swift
//  Foodie
//
//  Created by Prabhakar Annavi on 20/08/20.
//  Copyright © 2020 Prabhakar Annavi. All rights reserved.
//

import Foundation
import SwiftyJSON

class ShopStore {

    private(set) var shops = [ShopModel]()

    func setData(jsonObj: JSON) {

        let jsonArr = jsonObj["shops"].arrayValue
        print("jsonArr.count", jsonArr.count)
        for i in 0..<jsonArr.count {

            let id = jsonArr[i]["id"].intValue
            let name = jsonArr[i]["name"].stringValue

            let email = jsonArr[i]["email"].stringValue

            let phone = jsonArr[i]["phone"].stringValue

            let avatar = jsonArr[i]["avatar"].stringValue

            let default_banner = jsonArr[i]["default_banner"].stringValue
            let description = jsonArr[i]["description"].stringValue
            let address = jsonArr[i]["address"].stringValue
            let maps_address = jsonArr[i]["maps_address"].stringValue
            let device_type = jsonArr[i]["device_type"].stringValue
            let latitude = jsonArr[i]["latitude"].doubleValue
            let longitude = jsonArr[i]["longitude"].doubleValue

            let model = ShopModel.init(id: id, name: name, email: email, phone: phone, avatar: avatar, default_banner: default_banner, description: description, address: address, maps_address: maps_address, latitude: latitude, longitude: longitude, device_type: device_type)


            shops.append(model)
        }
    }
}
