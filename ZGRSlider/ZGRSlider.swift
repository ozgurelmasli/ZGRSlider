//
//  ZGRSlider.swift
//  ZGRSlider
//
//  Created by Mac on 19.05.2021.
//

import UIKit




protocol ZGRSliderDelegete {
    func firstThumbValueChanged(value : Int , _ slider : ZGRSlider)
    func secondThumbValueChanged(value : Int , _ slider : ZGRSlider)
}


class ZGRSlider: UIView {
    /// ZGR Delegate
    public var delegate : ZGRSliderDelegete?
    
    ///Slider starter value
    public var starterValue : CGFloat = 0.0
    
    ///Slider en value
    public var endValue : CGFloat = 100.0
    
    ///Slider BackgroundColor
    public var sliderBackgroundColor : UIColor?
    
    ///Slider height
    public var sliderHeight : CGFloat = 3.0
    
    ///Thumb starter & end values , this needs to be greater than slider starter value , lower than slider end value
    public var thumbValues : [CGFloat] = [0.0 , 0.0]
    
    ///Thumb heights
    public var thumbHeights : [CGFloat] = [5.0]
    
    ///Thumb colors
    public var thumbColors : [UIColor]?
    
    ///Thumn border withs
    public var thumbBorderWidths : [CGFloat] = [2.0 , 2.0]
    
    ///Thumb Border colors
    public var thumbBorderColors : [UIColor] = [.white , .white]
    
    ///Min Distance between two thumbs
    public var thumbsMinDistance : Int = 0
    
    private var stepValue : CGFloat = 0.0
    
    private weak var slider : UIView?
    
    private weak var firstThumb  : UIView?
    private var firstThumbPangesture : UIPanGestureRecognizer?
    private var firstThumbCenterX : NSLayoutConstraint?
    private weak var firstThumbLabel : UILabel?
    private var firstThumbCurrentValue : Int = 0 {
        didSet {
            self.delegate?.firstThumbValueChanged(value: firstThumbCurrentValue, self)
        }
    }
    
    
    private weak var secondThumb  : UIView?
    private var secondThumbPangesture : UIPanGestureRecognizer?
    private var secondThumbCenterX : NSLayoutConstraint?
    private weak var secondThumbLabel : UILabel?
    private var secondThumbCurrentValue : Int = 0 {
        didSet {
            self.delegate?.secondThumbValueChanged(value: secondThumbCurrentValue, self)
        }
    }
    
    private weak var maskedView : UIView?
    
