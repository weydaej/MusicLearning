//
//  HelpViewController.swift
//  WeydaEmily_MusicLearning
//
//  Created by Emily Weyda on 6/22/16.
//  Copyright © 2016 University of Cincinnati. All rights reserved.
//

import UIKit
import AVFoundation

class HelpViewController: UIViewController {
    
    var player : AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func playNote(sender: UIButton) {
        // 1. retrieve the text from the button
        let noteName = sender.titleLabel?.text!
        // 2. use the text at the file name and load the mp3 file
        let appBundle = NSBundle.mainBundle()
        let fileURL = appBundle.URLForResource(noteName, withExtension: "mp3")!
        // 3. initialize the audio player object with the content of the mp3 file
        player = try? AVAudioPlayer(contentsOfURL: fileURL)
        // 4. play the file
        player.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
