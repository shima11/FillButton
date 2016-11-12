//
//  FillButton.swift
//  FillButton
//
//  Created by shima jinsei on 2016/11/06.
//  Copyright © 2016年 Jinsei Shima. All rights reserved.
//

import UIKit

@IBDesignable class FillButton: UIButton {
    
    @IBInspectable var radius: CGFloat = 2.0
    @IBInspectable var mainColor: UIColor = UIColor.darkGray
    @IBInspectable var subColor: UIColor = UIColor.white
    @IBInspectable var borderWidth: CGFloat = 1.0
    
    @IBInspectable var touchDownScale: CGFloat = 0.9 // 押し込み時の縮小比率
    
    
    var isFilled: Bool = false
    
    override func draw(_ rect: CGRect) {
        print("draw rect")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        print("awake from nib")
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("coder")
//        setup()
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        print("init frame")
//        setup()
//    }
    
    private func setup() {
        // ボタン自体を角丸にする
        layer.cornerRadius = radius
        layer.masksToBounds = true
        self.clipsToBounds = true
        layer.borderColor = mainColor.cgColor
        layer.borderWidth = borderWidth
        layer.backgroundColor = subColor.cgColor
        
        self.setTitleColor(mainColor, for: .normal)
        self.setTitleColor(subColor, for: .highlighted)
        
    }
    
    // タップ開始
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.toValue = touchDownScale
        scaleAnimation.duration = 0.02
        scaleAnimation.fillMode = kCAFillModeForwards
        scaleAnimation.isRemovedOnCompletion = false
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.layer.add(scaleAnimation, forKey: "scaleAnimation")

    }
    // タップ終了
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.toValue = 1.0/touchDownScale
        scaleAnimation.duration = 0.02
        scaleAnimation.fillMode = kCAFillModeForwards
        scaleAnimation.isRemovedOnCompletion = false
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.layer.add(scaleAnimation, forKey: "scaleAnimation")
        
        if isFilled {
            self.setTitleColor(mainColor, for: .normal)
            layer.backgroundColor = UIColor.white.cgColor
            isFilled = false
        } else {
            self.setTitleColor(UIColor.white, for: .normal)
            layer.backgroundColor = mainColor.cgColor
            isFilled = true
        }
        
    }
    
    // ハイライト時に色を反転させる
    override var isHighlighted: Bool {
        didSet {
            if (isHighlighted) {
                layer.backgroundColor = mainColor.cgColor
            } else {
                layer.backgroundColor = UIColor.white.cgColor
            }
        }
    }
    
}
