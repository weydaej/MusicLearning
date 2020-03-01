//
//  StatsViewController.swift
//  WeydaEmily_MusicLearning
//
//  Created by Emily Weyda on 6/29/16.
//  Copyright © 2016 University of Cincinnati. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    @IBOutlet weak var lblStats: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // 1. retreive the stats from the user defaults object
        let defaults = NSUserDefaults.standardUserDefaults()
        let highestScore = defaults.integerForKey("HighestScore")
        let currentScore = defaults.integerForKey("CurrentScore")
        let numberOfGames = defaults.integerForKey("NumberOfGames")
        let lowestScore = defaults.integerForKey("LowestScore")
        // 2. update the label text with the message
        var message = "Highest Score = \(highestScore) \n"
        message.appendContentsOf("Current Score = \(currentScore) \n")
        message.appendContentsOf("Number of Games Played = \(numberOfGames) \n")
        message.appendContentsOf("Lowest Score = \(lowestScore) \n")
        lblStats.text = message

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
