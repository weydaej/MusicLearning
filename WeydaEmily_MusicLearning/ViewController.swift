//
//  ViewController.swift
//  WeydaEmily_MusicLearning
//
//  Created by Emily Weyda on 6/22/16.
//  Copyright © 2016 University of Cincinnati. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var turnCounter : Int = 0
    let MAXTURN : Int = 3
    var player : AVAudioPlayer!
    var notes : NSArray!
    var currentNote : String = ""
    var correctAnswerCounter : Int = 0
    var score : Int = 0
    
    @IBOutlet var btnNotes: [UIButton]!

    
    @IBOutlet weak var replay: UIButton!
    @IBOutlet weak var btnStartGame: UIButton!
    @IBOutlet weak var lblAnswer: UILabel!
    @IBOutlet weak var lblTurn: UILabel!
    @IBOutlet weak var correctImage: UIImageView!
    @IBOutlet weak var incorrectImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1. load the URLs of the mp3 files into the notes array
        let appBundle = NSBundle.mainBundle()
        notes = appBundle.URLsForResourcesWithExtension("mp3", subdirectory: nil)!
        // disable the notes buttons
        setNoteButtonsStatus(false)
        replay.alpha = 0
    }

    func resetGame() {
        turnCounter = 0
        correctAnswerCounter = 0
        score = 0
    }
    
    @IBAction func startGame() {
        // disable the button
        btnStartGame.enabled = false
        // reset game
        resetGame()
        // play a new game
        playGame()
    }
    
    func setNoteButtonsStatus(status : Bool) {
        btnNotes[0].enabled = status
        for button in btnNotes{
            button.enabled = status
            if(status){
                button.alpha = 1.0
            } else {
                button.alpha = 0.5
            }
        }
    }
    
    func resetTurn(){
        lblTurn.text = ""
        lblAnswer.text = ""
        correctImage.alpha = 0
        incorrectImage.alpha = 0
    }
    
    func playGame() {
        // reset the turn
        resetTurn()
        // check the # of turns and if not max, play random note. if max, endGame
        if (turnCounter < MAXTURN){
            // play a random note
            playRandomNote()
            // enable note buttons
            setNoteButtonsStatus(true)
        } else {
            // end game
            endGame()
        }
        
    }
    
    func playRandomNote() {
        replay.alpha = 1.0
        // 1. generate a random number
        let randomIndex = random() % notes.count
        // 2. Retrieve the URL at the random index
        let randomFileURL = notes.objectAtIndex(randomIndex) as! NSURL
        // 3. initialize the player object with the contents of the sound file located at the randomFileURL
        player = try? AVAudioPlayer(contentsOfURL: randomFileURL)
        // 4. play the note
        player.play()
        // 5. log the note name
        NSLog("random note: %@", randomFileURL.lastPathComponent!)
        // 6. assign the name of the note to the currentNote variable
        currentNote = randomFileURL.lastPathComponent!
        
    }
    
    func endGame() {
        score = (correctAnswerCounter*100)/MAXTURN
        let alert = UIAlertController(title:"Game Over!", message: "Thank you for playing the game! Your score is \(score)!", preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        // update stats
        updateStats()
        // enable start game button
        btnStartGame.enabled = true
    }
    
    @IBAction func checkAnswer(sender: UIButton) {
        replay.alpha = 0
        // 0. disable the buttons
        setNoteButtonsStatus(false)
        // 1. retrieve the user note
        let userSelectedNote = String.localizedStringWithFormat("%@.mp3", (sender.titleLabel?.text)!)
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(2)
        // 2. compare user note to the current note
        if (userSelectedNote == currentNote) {
            correctAnswerCounter += 1
            lblAnswer.text = "Correct Answer"
            correctImage.alpha = 1.0
            //NSLog("Correct Answer")
        } else {
            lblAnswer.text = "Incorrect Answer"
            incorrectImage.alpha = 1.0
            //NSLog("Incorrect Answer")
        }
        UIView.commitAnimations()
        // 3. increment number of turns
        turnCounter += 1
        lblTurn.text = "Turn \(turnCounter) out of \(MAXTURN)"
        // 4. play another turn
        NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(ViewController.playGame), userInfo: nil, repeats: false)
    }
    
    func updateStats(){
        // get reference to teh standard transfer user defailse.
        let defaults = NSUserDefaults.standardUserDefaults()
        // 1. get highest score from above
        var highestScore = defaults.integerForKey("HighestScore")
        var currentScore = defaults.integerForKey("CurrentScore")
        var numberOfGames = defaults.integerForKey("NumberOfGames")
        var lowestScore = defaults.integerForKey("LowestScore")
        // 2. compare score by higher store to the highest
        if(score > highestScore)
        // 2.1 if sore is higher update highest score
        {
        highestScore = score
        }
        // update current score
        currentScore = score
        // update # of games
        numberOfGames += 1
        if(score < lowestScore){
            lowestScore = score
        }
        if(numberOfGames == 1){
            lowestScore = score
        }
        // 3 save
        defaults.setInteger(highestScore, forKey: "HighestScore")
        defaults.setInteger(currentScore, forKey: "CurrentScore")
        defaults.setInteger(numberOfGames, forKey: "NumberOfGames")
        defaults.setInteger(lowestScore, forKey: "LowestScore")
    }
    
    @IBAction func replayNote(){
        player.play()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

