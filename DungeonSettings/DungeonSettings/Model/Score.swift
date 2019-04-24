//
//  Score.swift
//  DungeonSettings
//
//  Created by Jackson on 4/22/19.
//  Copyright © 2019 Jackson. All rights reserved.
//
//  Purpose: Object to represent score in dungeon

import Foundation
import Timepiece

class Score {
    // TODO: Determine criteria for a score
    var username: String
    var dateCompleted: Date
    var dateStarted: Date
    var timeTaken: Double // in seconds
    var distanceCovered: Double
    // map vision on average at a given floor as a percentage of the overall map
    var avgMapVision: Double
    
    init(_ username: String,
         _ timeTaken: Double,
         _ dateCompleted: Date,
         _ dateStarted: Date,
         _ distanceCovered: Double,
         _ avgMapVision: Double
         ) {
        self.username = username
        self.dateCompleted = dateCompleted
        self.dateStarted = dateStarted
        self.timeTaken = timeTaken
        self.avgMapVision = avgMapVision
        self.distanceCovered = distanceCovered
    }
    
    // TODO: Add way to change the weights of these things later
    func overallScore() -> Double {
        guard let overall: Double = self.timeTaken + self.distanceCovered + self.avgMapVision else {
            return 0
            
        }
        return overall
    }
    
}
