//
//  GraphView.swift
//  bi-ios-recognizers
//
//  Created by Dominik Vesely on 03/11/15.
//  Copyright © 2015 Ackee s.r.o. All rights reserved.
//

import Foundation
import UIKit

class GraphView : UIView {
    
    var graphDelegate : GraphViewDelegate?
    
    
    var amplitude : CGFloat = 40.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var period : CGFloat = 1.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var offset : CGFloat! = 0   {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var lineColor : UIColor! = UIColor.whiteColor()
    
    
    var labelAmplitudeOnGraph: UILabel = UILabel()
    var labelPeriodOnGraph: UILabel = UILabel()
    var labelOffsetOnGraph: UILabel = UILabel()
    
    
   
    override func layoutSubviews() {
        super.layoutSubviews()
        offset = CGRectGetHeight(self.bounds) / 2.0
        /* self.labelAmplitudeOnGraph.frame = CGRectMake(8, 8 + 8 + 20, CGRectGetWidth(self.bounds) - 16 + 84, 20)
        addSubview(labelAmplitudeOnGraph)
        self.labelPeriodOnGraph.frame = CGRectMake(8, 8 + 8 + 20 + 20, CGRectGetWidth(self.bounds) - 16 + 84, 20)
        addSubview(labelPeriodOnGraph)
        self.labelOffsetOnGraph.frame = CGRectMake(8, 8 + 8 + 20 + 20 + 20, CGRectGetWidth(self.bounds) - 16 + 84, 20)
        addSubview(labelOffsetOnGraph)
*/
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGrayColor()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func drawRect(rect: CGRect) {
        
        super.drawRect(rect)
        var context = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
        CGContextSetLineWidth(context, 3);
        CGContextMoveToPoint(context, 0, offset);
        for (var i : CGFloat = 0; i <  frame.width; i += 1) {
            let y = self.amplitude * sin(i/frame.width * period * 2 * CGFloat(M_PI)) + offset
            CGContextAddLineToPoint(context, i, y);
            labelAmplitudeOnGraph.text = "A: \(amplitude)"
            labelPeriodOnGraph.text = "P: \(period)"
            labelOffsetOnGraph.text = "O: \(offset)"
            
            graphDelegate?.dataAmplitude(labelAmplitudeOnGraph.text!)
            graphDelegate?.dataPeriod(labelPeriodOnGraph.text!)
            graphDelegate?.dataOffset(labelOffsetOnGraph.text!)
            
        }
        
        
        //CGContextSetLineJoin(context, CGLineJoin.Bevel)
        //CGContextSetLineCap(context, CGLineCap.Round)
        CGContextStrokePath(context);
    }
    
}

protocol GraphViewDelegate {
    func dataAmplitude(amplitude: String)
    func dataPeriod(period: String)
    func dataOffset(offset: String)
}


  