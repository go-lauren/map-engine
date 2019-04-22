//
//  Controls.swift
//  map-engine
//
//  Created by Lauren Go on 2019/04/21.
//  Copyright © 2019 go-lauren. All rights reserved.
//

import UIKit

class Controls: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var buttons: [UIButton] // up, down, left, right
    
    init(_ frame: CGRect) {
        self.buttons = Array<UIButton>()
        super.init(frame: frame)
        for _ in 0..<4 {
            
            var button = UIButton()
            button.frame = self.frame
            buttons.append(button)
            button.backgroundColor = UIColor.white
            button.addTarget(self, action: Selector("HoldDown:"), for: UIControl.Event.touchDown)
            self.addSubview(button)
        }
        for i in 0..<4 {
            buttons[i].frame = CGRect(x: CGFloat(i) * (self.frame.maxX - self.frame.minX) / CGFloat(4), y: buttons[i].frame.minY, width: (self.frame.maxX - self.frame.minX) / CGFloat(4), height: self.frame.maxY - self.frame.minY)
        }
    }
    
    @objc func HoldDown(sender: UIButton) {
        buttons[0].backgroundColor = UIColor.green
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum Movement {
        case Up
        case Down
        case Left
        case Right
    }
}
