//
//  ViewController.swift
//  MusicPlayerIOS
//
//  Created by Ryan Weiler on 3/30/17.
//  Copyright © 2017 Ryan Weiler. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerViewController:UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var shuffle: UISwitch!
    @IBOutlet weak var playNext: UISwitch!
    @IBOutlet weak var Picker1: UIPickerView!
    @IBOutlet weak var All: UILabel!
    
    var trackId: Int = 0
    var library = MusicLibrary().library
    var audioPlayer: AVAudioPlayer!
    let a: Float = 0
    var Array = ["All", "Pop", "Rock","Classic Rock" ,"Classical", "Country", "Electronica", "Girls Of Surf"]
    var PlacementAnswer = 0
    var click = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Picker1.delegate = self
        Picker1.dataSource = self
        
        // Do any additional setup after loading the view.
        if let coverImage = library[trackId]["coverImage"]{
            coverImageView.image = UIImage(named:"\(coverImage).jpg")
        }
        
        songTitleLabel.text = library[trackId]["title"]
        artistLabel.text = library[trackId]["artist"]
        
        
        
        let path = Bundle.main.path(forResource: "\(trackId)", ofType: "mp3")
        
        if let path = path {
            let mp3URL = URL(fileURLWithPath: path)
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: mp3URL)
                audioPlayer.play()
                self.Picker1.isHidden = true
                Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(PlayerViewController.updateProgressView), userInfo: nil, repeats: true)
                progressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: false)
                
                var audioSession = AVAudioSession.sharedInstance()
                
                // play in background
                do {
                    try audioSession.setCategory(AVAudioSessionCategoryPlayback)
                } catch {
                    
                }
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        audioPlayer.stop()
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Array[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Array.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBAction func Genre(_ sender: AnyObject) {
        
        if click > 0 {
            self.Picker1.isHidden = true
            click = 0
        }
        else {
            self.Picker1.isHidden = false
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        PlacementAnswer = row
        
        if (PlacementAnswer == 0) {
            All.text = "All"
            click += 1
        }
        else if (PlacementAnswer == 1) {
            All.text = "Pop"
            click += 1
        }
        else if (PlacementAnswer == 2) {
            All.text = "Rock"
            click += 1
        }
        else if (PlacementAnswer == 3) {
            All.text = "Classic Rock"
            click += 1
        }
        else if (PlacementAnswer == 4) {
            All.text = "Classical"
            click += 1
        }
        else if (PlacementAnswer == 5) {
            All.text = "Country"
            click += 1
        }
        else if (PlacementAnswer == 6) {
            All.text = "Electronica"
            click += 1
        }
        else if (PlacementAnswer == 7) {
            All.text = "Girls Of Surf"
            click += 1
        }
        else {
            All.text = "This isn't working"
        }
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
        
        if trackId == 0 || trackId < 113 {
            
            if shuffle.isOn {
                trackId = Int(arc4random_uniform(UInt32(library.count)))
            }else {
                trackId -= 1
            }
            if (library[trackId]["genre"] == All.text || All.text == "All"){
                
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
                        self.Picker1.isHidden = true
                        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(PlayerViewController.updateProgressView), userInfo: nil, repeats: true)
                        progressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: false)
                        
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                }
            }
            else if ( trackId == 0 || trackId < 113){
                repeat {
                    
                    if (trackId == 0) {
                        trackId = 113
                    }else {
                        trackId -= 1
                    }
                } while(library[trackId]["genre"] != All.text || All.text == "All")
                
                
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
                        self.Picker1.isHidden = true
                        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(PlayerViewController.updateProgressView), userInfo: nil, repeats: true)
                        progressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: false)
                        
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                }
                
            }
        }
        else {
            trackId = 113
        }    }
    
    @IBAction func nextAction(_ sender: AnyObject) {
        
        
        if trackId == 0 || trackId < 113 {
            
            if shuffle.isOn {
                trackId = Int(arc4random_uniform(UInt32(library.count)))
            }else {
                trackId += 1
            }
            if (library[trackId]["genre"] == All.text || All.text == "All"){
                
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
                        self.Picker1.isHidden = true
                        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(PlayerViewController.updateProgressView), userInfo: nil, repeats: true)
                        progressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: false)
                        
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                }
            }
            else if ( trackId == 0 || trackId < 113){
                repeat {
                    
                    if (trackId == 113) {
                        trackId = 0
                    }else {
                        trackId += 1
                    }
                } while(library[trackId]["genre"] != All.text || All.text == "All")
                
                
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
                        self.Picker1.isHidden = true
                        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(PlayerViewController.updateProgressView), userInfo: nil, repeats: true)
                        progressView.setProgress(Float(audioPlayer.currentTime/audioPlayer.duration), animated: false)
                        
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                }
                
            }
        }
        else {
            trackId = 0
        }
    }
    
    
    func audioPlayerDidFinishPlayeing()
    {
        if (playNext.isOn){
            nextAction(audioPlayer)
        }
    }
}

