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
    var delegate: ControlsDelegate!
    let offset: CGFloat = 5
    
    init(_ frame: CGRect) {
        self.buttons = Array<UIButton>()
        super.init(frame: frame)

        for _ in 0..<4 {
            
            var button = UIButton()
            button.frame = self.frame
            buttons.append(button)
            button.backgroundColor = UIColor.white
            button.addTarget(self, action: #selector(Controls.press(sender:)), for: UIControl.Event.touchDown)
            self.addSubview(button)
        }
        let dimension: CGFloat = min(self.frame.maxX - self.frame.minX, self.frame.maxY - self.frame.minY) / 3.0 - offset
        for i in 0..<4 {
            buttons[i].frame = CGRect(x: 0, y: 0, width: dimension, height: dimension)
        }
        
        buttons[0].center.x = self.frame.width / 2.0
        buttons[1].center.x = self.frame.width / 2.0
        buttons[1].center.y = self.frame.size.height - dimension / 2.0
        buttons[2].center.y = self.frame.size.height / 2.0
        buttons[3].center.y = self.frame.size.height / 2.0
        buttons[3].center.x = self.frame.size.width - dimension / 2.0
    }
    
    @objc func press(sender: UIButton) {
        for i in 0..<4 {
            if (buttons[i] === sender) {
                delegate.moved(Movement(rawValue: i)!)
                break
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum Movement: Int {
        case Up = 0
        case Down = 1
        case Left = 2
        case Right = 3
    }
}

protocol ControlsDelegate {
    func moved(_ direction: Controls.Movement)
}
