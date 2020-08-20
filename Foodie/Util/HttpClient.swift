//
//  HttpClient.swift
//  Foodie
//
//  Created by Prabhakar Annavi on 19/08/20.
//  Copyright © 2020 Prabhakar Annavi. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

typealias HTTPHeaders = [String: String]
typealias Parameters = [String: Any]

public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
}

class HttpClient {

    let session =  SessionManager.default

    ///Get request
    func getRequest(url: String, headers: HTTPHeaders?, parameters: Parameters?, sucCompletionHandler: @escaping (JSON) -> (), error: @escaping (String) -> ()) {

        var urlComponents = URLComponents(string: url)

        var queryItems = [URLQueryItem]()

        urlComponents?.queryItems = nil

        if let param = parameters, !param.isEmpty {
            for (key, value) in param {
                queryItems.append(URLQueryItem(name: key, value: value as? String))

            }

            urlComponents?.queryItems = queryItems

        }


        guard let url_comp_url = urlComponents?.url else { return }
        //        print("createdURL",url_comp_url)

        var urlReq = URLRequest.init(url: url_comp_url)
        urlReq.allHTTPHeaderFields = headers
        urlReq.httpMethod = HTTPMethod.get.rawValue
        urlReq.httpBody = nil             // Get request no need of body
        urlReq.cachePolicy = .reloadIgnoringLocalCacheData

        print("***GetRequestURL***",urlReq)

        session.request(urlReq).responseString { (response) in

            if let responseString = response.result.value {
                if let encodedString = responseString.data(using: String.Encoding.utf8) {
                    do {
                        let responseJson = try JSON(data: encodedString)

                        switch response.result {
                        case .success:
                            print("SUCCESS")

                            sucCompletionHandler(responseJson)

                        case .failure:
                            print("FAILURE")
                            error("Failure")
//                            failCompletionHandler(responseJson)
                        }

                    } catch let errorResp {
                        error(String(errorResp.localizedDescription))
                        print("Error Converting data to JSON", errorResp.localizedDescription)
                    }
                } else {
                    error("Response not in correct format")

                    print("Response cannot be convert to data", responseString)
                }
            } else {
                error("Response failure or bad request")
                print("Response failure or bad request", response.result)
            }
        }

    }


    ///Downloads images from URL
    func downloadImage(fromURL: String, responseHandler: @escaping (Data?) -> ()) {

        let urlComponents = URLComponents(string: fromURL)
        guard let url = urlComponents?.url else { return }

        print("image_url-->", fromURL)

        URLSession.shared.dataTask(with: url) { (data, resp, error) in
            print("data", data)
            responseHandler(data)
            }.resume()

    }

}
