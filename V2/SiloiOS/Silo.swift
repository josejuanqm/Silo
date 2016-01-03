//
//  Silo.swift
//  Silo
//
//  Created by Jose Quintero on 1/2/16.
//  Copyright © 2016 Quintero. All rights reserved.
//

import Foundation
import UIKit

public class SiloView: UIView, NSURLSessionDelegate{
    //public
    var loaderColor: UIColor! = UIColor.darkGrayColor()
    ///////////////////
    
    //private
    private var progress: Float! = 0
    private var runned = true
    private var url: String!
    private var parent: UIImageView!
    //////////
    
    public func fetch(url: String, parent: UIImageView){
        self.backgroundColor = parent.backgroundColor
        self.url = url
        self.parent = parent
        runned = false
        self.setNeedsDisplay()
    }
    
    private var downloadTask: NSURLSessionDownloadTask?
    
    override public func drawRect(rect: CGRect) {
        let bounds = self.bounds
        drawProgressLoader(frame: CGRectMake((bounds.width / 2) - 20, (bounds.height / 2) - 20, 40, 40), shapeColor: self.loaderColor, progressFraction: CGFloat(self.progress))
        if runned == false{
            createDownloadTask(url)
            runned = true
        }
    }
    
    func fetchUrl(url:String){
        self.url = url
        runned = false
        self.setNeedsDisplay()
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
            progressInternal = self.progress + 0.2
            if progressInternal > 1{
                progressInternal = 0
            }
        }
        self.progress = progressInternal
        self.setNeedsDisplay()
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        if self.progress == 1 {
            let img = UIImage(data: NSData(contentsOfURL: location)!)
            print(parent)
            self.parent.image = img
            
            self.removeFromSuperview()
        }
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        if error != nil{
            print("fail")
        }
    }
}

extension SiloView{
    func drawProgressLoader(frame frame: CGRect = CGRectMake(0, 0, 200, 200), shapeColor: UIColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000), progressFraction: CGFloat = 0) {
        let expression: CGFloat = progressFraction != 0 ? progressFraction * -360 : 1
        
        
        let ovalPath = UIBezierPath(ovalInRect: CGRectMake(frame.minX + floor(frame.width * 0.05500 + 0.5), frame.minY + floor(frame.height * 0.05000 + 0.5), floor(frame.width * 0.95000 + 0.5) - floor(frame.width * 0.05500 + 0.5), floor(frame.height * 0.94500 + 0.5) - floor(frame.height * 0.05000 + 0.5)))
        shapeColor.setStroke()
        ovalPath.lineWidth = 5
        ovalPath.stroke()
        
        let oval2Rect = CGRectMake(frame.minX + floor(frame.width * 0.10500 + 0.5), frame.minY + floor(frame.height * 0.10000 + 0.5), floor(frame.width * 0.90000 + 0.5) - floor(frame.width * 0.10500 + 0.5), floor(frame.height * 0.89500 + 0.5) - floor(frame.height * 0.10000 + 0.5))
        let oval2Path = UIBezierPath()
        oval2Path.addArcWithCenter(CGPointMake(oval2Rect.midX, oval2Rect.midY), radius: oval2Rect.width / 2, startAngle: -1 * CGFloat(M_PI)/180, endAngle: -expression * CGFloat(M_PI)/180, clockwise: true)
        oval2Path.addLineToPoint(CGPointMake(oval2Rect.midX, oval2Rect.midY))
        oval2Path.closePath()
        
        shapeColor.setFill()
        oval2Path.fill()
    }
}