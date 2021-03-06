//
//  WBBubblePopUp.swift
//  Pods
//
//  Created by Willy Breitenbach on 24.10.16.
//
//Copyright (c) 2016 Willy Breitenbach <willyb@live.de>
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.
//
//

import UIKit

open class WBBubblePopUp: UIView {
    
    // private properties
    
    var popUpLabel : UILabel! // Label
    //
    //    // public properties
    public var timeToDisappear = 2.0   // Default time to disappear
    
    override init(frame : CGRect){
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init() {
        // init with frame, set background color and corner radius
        self.init(frame: CGRect(x: 0, y: 70, width: 30, height: 30))
        super.backgroundColor = UIColor.blue
        super.layer.cornerRadius = 15
        
        popUpLabel = UILabel(frame: CGRect(origin: CGPoint(x: 10,y: 5), size: CGSize(width: 100, height: 30)))
        popUpLabel.textColor = .white
        popUpLabel.textAlignment = .center
        popUpLabel.lineBreakMode = .byWordWrapping
        
        
        self.addSubview(popUpLabel)
    }
    
    // set text of bubble
    open func setText(_ text: String){
        
        popUpLabel.text = text
        popUpLabel.sizeToFit()
        
        updateFrame()
        showAnimated()
    }
    
    // set properties
    
    open func setColorBackground(_ color: UIColor){
        super.backgroundColor = color
    }
    
    open func setColorText(_ color: UIColor){
        popUpLabel.textColor = color
    }
    
    open func setCornerRadius(_ radius: CGFloat){
        super.layer.cornerRadius = radius
    }
    
    // update size of buuble frame and text frame
    func updateFrame(){
        let screenSize = UIScreen.main.bounds
        
        // line of text wider than screen
        if self.popUpLabel.frame.size.width+20 >= screenSize.width {
            popUpLabel.numberOfLines = 0
            popUpLabel.frame.size.width = screenSize.width-40
            popUpLabel.sizeToFit()
            self.frame.size.width = screenSize.width-20
            self.frame.size.height = (self.popUpLabel.frame.size.height) + 10
        }
        else{
            self.frame.size.width = self.popUpLabel.frame.size.width+20
            self.frame.size.height = self.popUpLabel.frame.size.height+10
        }
        
        
        self.frame.origin = CGPoint(x: screenSize.width/2-self.frame.size.width/2, y: 70)
    }
    
    // animate up to down
    func showAnimated(){
        
        self.frame.origin.y = -50
        
        UIView.animate(withDuration: 0.2, animations: {
            self.frame.origin.y = 70
        }, completion: {
            (value: Bool) in
            
            let _ = DispatchTime(uptimeNanoseconds: UInt64(Int64(self.timeToDisappear * Double(NSEC_PER_SEC))))
            //let delayTime = DispatchTime.now(DispatchTime.now, Int64(self.timeToDisappear * Double(NSEC_PER_SEC)))
            DispatchQueue.main.asyncAfter(deadline: .now() + self.timeToDisappear) { // in half a second...
                self.removeAnimated()
            }
            //                DispatchQueue.asyncAfter(delayTime)
            //                dispatch_after(delayTime, DispatchQueue.main) {
            //                    self.removeAnimated()
            //                }
        })
    }
    
    func removeAnimated(){
        
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.frame.origin.y = -70
        }, completion: {
            (value: Bool) in
            self.removeFromSuperview()
        })
    }
}
