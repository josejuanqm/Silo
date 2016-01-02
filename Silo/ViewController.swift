//
//  ViewController.swift
//  Silo
//
//  Created by Jose Quintero on 1/1/16.
//  Copyright © 2016 Quintero. All rights reserved.
//

import UIKit
import SiloView

class ViewController: UIViewController {
    
    @IBOutlet var silo: SiloImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        silo.imageContentMode = .ScaleAspectFit
        silo.loaderColor = UIColor.darkGrayColor()
        silo.fetchUrl("http://images.apple.com/v/ipad-pro/c/images/overview/canvas_large_2x.jpg")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

