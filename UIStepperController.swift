//
//  UIStepperController.swift
//
//  Created by Nadeeshan Jayawardana on 6/21/18.
//  Copyright © 2018 NEngineering. All rights reserved.
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
    private let additionIconView: UIView = UIView()
    private let subtractionIconView: UIView = UIView()
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
        // Self view customize
        self.layer.borderColor = UIColor(red: 0.1, green: 0.54, blue: 0.84, alpha: 1.0).cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.white
        
        // *************** Center UILabel ****************
        self.countLable.font = UIFont.systemFont(ofSize: (self.frame.size.height / 2))
        self.countLable.textColor = UIColor(red: 1.0, green: 0.68, blue: 0.0, alpha: 1.0)
        self.countLable.text = isFloat ? String(format: "%.2f", _count) : String(format: "%.0f", _count)
        self.countLable.textAlignment = .center
        self.countLable.backgroundColor = UIColor.clear
        
        self.countLable.translatesAutoresizingMaskIntoConstraints = false
        let countLableTopConstraint = NSLayoutConstraint(item: self.countLable, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let countLableBottomConstraint = NSLayoutConstraint(item: self.countLable, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let countLableRightConstraint = NSLayoutConstraint(item: self.countLable, attribute: .right, relatedBy: .equal, toItem: self.additionButtonView, attribute: .left, multiplier: 1, constant: 0)
        let countLableViewLeftConstraint = NSLayoutConstraint(item: self.countLable, attribute: .left, relatedBy: .equal, toItem: self.subtractionButtonView, attribute: .right, multiplier: 1, constant: 0)
        self.addConstraints([countLableTopConstraint,countLableBottomConstraint,countLableViewLeftConstraint,countLableRightConstraint])
        self.addSubview(self.countLable);
        
        
        
        // *************** Left Button ****************
        self.subtractionButtonView.layer.borderColor = UIColor(red: 0.1, green: 0.54, blue: 0.84, alpha: 1.0).cgColor
        self.subtractionButtonView.layer.borderWidth = 1
        self.subtractionButtonView.backgroundColor = UIColor.clear
        
        self.subtractionButtonView.translatesAutoresizingMaskIntoConstraints = false
        let subtractionButtonWidthConstraint = NSLayoutConstraint(item: self.subtractionButtonView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 32)
        let subtractionButtonTopConstraint = NSLayoutConstraint(item: self.subtractionButtonView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let subtractionButtonBottomConstraint = NSLayoutConstraint(item: self.subtractionButtonView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let subtractionButtonLeftConstraint = NSLayoutConstraint(item: self.subtractionButtonView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)
        self.addConstraints([subtractionButtonWidthConstraint,subtractionButtonTopConstraint,subtractionButtonBottomConstraint,subtractionButtonLeftConstraint])
        
        
        // Subtraction button's image
        self.subtractionButtonImage.translatesAutoresizingMaskIntoConstraints = false
        let subtractionButtonImageTopConstraint = NSLayoutConstraint(item: self.subtractionButtonImage, attribute: .top, relatedBy: .equal, toItem: self.subtractionButtonView, attribute: .top, multiplier: 1, constant: 0)
        let subtractionButtonImageBottomConstraint = NSLayoutConstraint(item: self.subtractionButtonImage, attribute: .bottom, relatedBy: .equal, toItem: self.subtractionButtonView, attribute: .bottom, multiplier: 1, constant: 0)
        let subtractionButtonImageRightConstraint = NSLayoutConstraint(item: self.subtractionButtonImage, attribute: .right, relatedBy: .equal, toItem: self.subtractionButtonView, attribute: .right, multiplier: 1, constant: 0)
        let subtractionButtonImageLeftConstraint = NSLayoutConstraint(item: self.subtractionButtonImage, attribute: .left, relatedBy: .equal, toItem: self.subtractionButtonView, attribute: .left, multiplier: 1, constant: 0)
        self.subtractionButtonView.addConstraints([subtractionButtonImageTopConstraint,subtractionButtonImageBottomConstraint,subtractionButtonImageRightConstraint,subtractionButtonImageLeftConstraint])
        self.subtractionButtonImage.isHidden = true
        self.subtractionButtonView.addSubview(self.subtractionButtonImage)
        
        
        // Subtraction button's icon view
        self.subtractionIconView.translatesAutoresizingMaskIntoConstraints = false
        let subtractionIconViewHeightConstraint = NSLayoutConstraint(item: self.subtractionIconView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 13)
        let subtractionIconViewWidthConstraint = NSLayoutConstraint(item: self.subtractionIconView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 13)
        let subtractionIconViewHorizontalConstraint = NSLayoutConstraint(item: self.subtractionIconView, attribute: .centerX, relatedBy: .equal, toItem: self.subtractionButtonView, attribute: .centerX, multiplier: 1, constant: 0)
        let subtractionIconViewVerticalConstraint = NSLayoutConstraint(item: self.subtractionIconView, attribute: .centerY, relatedBy: .equal, toItem: self.subtractionButtonView, attribute: .centerY, multiplier: 1, constant: 0)
        
        self.subtractionButtonView.addConstraints([subtractionIconViewHeightConstraint, subtractionIconViewWidthConstraint, subtractionIconViewHorizontalConstraint, subtractionIconViewVerticalConstraint])
        self.subtractionButtonView.addSubview(self.subtractionIconView)
        
        
        // Subtraction button's icon shape
        self.crossShape01.frame = CGRect(x: 0, y: 5.5, width: 13, height: 2)
        self.crossShape01.backgroundColor = UIColor(red: 0.1, green: 0.54, blue: 0.84, alpha: 1.0)
        self.subtractionIconView.addSubview(self.crossShape01)
        
        
        // Subtraction button's Touch Event
        let subtractionButton: UIButton = UIButton()
        
        subtractionButton.translatesAutoresizingMaskIntoConstraints = false
        let subtractionTouchButtonTopConstraint = NSLayoutConstraint(item: subtractionButton, attribute: .top, relatedBy: .equal, toItem: self.subtractionButtonView, attribute: .top, multiplier: 1, constant: 0)
        let subtractionTouchButtonBottomConstraint = NSLayoutConstraint(item: subtractionButton, attribute: .bottom, relatedBy: .equal, toItem: self.subtractionButtonView, attribute: .bottom, multiplier: 1, constant: 0)
        let subtractionTouchButtonRightConstraint = NSLayoutConstraint(item: subtractionButton, attribute: .right, relatedBy: .equal, toItem: self.subtractionButtonView, attribute: .right, multiplier: 1, constant: 0)
        let subtractionTouchButtonLeftConstraint = NSLayoutConstraint(item: subtractionButton, attribute: .left, relatedBy: .equal, toItem: self.subtractionButtonView, attribute: .left, multiplier: 1, constant: 0)
        self.subtractionButtonView.addConstraints([subtractionTouchButtonTopConstraint,subtractionTouchButtonBottomConstraint,subtractionTouchButtonRightConstraint,subtractionTouchButtonLeftConstraint])
        
        subtractionButton.addTarget(self, action: #selector(subtractionButtonTouchUpInside), for: .touchUpInside)
        self.subtractionButtonView.addSubview(subtractionButton)
        self.addSubview(self.subtractionButtonView);
        
        
        
        // *************** Right Button ****************
        self.additionButtonView.layer.borderColor = UIColor(red: 0.1, green: 0.54, blue: 0.84, alpha: 1.0).cgColor
        self.additionButtonView.layer.borderWidth = 1
        self.additionButtonView.backgroundColor = UIColor.clear
        
        self.additionButtonView.translatesAutoresizingMaskIntoConstraints = false
        let additionButtonViewWidthConstraint = NSLayoutConstraint(item: self.additionButtonView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 32)
        let additionButtonTopConstraint = NSLayoutConstraint(item: self.additionButtonView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let additionButtonBottomConstraint = NSLayoutConstraint(item: self.additionButtonView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let additionButtonRightConstraint = NSLayoutConstraint(item: self.additionButtonView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)
        self.addConstraints([additionButtonViewWidthConstraint,additionButtonTopConstraint,additionButtonBottomConstraint,additionButtonRightConstraint])
        
        
        // Addition button's image
        self.additionButtonImage.translatesAutoresizingMaskIntoConstraints = false
        let additionButtonImageTopConstraint = NSLayoutConstraint(item: self.additionButtonImage, attribute: .top, relatedBy: .equal, toItem: self.additionButtonView, attribute: .top, multiplier: 1, constant: 0)
        let additionButtonImageBottomConstraint = NSLayoutConstraint(item: self.additionButtonImage, attribute: .bottom, relatedBy: .equal, toItem: self.additionButtonView, attribute: .bottom, multiplier: 1, constant: 0)
        let additionButtonImageRightConstraint = NSLayoutConstraint(item: self.additionButtonImage, attribute: .right, relatedBy: .equal, toItem: self.additionButtonView, attribute: .right, multiplier: 1, constant: 0)
        let additionButtonImageLeftConstraint = NSLayoutConstraint(item: self.additionButtonImage, attribute: .left, relatedBy: .equal, toItem: self.additionButtonView, attribute: .left, multiplier: 1, constant: 0)
        self.additionButtonView.addConstraints([additionButtonImageTopConstraint,additionButtonImageBottomConstraint,additionButtonImageRightConstraint,additionButtonImageLeftConstraint])
        self.additionButtonImage.isHidden = true
        self.additionButtonView.addSubview(self.additionButtonImage)
        
        
        // Addition button's icon view
        self.additionIconView.translatesAutoresizingMaskIntoConstraints = false
        let additionIconViewHeightConstraint = NSLayoutConstraint(item: self.additionIconView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 13)
        let additionIconViewWidthConstraint = NSLayoutConstraint(item: self.additionIconView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 13)
        let additionIconViewHorizontalConstraint = NSLayoutConstraint(item: self.additionIconView, attribute: .centerX, relatedBy: .equal, toItem: self.additionButtonView, attribute: .centerX, multiplier: 1, constant: 0)
        let additionIconViewVerticalConstraint = NSLayoutConstraint(item: self.additionIconView, attribute: .centerY, relatedBy: .equal, toItem: self.additionButtonView, attribute: .centerY, multiplier: 1, constant: 0)
        
        self.additionButtonView.addConstraints([additionIconViewHeightConstraint, additionIconViewWidthConstraint, additionIconViewHorizontalConstraint, additionIconViewVerticalConstraint])
        self.additionButtonView.addSubview(self.additionIconView)
        
        
        // Addition button's icon shapes
        self.crossShape02.frame = CGRect(x: 5.5, y: 0, width: 2, height: 13)
        self.crossShape02.backgroundColor = UIColor(red: 0.1, green: 0.54, blue: 0.84, alpha: 1.0)
        self.additionIconView.addSubview(self.crossShape02)
        
        self.crossShape03.frame = CGRect(x: 0, y: 5.5, width: 13, height: 2)
        self.crossShape03.backgroundColor = UIColor(red: 0.1, green: 0.54, blue: 0.84, alpha: 1.0)
        self.additionIconView.addSubview(self.crossShape03)
        
        
        // Addition button's Touch Event
        let additionButton: UIButton = UIButton()
        
        additionButton.translatesAutoresizingMaskIntoConstraints = false
        let additionTouchButtonTopConstraint = NSLayoutConstraint(item: additionButton, attribute: .top, relatedBy: .equal, toItem: self.additionButtonView, attribute: .top, multiplier: 1, constant: 0)
        let additionTouchButtonBottomConstraint = NSLayoutConstraint(item: additionButton, attribute: .bottom, relatedBy: .equal, toItem: self.additionButtonView, attribute: .bottom, multiplier: 1, constant: 0)
        let additionTouchButtonRightConstraint = NSLayoutConstraint(item: additionButton, attribute: .right, relatedBy: .equal, toItem: self.additionButtonView, attribute: .right, multiplier: 1, constant: 0)
        let additionTouchButtonLeftConstraint = NSLayoutConstraint(item: additionButton, attribute: .left, relatedBy: .equal, toItem: self.additionButtonView, attribute: .left, multiplier: 1, constant: 0)
        self.additionButtonView.addConstraints([additionTouchButtonTopConstraint,additionTouchButtonBottomConstraint,additionTouchButtonRightConstraint,additionTouchButtonLeftConstraint])
        
        additionButton.addTarget(self, action: #selector(additionButtonTouchUpInside), for: .touchUpInside)
        self.additionButtonView.addSubview(additionButton)
        self.addSubview(self.additionButtonView);
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
            subtractionIconView.isHidden = false
            subtractionButtonImage.isHidden = true
        } else {
            subtractionIconView.isHidden = true
            subtractionButtonImage.image = image
            subtractionButtonImage.contentMode = contentMode
            subtractionButtonImage.isHidden = false
        }
    }
    
    func setImageToRightButton(image: UIImage?, contentMode: UIViewContentMode) {
        if image == nil {
            additionIconView.isHidden = false
            additionButtonImage.isHidden = true
        } else {
            additionIconView.isHidden = true
            additionButtonImage.image = image
            additionButtonImage.contentMode = contentMode
            additionButtonImage.isHidden = false
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
