//
//  HomeTableTableViewController.swift
//  DungeonSettings
//
//  Created by Jackson on 4/22/19.
//  Copyright © 2019 Jackson. All rights reserved.
//

import UIKit
import Timepiece
import BLTNBoard

class HomeTableTableViewController: UITableViewController {

    @IBOutlet weak var feedView: UITableView!
    //TODO: Create an array of High Scores
    //TODO: Replace with a model Dungeon State
    
    var dStates: [DungeonState] = []
    var sections: [String] = ["Highlights", "Your Dungeons"]
    lazy var bulletinManager: BLTNItemManager = {
        let rootItem: BLTNItem = createBLTNTest()
        return BLTNItemManager(rootItem: rootItem)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set TESTING dungeon states
        let state1 = DungeonState()
        let state2 = DungeonState()
        let state3 = DungeonState()
        dStates = [state1, state2, state3]
        
        feedView.rowHeight = 110
    }
    
    override func viewDidAppear(_ animated: Bool) {
        bulletinManager.showBulletin(above: self)
    }
    
    // MARK: Data Source
    
    
    // MARK: - Set Sections
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dStates.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get the current cell, default state
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedTableCell", for: indexPath) as! FeedTableCell
        let curState = dStates[indexPath.row]
        
        // Sett the shadowing
        cell.setupCellShadow()
        
        cell.timestamp?.text = "last played: \(curState.dateLastPlayed.month)/\(curState.dateLastPlayed.day)"
        cell.savedTitleLabel?.text = "\(curState.saveNickname)"
        cell.progressLabel?.text = "floor: \(curState.currentFloor)/\(curState.config.totalFloors)"
        
        // TODO: make custom logos appear
        cell.snapshotImage?.image = UIImage(named: "appleLogo")
//        print("Cell \(indexPath.row)")
        
        return cell
        
    }
    
    
    // MARK: - Other
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected \(indexPath.row)")
    }
    
    func createBLTNTest() -> BLTNPageItem {
        let page = BLTNPageItem(title: "Push Notifications")
        page.image = UIImage(named: "appleLogo")
        
        page.descriptionText = "Receive push notifications when new photos of pets are available."
        page.actionButtonTitle = "Subscribe"
        page.alternativeButtonTitle = "Not now"
        page.actionHandler = { (item: BLTNActionItem) in
            print("Action button tapped")
        }
        page.alternativeHandler = { (item: BLTNActionItem) in
            print("Alternative button tapped")
        }
        return page
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
