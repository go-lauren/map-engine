//
//  DungeonConfig.swift
//  DungeonSettings
//
//  Created by Jackson on 4/22/19.
//  Copyright © 2019 Jackson. All rights reserved.
//

import Foundation
import UIKit

class DungeonConfig {
    
    // All the dungeon settings
    var snapshotImage: UIImage
    var name: String
    var difficulty: Int // from 1 to 10
    var totalFloors: Int
    var monsterHouses: Bool
    var bagLimit: Int
    var restrictedItems: [Item]
    var dungeonSize: DungeonSize
    
    init() {
        self.snapshotImage = UIImage()
        self.name = "name"
        self.difficulty = 5
        self.monsterHouses = false
        self.restrictedItems = []
        self.bagLimit = 99
        self.totalFloors = 99
        self.dungeonSize = DungeonSize(length: 100, width: 100)
    }
    
    init (image: UIImage,
          name: String,
          difficulty: Int,
          monsterHouses: Bool,
          bagLimit: Int,
          restrictedItems: [Item],
          dungeonLength: Int,
          dungeonWidth: Int,
          totalFloors: Int
        ) {
        self.snapshotImage = image
        self.name = name
        self.difficulty = difficulty
        self.totalFloors = totalFloors
        self.monsterHouses = monsterHouses
        self.restrictedItems = restrictedItems
        self.bagLimit = bagLimit
        self.dungeonSize = DungeonSize(length: dungeonLength, width: dungeonWidth)
    }
    
}

struct DungeonSize {
    var length: Int
    var width: Int
}
