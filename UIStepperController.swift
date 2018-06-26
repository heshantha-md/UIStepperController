//
//  UIStepperController.swift
//
//  Created by Nadeeshan Jayawardana on 6/21/18.
//  Copyright © 2018 NEngineering. All rights reserved.
//  Source: https://github.com/NadeeshanEngineering/UIStepperController
//

import UIKit

protocol UIStepperControllerDelegate {
    func stepperDidAddValues(stepper: UIStepperController)
    func stepperDidSubtractValues(stepper: UIStepperController)
}

class UIStepperController: UIView {

    private var incrementer: CGFloat = 1
    private let countLable: UILabel = UILabel()
    private let additionButtonView: UIView = UIView()
    private let subtractionButtonView: UIView = UIView()
    private let additionButtonImage: UIImageView = UIImageView()
    private let subtractionButtonImage: UIImageView = UIImageView()
    private let crossShape01: UIView = UIView()
    private let crossShape02: UIView = UIView()
    private let crossShape03: UIView = UIView()
    private var _count: CGFloat = 0
    
    var delegate: UIStepperControllerDelegate?
    var isMinus: Bool = false
    var isFloat: Bool = false
    var count: CGFloat {
        set {
            _count = newValue
            self.countLable.text = isFloat ? String(format: "%.2f", _count) : String(format: "%.0f", _count)
        }
        get {
            return _count
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - Custom initialization
    
    private func commonInit() {
        // *************** Left Button ****************
        subtractionButtonView.frame = CGRect(x: 0, y: 0, width: 32, height: self.frame.size.height)
        subtractionButtonView.layer.borderColor = UIColor(red: 0.1, green: 0.54, blue: 0.84, alpha: 1.0).cgColor
        subtractionButtonView.layer.borderWidth = 1
        subtractionButtonView.backgroundColor = UIColor.clear
        
        crossShape01.frame = CGRect(x: ((subtractionButtonView.frame.width / 2) - 6.5), y: ((subtractionButtonView.frame.height / 2) - 1), width: 13, height: 2)
        crossShape01.backgroundColor = UIColor(red: 0.1, green: 0.54, blue: 0.84, alpha: 1.0)
        subtractionButtonView.addSubview(crossShape01)
        
        let subtractionButton: UIButton = UIButton()
        subtractionButton.frame = CGRect(x: 0, y: 0, width: 32, height: self.frame.size.height)
        subtractionButton.addTarget(self, action: #selector(subtractionButtonTouchUpInside), for: .touchUpInside)
        subtractionButtonView.addSubview(subtractionButton)
        
        self.addSubview(subtractionButtonView);
        
        // *************** Right Button ****************
        additionButtonView.frame = CGRect(x: (self.frame.size.width - 32), y: 0, width: 32, height: self.frame.size.height)
        additionButtonView.layer.borderColor = UIColor(red: 0.1, green: 0.54, blue: 0.84, alpha: 1.0).cgColor
        additionButtonView.layer.borderWidth = 1
        additionButtonView.backgroundColor = UIColor.clear
        
        crossShape02.frame = CGRect(x:((additionButtonView.frame.width / 2) - 1) , y: ((additionButtonView.frame.height / 2) - 6.5), width: 2, height: 13)
        crossShape02.backgroundColor = UIColor(red: 0.1, green: 0.54, blue: 0.84, alpha: 1.0)
        additionButtonView.addSubview(crossShape02)
        
        crossShape03.frame = CGRect(x: ((additionButtonView.frame.width / 2) - 6.5), y: ((additionButtonView.frame.height / 2) - 1), width: 13, height: 2)
        crossShape03.backgroundColor = UIColor(red: 0.1, green: 0.54, blue: 0.84, alpha: 1.0)
        additionButtonView.addSubview(crossShape03)
        
        let additionButton: UIButton = UIButton()
        additionButton.frame = CGRect(x: 0, y: 0, width: 32, height: self.frame.size.height)
        additionButton.addTarget(self, action: #selector(additionButtonTouchUpInside), for: .touchUpInside)
        additionButtonView.addSubview(additionButton)
        self.addSubview(additionButtonView);
        
        // *************** Center UILabel ****************
        countLable.frame = CGRect(x: 32, y: 0, width: (self.frame.size.width - 64), height: self.frame.size.height)
        countLable.font = UIFont.systemFont(ofSize: (self.frame.size.height / 2))
        countLable.textColor = UIColor(red: 1.0, green: 0.68, blue: 0.0, alpha: 1.0)
        self.countLable.text = isFloat ? String(format: "%.2f", _count) : String(format: "%.0f", _count)
        countLable.textAlignment = .center
        countLable.backgroundColor = UIColor.clear
        self.addSubview(countLable);
        
        // Self view customize
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height)
        self.layer.borderColor = UIColor(red: 0.1, green: 0.54, blue: 0.84, alpha: 1.0).cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.white
    }
    
    // MARK: - Public functions for customize Stepper controller
    
    func textColor(color: UIColor) {
        countLable.textColor = color
    }
    
    func backgroundColor(color: UIColor) {
        self.backgroundColor = color
    }
    
    func borderColor(color: UIColor) {
        self.layer.borderColor = color.cgColor
        self.additionButtonView.layer.borderColor = color.cgColor
        self.subtractionButtonView.layer.borderColor = color.cgColor
        self.crossShape01.backgroundColor = color
        self.crossShape02.backgroundColor = color
        self.crossShape03.backgroundColor = color
    }
    
    func incrementBy(number: CGFloat) {
        incrementer = number
    }
    
    func leftButtonBackgroundColor(color: UIColor) {
        self.subtractionButtonView.backgroundColor = color;
    }
    
    func leftButtonForegroundColor(color: UIColor) {
        self.crossShape01.backgroundColor = color
    }
    
    func rightButtonBackgroundColor(color: UIColor) {
        self.additionButtonView.backgroundColor = color;
    }
    
    func rightButtonForegroundColor(color: UIColor) {
        self.crossShape02.backgroundColor = color
        self.crossShape03.backgroundColor = color
    }
    
    func setImageToleftButton(image: UIImage?, contentMode: UIViewContentMode) {
        if image == nil {
            crossShape01.isHidden = false
            if subtractionButtonImage.isDescendant(of: subtractionButtonView) {
                subtractionButtonImage.removeFromSuperview()
            }
        } else {
            crossShape01.isHidden = true
            subtractionButtonImage.frame = CGRect(x: 0, y: 0, width: subtractionButtonView.frame.width, height: subtractionButtonView.frame.height)
            subtractionButtonImage.image = image
            subtractionButtonImage.contentMode = contentMode
            subtractionButtonView.addSubview(subtractionButtonImage)
        }
    }
    
    func setImageToRightButton(image: UIImage?, contentMode: UIViewContentMode) {
        if image == nil {
            crossShape02.isHidden = false
            crossShape03.isHidden = false
            if additionButtonImage.isDescendant(of: additionButtonView) {
                additionButtonImage.removeFromSuperview()
            }
        } else {
            crossShape02.isHidden = true
            crossShape03.isHidden = true
            additionButtonImage.frame = CGRect(x: 0, y: 0, width: additionButtonView.frame.width, height: additionButtonView.frame.height)
            additionButtonImage.image = image
            additionButtonImage.contentMode = contentMode
            additionButtonView.addSubview(additionButtonImage)
        }
    }
    
    // MARK: Delegate functions
    
    @objc func subtractionButtonTouchUpInside(sender: UIButton) {
        _count = _count - incrementer
        _count = _count >= 0 ? _count : (isMinus ? _count : 0)
        self.countLable.text = isFloat ? String(format: "%.2f", _count) : String(format: "%.0f", _count)
        delegate?.stepperDidSubtractValues(stepper: self)
    }
    
    @objc func additionButtonTouchUpInside(sender: UIButton) {
        _count = _count + incrementer
        self.countLable.text = isFloat ? String(format: "%.2f", _count) : String(format: "%.0f", _count)
        delegate?.stepperDidAddValues(stepper: self)
    }
}
