//
//  ViewController.swift
//  bi-ios-recognizers
//
//  Created by Dominik Vesely on 03/11/15.
//  Copyright © 2015 Ackee s.r.o. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PanelViewDelegate, SettingsViewDelegate {
    
    weak var graphView : GraphView!
    weak var panelView : PanelView!
    weak var settingsView : SettingsView!
    
    
    var center : CGPoint = CGPoint(x: 0,y: 0)

    
    override func loadView() {
        self.view = UIView()
        view.backgroundColor = .whiteColor()
        
        
        
        // graph view
        let gv = GraphView(frame: CGRectZero)
        gv.autoresizingMask = UIViewAutoresizing.FlexibleWidth;
        
        self.view.addSubview(gv)
        self.graphView = gv
        
        
        
        
        // panel view
        let pv = PanelView(frame: CGRectZero)
        pv.autoresizingMask = UIViewAutoresizing.FlexibleWidth;
        pv.delegate = self
        
        
        
        
        //toto asi zmeni hodnotu ked sa zmeni slider
        pv.onSliderChange = { [weak self]  (value : CGFloat) in
            self?.graphView.amplitude = value
        }
        
        view.addSubview(pv)
        panelView = pv
        
        
        // settings view
        
        let sv = SettingsView(frame: CGRectZero)
        sv.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        
        sv.settingsDelegate = self
        
        self.view.addSubview(sv)
        self.settingsView = sv
        
    }
    
    
    
    
    //MARK: PanelViewDelegate
    func sliderDidChange(slider: UISlider, panel: PanelView) {
       // self.graphView.amplitude = CGFloat(slider.value);
        
    }
    
    func stepperDidChange(stepper: UIStepper, panel: PanelView) {
        self.graphView.period = CGFloat(stepper.value);
        
    }
    
    func napisNiecoDoKokotiny(nieco: String) {
        print(nieco)
    }
    
    func changeTileBackground(background: UIColor) {
        graphView.backgroundColor = background
    }
    
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.graphView.frame = CGRectMake(8, 20 + 8, CGRectGetWidth(self.view.bounds) - 16, 200);
        self.panelView.frame = CGRectMake(8, 20 + 16 + 200, CGRectGetWidth(self.view.bounds) - 16, 128);
        self.settingsView.frame = CGRectMake(8, 20 + 24 + 200 + 128, CGRectGetWidth(self.view.bounds) - 16, 200)
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapReco = UITapGestureRecognizer(target: self,
            action: "tapReco:")
        tapReco.numberOfTapsRequired = 1
        tapReco.numberOfTouchesRequired = 1
        
        let doubleTapReco = UITapGestureRecognizer(target: self,
            action: "doubleTapReco:")
        doubleTapReco.numberOfTapsRequired = 2
        
        tapReco.requireGestureRecognizerToFail(doubleTapReco)
        
        self.view.addGestureRecognizer(doubleTapReco)
        self.view.addGestureRecognizer(tapReco)
        
        let panReco = UIPanGestureRecognizer(target: self
            , action: "pan:")
        graphView.addGestureRecognizer(panReco);
        
        
    }
    
    func tapReco(reco : UITapGestureRecognizer) {
       // print(reco.view)
        print("tapped")
    }
    
    func doubleTapReco(reco : UITapGestureRecognizer) {
        print("Double tapped")
    }
    
    
    func pan(reco : UIGestureRecognizer) {
        let point = reco.locationInView(self.panelView)
        
        switch(reco.state) {
        case .Began: break;
        case .Changed:
            self.graphView.offset = self.graphView.center.y
                + point.y
        default:
            return
        }
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

