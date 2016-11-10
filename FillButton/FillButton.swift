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
    
    private let tapEffectView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))

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


        // 円を描画
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = mainColor.cgColor
        shapeLayer.path = UIBezierPath(ovalIn: tapEffectView.bounds).cgPath
        tapEffectView.layer.addSublayer(shapeLayer)
        tapEffectView.isHidden = true
        
        addSubview(tapEffectView)
    }
    
    // タップしたとき
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let point = touches.first?.location(in: self) {
            tapEffectView.frame.origin = point
            
            tapEffectView.alpha = 1.0
            tapEffectView.isHidden = false
            tapEffectView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            
            UIView.animate(withDuration: 0.4,
                                       animations: {
                                        self.tapEffectView.alpha = 1.0
                                        self.tapEffectView.transform = CGAffineTransform(scaleX: 200.0, y: 200.0)
            }) { finished in
                self.tapEffectView.isHidden = true
                self.tapEffectView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
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