    private var distance : CGFloat {
        return self.endValue - self.starterValue
    }
    private var br : CGFloat {
        return self.bounds.width / distance
    }
    
}
extension ZGRSlider {
    public func configure(){
        self.isUserInteractionEnabled = true
        self.configureUI()
        self.calculateStepValue()
    }
}
extension ZGRSlider {
    private func configureUI(){
        self.createSlider()
        self.createFirstThumb()
        self.setFirstThumbLabel()
        self.createSecondThumb()
        self.setSecondThumbLabel()
        self.createMaskedView()
    }
    private func calculateStepValue() {
        let width = self.bounds.width
        let distance = endValue - starterValue
        stepValue = width / distance
    }
}
//MARK:-> UI
extension ZGRSlider {
    private func createSlider(){
        let slider : UIView = .init()
        slider.backgroundColor = self.sliderBackgroundColor
        self.addSubview(slider)
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        slider.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        slider.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        slider.heightAnchor.constraint(equalToConstant: self.sliderHeight).isActive = true
        slider.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0).isActive = true
        slider.layer.masksToBounds = true
        slider.clipsToBounds = true
        self.slider = slider
    }
    private func createFirstThumb(){
        if self.thumbValues.count == 0 || self.thumbHeights.count == 0 { fatalError("Need to give some thumb point") }
        let thumb : UIView = .init()
        thumb.backgroundColor = self.thumbColors?.first ?? .black
        thumb.layer.cornerRadius = self.thumbHeights.first! / 2
        thumb.layer.borderWidth = self.thumbBorderWidths.first!
        thumb.layer.borderColor = self.thumbBorderColors.first!.cgColor
        self.addSubview(thumb)
        thumb.translatesAutoresizingMaskIntoConstraints  = false
        let width = self.bounds.width
        self.firstThumbCurrentValue = Int.init(self.thumbValues.first!)
        let starterValue = self.thumbValues.first! - self.starterValue
        if starterValue < 0 { fatalError("Thumb Starter Value need to be bigger than slider starter point") }
        let point = starterValue * br
        let constant = (width / 2.0) - point
        self.firstThumbCenterX = thumb.centerXAnchor.constraint(equalTo: self.slider!.centerXAnchor , constant: -constant)
        thumb.centerYAnchor.constraint(equalTo: self.slider!.centerYAnchor).isActive = true
        thumb.heightAnchor.constraint(equalToConstant: self.thumbHeights.first!).isActive = true
        thumb.widthAnchor.constraint(equalToConstant: self.thumbHeights.first!).isActive = true
        
        self.firstThumbCenterX?.isActive = true
        
        self.firstThumbPangesture = .init(target: self, action: #selector(thumbGesture(gesture:)))
        self.firstThumbPangesture?.maximumNumberOfTouches = 1
        self.firstThumbPangesture?.minimumNumberOfTouches = 1
        thumb.addGestureRecognizer(self.firstThumbPangesture!)
        
        self.firstThumb = thumb
    }
    private func setFirstThumbLabel(){
        let label : UILabel = .init()
        label.text = String.init(describing: Int(self.thumbValues.first!))
        label.textColor = UIColor.systemTeal
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .center
        
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.firstThumb!.centerXAnchor).isActive  = true
        label.topAnchor.constraint(equalTo: self.firstThumb!.bottomAnchor , constant: 5).isActive = true
        label.widthAnchor.constraint(equalToConstant: 15).isActive = true
        
        
        self.firstThumbLabel = label
    }
    
    private func createSecondThumb(){
        if self.thumbValues.count == 0 || self.thumbHeights.count == 0 { fatalError("Need to give some thumb point") }
        let thumb : UIView = .init()
        thumb.backgroundColor = self.thumbColors?.first ?? .black
        thumb.layer.cornerRadius = self.thumbHeights.first! / 2
        thumb.layer.borderWidth = self.thumbBorderWidths.last!
        thumb.layer.borderColor = self.thumbBorderColors.last!.cgColor
        self.addSubview(thumb)
        thumb.translatesAutoresizingMaskIntoConstraints  = false
        let width = self.bounds.width
        self.secondThumbCurrentValue = Int.init(self.thumbValues.last!)
        if self.thumbValues.first == self.thumbValues.last || self.thumbValues.last! < self.thumbValues.first! {
            fatalError("Can not be first thumb value bigger or equal with last thumb value")
        }
        let starterValue = self.thumbValues.last! - self.starterValue
        if starterValue < 0 { fatalError("Thumb Starter Value need to be bigger than slider starter point") }
        let point = starterValue * br
        let constant = (width / 2.0) - point
        self.secondThumbCenterX = thumb.centerXAnchor.constraint(equalTo: self.slider!.centerXAnchor , constant: -constant)
        thumb.centerYAnchor.constraint(equalTo: self.slider!.centerYAnchor).isActive = true
        thumb.heightAnchor.constraint(equalToConstant: self.thumbHeights.first!).isActive = true
        thumb.widthAnchor.constraint(equalToConstant: self.thumbHeights.first!).isActive = true
        
        self.secondThumbCenterX?.isActive = true
        
        self.secondThumbPangesture = .init(target: self, action: #selector(thumbGesture(gesture:)))
        self.secondThumbPangesture?.maximumNumberOfTouches = 1
        self.secondThumbPangesture?.minimumNumberOfTouches = 1
        thumb.addGestureRecognizer(self.secondThumbPangesture!)
        
        self.secondThumb = thumb
    }
    private func setSecondThumbLabel(){
        let label : UILabel = .init()
        label.text = String.init(describing: Int(self.thumbValues.last!))
        label.textColor = UIColor.systemTeal
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .center
        
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.secondThumb!.centerXAnchor).isActive  = true
        label.topAnchor.constraint(equalTo: self.secondThumb!.bottomAnchor , constant: 5).isActive = true
        label.widthAnchor.constraint(equalToConstant: 15).isActive = true
        
        
        self.secondThumbLabel = label
    }
}
extension ZGRSlider {
    private func createMaskedView(){
        let view : UIView = .init()
        view.backgroundColor = UIColor.systemPink
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leftAnchor.constraint(equalTo: self.firstThumb!.rightAnchor).isActive  = true
        view.rightAnchor.constraint(equalTo: self.secondThumb!.leftAnchor).isActive  = true
        view.centerYAnchor.constraint(equalTo: self.slider!.centerYAnchor).isActive = true
        view.heightAnchor.constraint(equalToConstant: self.sliderHeight).isActive = true
        
        self.maskedView = view
    }
}
//MARK:-> Gesture
extension ZGRSlider {
    @objc private func thumbGesture(gesture : UIPanGestureRecognizer){
        let pin = gesture.translation(in: gesture.view!)
        let width = (self.bounds.width) / 2.0
        if pin.x > width || pin.x < (-width) {
            return
        }
        let point = pin.x / br
        let value = Int((self.endValue / 2) + point)
        if gesture.view == self.firstThumb {
            if value >= (self.secondThumbCurrentValue - self.thumbsMinDistance) { return }
            self.firstThumbCenterX?.constant = pin.x
            self.firstThumbCurrentValue = value
            self.firstThumbLabel?.text = String.init(describing: Int(value))
        }
        if gesture.view == self.secondThumb {
            if value <= (self.firstThumbCurrentValue + self.thumbsMinDistance) { return }
            self.secondThumbCenterX?.constant = pin.x
            self.secondThumbCurrentValue = value
            self.secondThumbLabel?.text = String.init(describing: Int(value))
        }
    }
}
