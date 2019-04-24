//
//  FeedTableViewController.swift
//  DungeonSettings
//
//  Created by Jackson on 4/22/19.
//  Copyright © 2019 Jackson. All rights reserved.
//

import UIKit

class FeedTableViewController: TableViewController {
    
    //TODO: hook up to storyboard
    @IBOutlet weak var feedView: UITableView!
    //TODO: Replace with a model
    let tempData = ["First", "Second", "Third"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedView.delegate = self
        feedView.dataSource = self
        
    }
    
    // MARK: Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Sets the data for each cell
        if let cell = tableView.dequeueReusableCell(withIdentifier: "feedTableCell") as? FeedTableCell {
            cell.timestamp.text = "Date"
            cell.savedTitleLabel.text = "Temporary Title"
            cell.progressLabel.text = "100%"
//            cell.pokemonImageView.image = pokedex.images[indexPath.row]
//            cell.pokemonName.text = pokedex.names[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected \(indexPath.row)")
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
