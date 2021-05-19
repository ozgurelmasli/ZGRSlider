# ZGRSlider

## Introduction

> ZGRSlider allows you to set a range between two numbers

## Code Samples

> 
        self.slider = .init()
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
        self.slider?.delegate = self
        self.view.addSubview(self.slider!)
        self.slider?.translatesAutoresizingMaskIntoConstraints = false
        self.slider?.leftAnchor.constraint(equalTo: self.view.leftAnchor , constant: 24).isActive = true
        self.slider?.rightAnchor.constraint(equalTo: self.view.rightAnchor , constant: -24).isActive = true
        self.slider?.centerYAnchor.constraint(equalTo: self.view.centerYAnchor , constant: -15).isActive = true
        self.slider?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.slider?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.slider?.layoutIfNeeded()
        self.slider?.configure()
    

## Installation

> Just clone example project and copy ZGRSlider.swift. DONE 🚀

## Screen Shot


![alt text](https://i.ibb.co/F00MDj0/Screen-Shot-2021-05-20-at-00-14-42.png)

