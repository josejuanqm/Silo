//
//  OdyExt.swift
//  Ody
//
//  Created by Jose Quintero on 1/2/16.
//  Copyright © 2016 Quintero. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView{
    
    func setLoaderColorForSiloView(color: UIColor) -> Bool{
        for i in 0..<self.subviews.count{
            if let sView = self.subviews[i] as? SiloView{
                sView.loaderColor = color
                return true
            }
        }
        return false
    }
    
    func toSiloView(withUrl: String){
        for i in 0..<self.subviews.count{
            if let sView = self.subviews[i] as? SiloView{
                sView.removeFromSuperview()
            }
        }
        self.clipsToBounds = true
        let cM = self
        let siloView = SiloView(frame: CGRectMake(0, 0, cM.bounds.width, cM.bounds.height))
        siloView.fetch(withUrl, parent: cM)
        self.addSubview(siloView)
    }

}