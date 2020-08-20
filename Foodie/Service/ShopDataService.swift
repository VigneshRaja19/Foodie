//
//  ShopDataService.swift
//  Foodie
//
//  Created by Prabhakar Annavi on 19/08/20.
//  Copyright © 2020 Prabhakar Annavi. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol ShopDataServiceDelegate {
    func didGetShopData(shopData: [ShopModel])
    func didFinishWithError(msg: String)
}

class ShopDataService {

    var delegate: ShopDataServiceDelegate?
    let httpClient = HttpClient()
    func getShopData() {
        let url = "https://foodie.deliveryventure.com/shops/data"

        httpClient.getRequest(url: url, headers: nil, parameters: nil, sucCompletionHandler: { (response) in
            print("Received",response)
            let store = ShopStore()
            store.setData(jsonObj: response)
            self.delegate?.didGetShopData(shopData: store.shops)
        }) { (error) in
            //Toast
            self.delegate?.didFinishWithError(msg: "Failed to load data")
        }
    }

}
