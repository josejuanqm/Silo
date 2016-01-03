//
//  Silo.swift
//  Silo
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
        siloView.backgroundColor = self.backgroundColor
        siloView.opaque = false
        siloView.fetch(withUrl, parent: cM)
        self.addSubview(siloView)
    }
    
    func toSiloView(withUrl: String, loaderColor: UIColor){
        for i in 0..<self.subviews.count{
            if let sView = self.subviews[i] as? SiloView{
                sView.removeFromSuperview()
            }
        }
        self.clipsToBounds = true
        let cM = self
        let siloView = SiloView(frame: CGRectMake(0, 0, cM.bounds.width, cM.bounds.height))
        siloView.backgroundColor = self.backgroundColor
        siloView.opaque = false
        siloView.fetch(withUrl, parent: cM)
        self.addSubview(siloView)
        self.setLoaderColorForSiloView(loaderColor)
    }
    
}

internal class SiloView: UIView, NSURLSessionDelegate{
    //public
    var loaderColor: UIColor! = UIColor.darkGrayColor()
    ///////////////////
    
    //private
    private var progress: Float! = 0
    private var runned = true
    private var url: String!
    private var parent: UIImageView!
    //////////
    
    internal func fetch(url: String, parent: UIImageView){
        self.backgroundColor = parent.backgroundColor
        self.url = url
        self.parent = parent
        runned = false
        self.setNeedsDisplay()
    }
    
    private var downloadTask: NSURLSessionDownloadTask?
    
    override internal func drawRect(rect: CGRect) {
        let bounds = self.bounds
        drawProgressLoader(frame: bounds, shapeColor: self.loaderColor, progressFraction: CGFloat(self.progress))
        if runned == false{
            createDownloadTask(url)
            runned = true
        }
    }
    
    func createDownloadTask(url: String) {
        let downloadRequest = NSMutableURLRequest(URL: NSURL(string: url)!)
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        
        downloadTask = session.downloadTaskWithRequest(downloadRequest)
        downloadTask!.resume()
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        var progressInternal = Float(0)
        if (totalBytesExpectedToWrite != -1){
            progressInternal = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        }else {
            progressInternal = self.progress + 0.1
            if progressInternal > 1{
                progressInternal = 0
            }
        }
        self.progress = progressInternal
        self.setNeedsDisplay()
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        self.removeFromSuperview()
        let img = UIImage(data: NSData(contentsOfURL: location)!)
        print(parent)
        self.parent.image = img
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        if error != nil{
            print("fail")
        }
    }
}

extension SiloView{
    
    func drawProgressLoader(frame frame: CGRect = CGRectMake(0, 0, 200, 200), shapeColor: UIColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000), progressFraction: CGFloat = 0.793) {
        
        //// Variable Declarations
        let expression: CGFloat = progressFraction != 0 ? progressFraction * -360 : 1
        
        
        //// Subframes
        let group: CGRect = CGRectMake(frame.minX + floor((frame.width - 22) * 0.50000 + 0.5), frame.minY + floor((frame.height - 22) * 0.50000 + 0.5), 22, 22)
        
        
        //// Group
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: CGRectMake(group.minX, group.minY, 22, 22))
        shapeColor.setStroke()
        ovalPath.lineWidth = 2.5
        ovalPath.stroke()
        
        
        //// Oval 2 Drawing
        let oval2Rect = CGRectMake(group.minX + 1, group.minY + 1, 20, 20)
        let oval2Path = UIBezierPath()
        oval2Path.addArcWithCenter(CGPointMake(oval2Rect.midX, oval2Rect.midY), radius: oval2Rect.width / 2, startAngle: -1 * CGFloat(M_PI)/180, endAngle: -expression * CGFloat(M_PI)/180, clockwise: true)
        oval2Path.addLineToPoint(CGPointMake(oval2Rect.midX, oval2Rect.midY))
        oval2Path.closePath()
        
        shapeColor.setFill()
        oval2Path.fill()
    }
    
}