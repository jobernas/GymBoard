//
//  SuperViewController.swift
//  GymBoard
//
//  Created by João Luís on 26/05/17.
//  Copyright © 2017 JoBernas. All rights reserved.
//

import UIKit

class SuperViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(String(describing: (type(of: self))) + " Did Load")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print(String(describing: (type(of: self))) + " Did Receive Memory Warning")

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("Debug VC -> " + String(describing: (type(of: self))) + " Did Layout Subviews")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Debug VC -> " + String(describing: (type(of: self))) + " Did Appear")
    }

    deinit {
        print("Debug VC -> " + String(describing: (type(of: self))) + " Destoyed")
    }
    
    //Default lock to Portrait
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        get {
            return .portrait
        }
    }
    
    //Default dont Rotate
    open override var shouldAutorotate: Bool {
        get {
            return false
        }
    }
    
    //Default set Preferred to Portrait
    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        get {
            return .portrait
        }
    }
    
}
