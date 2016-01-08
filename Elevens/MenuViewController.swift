//
//  ViewController.swift
//  Elevens
//
//  Created by Colin on 12/2/15.
//  Copyright © 2015 ccross. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var rulesButton: UIButton!
    
    @IBOutlet weak var totalGamesLabel: UILabel!
    @IBOutlet weak var totalWinsLabel: UILabel!
    
    
    var totalGames = 0
    var totalWins = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalGamesLabel.text = "\(totalGames)"
        totalWinsLabel.text = "\(totalWins)"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if sender as! NSObject == playButton {
            let GVC = segue.destinationViewController as! GameViewController
            GVC.totalGames = totalGames
            GVC.totalWins = totalWins
        }
    }
}