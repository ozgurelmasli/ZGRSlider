//
//  ViewController.swift
//  ZGRSlider
//
//  Created by Mac on 19.05.2021.
//

import UIKit

class ViewController: UIViewController {

    private var slider : ZGRSlider?
    private var slider_2 : ZGRSlider?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.setSlider()
        self.setSlider2()
    }
    private func setSlider(){
        self.slider = .init()
        self.slider?.delegate = self
        self.slider?.sliderBackgroundColor = UIColor.systemGreen.withAlphaComponent(0.6)
        self.slider?.sliderHeight = 5
        self.slider?.thumbColors = [UIColor.systemOrange , UIColor.systemOrange]
        self.slider?.endValue = 40
        self.slider?.starterValue = 0
        self.slider?.thumbValues = [20 , 35]
        self.slider?.thumbHeights = [30 , 30]
        self.slider?.thumbsMinDistance = 5
        self.slider?.thumbBorderWidths = [6.0 , 6.0]
        self.slider?.tag = 1
        self.slider?.thumbBorderColors = [UIColor.systemTeal , UIColor.systemTeal]
        
        self.view.addSubview(self.slider!)
        
        self.slider?.translatesAutoresizingMaskIntoConstraints = false
        
        self.slider?.leftAnchor.constraint(equalTo: self.view.leftAnchor , constant: 24).isActive = true
        self.slider?.rightAnchor.constraint(equalTo: self.view.rightAnchor , constant: -24).isActive = true
        
        self.slider?.centerYAnchor.constraint(equalTo: self.view.centerYAnchor , constant: -15).isActive = true
        self.slider?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.slider?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.slider?.layoutIfNeeded()
        
        self.slider?.configure()
    }
    private func setSlider2(){
        self.slider_2 = .init()
        self.slider_2?.delegate = self
        self.slider_2?.sliderBackgroundColor = UIColor.systemGreen.withAlphaComponent(0.6)
        self.slider_2?.sliderHeight = 5
        self.slider_2?.thumbColors = [UIColor.systemOrange , UIColor.systemOrange]
        self.slider_2?.endValue = 40
        self.slider_2?.starterValue = 0
        self.slider_2?.thumbsMinDistance = 5
        self.slider_2?.thumbValues = [20 , 35]
        self.slider_2?.thumbHeights = [30 , 30]
        self.slider_2?.thumbBorderWidths = [6.0 , 6.0]
        self.slider_2?.tag = 2
        self.slider_2?.thumbBorderColors = [UIColor.systemTeal , UIColor.systemTeal]
        
        self.view.addSubview(self.slider_2!)
        
        self.slider_2?.translatesAutoresizingMaskIntoConstraints = false
        
        self.slider_2?.leftAnchor.constraint(equalTo: self.view.leftAnchor , constant: 24).isActive = true
        self.slider_2?.rightAnchor.constraint(equalTo: self.view.rightAnchor , constant: -24).isActive = true
        
        self.slider_2?.topAnchor.constraint(equalTo: self.slider!.bottomAnchor , constant: 20).isActive = true
        self.slider_2?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.slider_2?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.slider_2?.layoutIfNeeded()
        
        self.slider_2?.configure()
    }

}

extension ViewController : ZGRSliderDelegete {
    func firstThumbValueChanged(value: Int, _ slider: ZGRSlider) {
        print(value)
        print(slider.tag)
    }
    func secondThumbValueChanged(value: Int, _ slider: ZGRSlider) {
        print(value)
        print(slider.tag)
    }
}
