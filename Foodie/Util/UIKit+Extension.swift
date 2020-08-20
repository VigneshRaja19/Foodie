//
//  UIKit+Extensions.swift
//  Foodie
//
//  Created by Prabhakar Annavi on 20/08/20.
//  Copyright © 2020 Prabhakar Annavi. All rights reserved.
//

import UIKit

extension UIViewController {

    func showCustomToast(message : String, backColor: UIColor) {

        let toastLabel = UILabel()
        toastLabel.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 250, width: 330, height: 40)
        toastLabel.text = message
        toastLabel.numberOfLines = 0

        //To resize and center the label with desired width
        toastLabel.sizeThatFits(CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        print("ToastFrameAfterSizeToFit-->", toastLabel.frame)

        toastLabel.center.x = UIScreen.main.bounds.width/2
        toastLabel.backgroundColor = backColor
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 14)

        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 5
        toastLabel.clipsToBounds  =  true

        self.view.addSubview(toastLabel)

        UIView.animate(withDuration: 1.3, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIView.AnimationOptions.curveEaseInOut, animations: {

            toastLabel.frame.origin.y -= 50

        }) { (isCompleted) in
            _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (timer) in

                toastLabel.alpha = 0.0

                toastLabel.removeFromSuperview()

                timer.invalidate()
            })
        }

    }

}
