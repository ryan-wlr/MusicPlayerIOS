//
//  ViewController.swift
//  MusicPlayerIOS
//
//  Created by Ryan Weiler on 3/30/17.
//  Copyright © 2017 Ryan Weiler. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {

    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var shuffle: UISwitch!
    @IBOutlet weak var playNext: UISwitch!
    
    var trackId: Int = 0
    var library = MusicLibrary().library
    var audioPlayer: AVAudioPlayer!
    let a: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let coverImage = library[trackId]["coverImage"]{
            coverImageView.image = UIImage(named: "\(coverImage).jpg")
        }
        
        songTitleLabel.text = library[trackId]["title"]
        artistLabel.text = library[trackId]["artist"]
        
        let path = Bundle.main.path(forResource: "\(trackId)", ofType: "mp3")
        
        if let path = path {
            let mp3URL = URL(fileURLWithPath: path)
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: mp3URL)
                audioPlayer.play()
                
                Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(PlayerViewController.updateProgressView), userInfo: nil, repeats: true)
                progressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: false)
                
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        audioPlayer.stop()
    }
    
    func updateProgressView(){
        
        if (progressView.progress > a.advanced(by: 0.98743)){
            audioPlayerDidFinishPlayeing()
        }
        
        if audioPlayer.isPlaying {
            
            progressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: true)
        }
        
    }
    
    
    @IBAction func playAction(_ sender: AnyObject) {
        if !audioPlayer.isPlaying {
            audioPlayer.play()
        }
        
    }
    
    @IBAction func stopAction(_ sender: AnyObject) {
        
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        progressView.progress = 0
    }
    
    
    @IBAction func pauseAction(_ sender: AnyObject) {
        audioPlayer.pause()
    }
    
    @IBAction func fastForwardAction(_ sender: AnyObject) {
        var time: TimeInterval = audioPlayer.currentTime
        time += 5.0
        
        if time > audioPlayer.duration {
            stopAction(self)
        }else {
            audioPlayer.currentTime = time
        }
        
    }
    
    @IBAction func rewindAction(_ sender: AnyObject) {
        var time: TimeInterval = audioPlayer.currentTime
        time -= 5.0
        
        if time < 0 {
            stopAction(self)
        }else {
            audioPlayer.currentTime = time
        }
    }
    
    
    @IBAction func previousAction(_ sender: AnyObject) {
        if trackId != 0 || trackId > 0 {
            if shuffle.isOn {
                trackId = Int(arc4random_uniform(UInt32(library.count)))
            }else {
                trackId -= 1
            }
            
            if let coverImage = library[trackId]["coverImage"]{
                coverImageView.image = UIImage(named: "\(coverImage).jpg")
            }
            
            songTitleLabel.text = library[trackId]["title"]
            artistLabel.text = library[trackId]["artist"]
            
            audioPlayer.currentTime = 0
            progressView.progress = 0
            
            let path = Bundle.main.path(forResource: "\(trackId)", ofType: "mp3")
            
            if let path = path {
                let mp3URL = URL(fileURLWithPath: path)
                
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: mp3URL)
                    audioPlayer.play()
                    
                    Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(PlayerViewController.updateProgressView), userInfo: nil, repeats: true)
                    progressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: false)
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
        
        
        
        
    }
    
    @IBAction func nextAction(_ sender: AnyObject) {
        
        if trackId == 0 || trackId < 57 {
            if shuffle.isOn {
                trackId = Int(arc4random_uniform(UInt32(library.count)))
            }else {
                trackId += 1
            }
            
            if let coverImage = library[trackId]["coverImage"]{
                coverImageView.image = UIImage(named: "\(coverImage).jpg")
            }
            
            songTitleLabel.text = library[trackId]["title"]
            artistLabel.text = library[trackId]["artist"]
            
            audioPlayer.currentTime = 0
            progressView.progress = 0
            
            let path = Bundle.main.path(forResource: "\(trackId)", ofType: "mp3")
            
            if let path = path {
                let mp3URL = URL(fileURLWithPath: path)
                
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: mp3URL)
                    audioPlayer.play()
                    
                    Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(PlayerViewController.updateProgressView), userInfo: nil, repeats: true)
                    progressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: false)
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
    func audioPlayerDidFinishPlayeing()
    {
        if (playNext.isOn){
            nextAction(audioPlayer)
        }
    }}

