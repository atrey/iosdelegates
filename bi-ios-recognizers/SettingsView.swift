//
//  SettingsView.swift
//  codecamp-ios-3
//
//  Created by Praženica Andrej on 25/03/16.
//  Copyright © 2016 Ackee s.r.o. All rights reserved.
//

import Foundation
import UIKit


class SettingsView : UIView {
    
    let dataFromGraph = GraphView()
    
    var settingsDelegate : SettingsViewDelegate?
    
    
    
    weak var segmenter : UISegmentedControl!
    var labelAltitude : UILabel = UILabel()
    var labelPeriod: UILabel = UILabel()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGrayColor()
        
        
        //stepper
        //items 
        let items = ["Biela","Cierna","Modra"]
        let segmenter = UISegmentedControl(items: items)
        segmenter.selectedSegmentIndex = 0
        segmenter.addTarget(self, action: #selector(SettingsView.changeColor(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        addSubview(segmenter)
        self.segmenter = segmenter
        
        // label - altitude
        
        labelAltitude.text = "Amplituda je: \(dataFromGraph.labelAmplitudeOnGraph.text)"
        labelAltitude.textColor = UIColor.whiteColor()
        addSubview(labelAltitude)
        
        //label - period
        labelPeriod.text = "Perioda je: \(dataFromGraph.period)"
        labelPeriod.textColor = UIColor.whiteColor()
        addSubview(labelPeriod)
        
        
        
        
    }
    
    
    
    
        
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.segmenter.frame = CGRectMake(8, 8, CGRectGetWidth(self.bounds) - 16, 20);
        self.labelAltitude.frame = CGRectMake(8, 8 + 8 + 20, CGRectGetWidth(self.bounds) - 16 + 84, 20)
        
        //nastavenie kde ma byt polozeny ten label. 8 - zlava, 8+ 8+ 44+30 - zhora, nastavenie sirky - minus 16, pretoze to je zlava a zprava a 30 vyska
        
        self.labelPeriod.frame = CGRectMake(8, 8 + 8 + 20 + 20, CGRectGetWidth(self.bounds) - 16, 30)
        
        

    }
    
    func changeColor(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            print("Biela ciara")
            settingsDelegate?.changeTileBackground(UIColor.whiteColor())
            settingsDelegate?.changeLineColor(UIColor.whiteColor())
            
        case 1:
            print("Cierna ciara")
            settingsDelegate?.changeTileBackground(UIColor.blackColor())
            
        case 2:
            print("Modra ciara")
            settingsDelegate?.changeTileBackground(UIColor.blueColor())
            
        default:
            dataFromGraph.backgroundColor = UIColor.greenColor()
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

protocol SettingsViewDelegate {
    func changeTileBackground(background: UIColor)
    func changeLineColor(color: UIColor)
}


