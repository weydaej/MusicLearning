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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1. load the URLs of the mp3 files into the notes array
        let appBundle = NSBundle.mainBundle()
        notes = appBundle.URLsForResourcesWithExtension("mp3", subdirectory: nil)!
    }

    func resetGame() {
        turnCounter = 0
        correctAnswerCounter = 0
        score = 0
    }
    
    @IBAction func startGame() {
        // reset game
        resetGame()
        // play a new game
        playGame()
    }
    
    func playGame() {
        // check the # of turns and if not max, play random note. if max, endGame
        if (turnCounter < MAXTURN){
            // play a random note
            playRandomNote()
        } else {
            // end game
            endGame()
        }
        
    }
    
    func playRandomNote() {
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
    }
    
    @IBAction func checkAnswer(sender: UIButton) {
        // 1. retrieve the user note
        let userSelectedNote = String.localizedStringWithFormat("%@.mp3", (sender.titleLabel?.text)!)
        // 2. compare user note to the current note
        if (userSelectedNote == currentNote) {
            correctAnswerCounter += 1
            NSLog("Correct Answer")
        } else {
            NSLog("Incorrect Answer")
        }
        // 3. increment number of turns
        turnCounter += 1
        // 4. play another turn
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(ViewController.playGame), userInfo: nil, repeats: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

