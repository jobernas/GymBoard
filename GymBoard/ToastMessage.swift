//
//  ToastMessage.swift
//  GymBoard
//
//  Created by João Luís on 11/04/17.
//  Copyright © 2017 JoBernas. All rights reserved.
//
import Foundation
import UIKit

class Toast {
    
    static let FONT_SIZE:CGFloat = 12.0
    
    static func showMessage(message: String, context: UIViewController){
        let toastLabel = UILabel(frame: CGRect(x: context.view.frame.size.width/2 - 100, y: context.view.frame.size.height-200, width: 200, height: 30))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont(name: "Montserrat-Light", size: Toast.FONT_SIZE)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds =  true
        toastLabel.numberOfLines = Toast.getNumberOfLines(label: toastLabel)
        //Adjust Height
        var newFrame :CGRect = toastLabel.frame;
        newFrame.size.height = toastLabel.frame.height * CGFloat(toastLabel.numberOfLines);
        toastLabel.frame = newFrame
        
        context.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.5, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    static func getNumberOfLines(label:UILabel) -> Int {
        let textSize = CGSize(width: CGFloat(label.frame.size.width), height: CGFloat(MAXFLOAT))
        let rHeight:Int = lroundf(Float(label.sizeThatFits(textSize).height))
        let numLines:Int = Int(ceil(Double(CGFloat(rHeight)/Toast.FONT_SIZE)))
        return numLines
        
    }

}
