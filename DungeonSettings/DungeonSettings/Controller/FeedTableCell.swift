//
//  FeedTableCellViewController.swift
//  DungeonSettings
//
//  Created by Jackson on 4/22/19.
//  Copyright © 2019 Jackson. All rights reserved.
//

import UIKit

class FeedTableCell: UITableViewCell {
    
    // MARK: - Elements in each cell
    @IBOutlet weak var snapshotImage: UIImageView! // LINK
    @IBOutlet weak var savedTitleLabel: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var mainBackground: UIView!
    @IBOutlet weak var shadowLayer: ShadowView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCellShadow() {
        mainBackground.layer.cornerRadius = 8
        mainBackground.layer.masksToBounds = true
        
        self.layer.shadowPath = UIBezierPath(rect: self.mainBackground.bounds).cgPath
        shadowLayer.setupShadow()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class ShadowView: UIView {
    override var bounds: CGRect {
        didSet {
            setupShadow()
            print("didSet shadowView's width to: \(self.bounds.width)\n")
        }
    }
    
    public func setupShadow() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 8
        self.layer.shadowOffset = .zero
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.3
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
