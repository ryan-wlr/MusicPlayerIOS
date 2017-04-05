//
//  LibraryTableViewController.swift
//  MusicPlayerIOS
//
//  Created by Ryan Weiler on 3/30/17.
//  Copyright © 2017 Ryan Weiler. All rights reserved.
//

import Foundation
import UIKit

class LibraryTableViewController: UITableViewController {
    
    var library = MusicLibrary().library
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return library.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "musicCell", for: indexPath) as! SongTableViewCell
        
        cell.artistLabel.text = library[indexPath.row]["artist"]
        cell.songTitleLabel.text = library[indexPath.row]["title"]
        
        if let coverImage = library[indexPath.row]["coverImage"] {
            
            cell.coverImageView.image = UIImage(named: "\(coverImage).jpg")
            
        }
        cell.genreLabel.text = library[indexPath.row]["genre"]        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPlayer", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPlayer" {
            
            let playerVC = segue.destination as! PlayerViewController
            let indexPath = tableView.indexPathForSelectedRow!
            playerVC.trackId = indexPath.row
            
        }
    }
}
