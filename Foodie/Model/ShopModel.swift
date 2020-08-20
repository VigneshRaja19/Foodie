//
//  ShopModel.swift
//  Foodie
//
//  Created by Prabhakar Annavi on 19/08/20.
//  Copyright © 2020 Prabhakar Annavi. All rights reserved.
//

import Foundation
struct ShopModel {
    var id: Int
    var name: String
    var email: String
    var phone, avatar, default_banner, description, address, maps_address: String
    var latitude, longitude: Double
    var device_type: String
}
