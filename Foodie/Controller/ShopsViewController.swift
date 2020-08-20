//
//  ViewController.swift
//  Foodie
//
//  Created by Prabhakar Annavi on 19/08/20.
//  Copyright © 2020 Prabhakar Annavi. All rights reserved.
//

import UIKit

class ShopsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var segment: UISegmentedControl!
    let shopService = ShopDataService()
    var shops = [ShopModel]()

    var shops_showing = [ShopModel]()

    var imageCache = NSCache<AnyObject, UIImage>()

    let httpClient = HttpClient()

    override func viewDidLoad() {
        super.viewDidLoad()

        shopService.delegate = self
        shopService.getShopData()

    }

    @IBAction func segmentAction(_ sender: Any) {
        switch segment.selectedSegmentIndex {
        case 0:
            shops_showing = shops
            tableView.reloadData()
            break
        case 1:
            shops_showing = shops.filter { (model) -> Bool in
                return model.device_type == "ios"
            }
            tableView.reloadData()
            break
        case 2:
            shops_showing = shops.filter { (model) -> Bool in
                return model.device_type == "android"
            }
            tableView.reloadData()
            break
        default:
            break
        }
    }

    @IBAction func locateAction(_ sender: Any) {
        if !shops.isEmpty {
            self.performSegue(withIdentifier: "mapSegue", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.destination is MapViewController {
            let vc = segue.destination as! MapViewController
            vc.shops = self.shops
        }
    }

}
extension ShopsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection", shops_showing.count)
        return shops_showing.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopTableViewCell") as! ShopTableViewCell
        cell.addressLabel.text = shops_showing[indexPath.row].address
        cell.shopNameLabel.text = shops_showing[indexPath.row].name

        let imgUrl = shops_showing[indexPath.row].avatar


        if let image = imageCache.object(forKey: imgUrl as AnyObject) {
            cell.imgView.image = image
        } else {
            httpClient.downloadImage(fromURL: imgUrl) { [weak self](data) in
                print("downloadImageData", data)
                if let d = data, let image = UIImage(data: d) {
                    print("downloadImage", image)

                    DispatchQueue.main.async {
                        self?.imageCache.setObject(image, forKey: imgUrl as AnyObject)
                        cell.imgView.image = image
                    }
                }
            }
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ShopsViewController: ShopDataServiceDelegate {
    func didGetShopData(shopData: [ShopModel]) {
        print("didGetShopData")
        DispatchQueue.main.async {
            self.shops = shopData
            self.shops_showing = self.shops
            self.tableView.reloadData()
        }

    }

    func didFinishWithError(msg: String) {
        self.showCustomToast(message: msg, backColor: .darkGray)
    }
}
