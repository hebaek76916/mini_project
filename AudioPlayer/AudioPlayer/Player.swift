//
//  Player.swift
//  AudioPlayer
//
//  Created by 현은백 on 2021/05/16.
//

import UIKit
import AVFoundation

class Player: UIViewController {

    public var position: Int = 0
    public var songs: [Song] = []
    
    var player: AVAudioPlayer?
    
    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let songNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let playPauseButton = UIButton()
    
    var holder = UIView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hi")
        holder.backgroundColor = .white

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(holder)
        holder.bounds = view.bounds
        holder.translatesAutoresizingMaskIntoConstraints = false
        holder.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        holder.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        holder.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        holder.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        if holder.subviews.count == 0 {
            configure()
        }
    }
    
    func configure() {
        // set up player
        let song = songs[position]
        
        let urlString = Bundle.main.path(forResource: song.trackName, ofType: "mp3")
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let urlString = urlString else {
                return
            }
            
            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
            
            guard let player = player else {
                print("player is nil")
                return
            }
            print("duration : \(Int(player.duration) / 60):\(Int(player.duration) % 60)")
            player.volume = 0.5
            player.play()
            
        } catch {
            print("error occured")
        }
        // set up user interface elements
        
        albumImageView.frame = CGRect(x: 20, y: 20,
                                      width: holder.frame.size.width - 40,
                                      height: holder.frame.size.width - 40)
        albumImageView.image = UIImage(named: song.imageName)
        holder.addSubview(albumImageView)
        
        // labels
        songNameLabel.frame = CGRect(x: 20,
                                     y: albumImageView.frame.size.height + 20,
                                     width: holder.frame.size.width - 20,
                                     height: 40)
        albumNameLabel.frame = CGRect(x: 20,
                                      y: albumImageView.frame.size.height + 10 + 40,
                                      width: holder.frame.size.width - 20,
                                      height: 40)
        artistNameLabel.frame = CGRect(x: 20,
                                       y: albumImageView.frame.size.height + 10 + 80,
                                       width: holder.frame.size.width - 20,
                                       height: 40)
        albumNameLabel.text = song.albumName
        artistNameLabel.text = song.artistName
        songNameLabel.text = song.name
        
        holder.addSubview(albumNameLabel)
        holder.addSubview(artistNameLabel)
        holder.addSubview(songNameLabel)
        
        // player control
        //let playPauseButton = UIButton()
        let nextButton = UIButton()
        let backButton = UIButton()
        
        // Frame
        let yPosition = artistNameLabel.frame.origin.y + 70
        let size: CGFloat = 40
        playPauseButton.frame = CGRect(x: (holder.frame.size.width - size) / 2.0,
                                       y: yPosition,
                                       width: size,
                                       height: size)
        nextButton.frame = CGRect(x: holder.frame.size.width - size - 20,
                                  y: yPosition,
                                  width: size,
                                  height: size)
        backButton.frame = CGRect(x: 20,
                                  y: yPosition,
                                  width: size,
                                  height: size)
        // Add actions
        playPauseButton.addTarget(self, action: #selector(didTapPlayPauseButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        // Images
        // Styling
        playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        backButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        nextButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
        
        playPauseButton.tintColor = .black
        backButton.tintColor = .black
        nextButton.tintColor = .black
        
        holder.addSubview(playPauseButton)
        holder.addSubview(backButton)
        holder.addSubview(nextButton)
        // slider
        let slider = UISlider(frame: CGRect(x: 20,
                                            y: playPauseButton.frame.maxY + 10,
                                            width: holder.frame.size.width - 40,
                                            height: 50))
        slider.value = 1
        slider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
        holder.addSubview(slider)
    }
    
    @objc func didTapBackButton() {
        if position > 0 {
            position = position - 1
            player?.stop()
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            configure()
        }
    }
    
    @objc func didTapNextButton() {
        if position < (songs.count - 1) {
            position = position + 1
            player?.stop()
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            configure()
        }
    }
    
    @objc func didTapPlayPauseButton() {
        if player?.isPlaying == true {
            // pause
            player?.pause()
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            
            //shrink image
            UIView.animate(withDuration: 0.2, animations: {
                self.albumImageView.frame = CGRect(x: 30, y: 30,
                                                   width: self.holder.frame.size.width - 60,
                                                   height: self.holder.frame.size.width - 60)
            })
        } else {
            // play
            player?.play()
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            
            //increase image size
            UIView.animate(withDuration: 0.2, animations: {
                self.albumImageView.frame = CGRect(x: 10, y: 10,
                                                   width: self.holder.frame.size.width - 20,
                                                   height: self.holder.frame.size.width - 20)
            })
        }
    }
    @objc func didSlideSlider(_ slider: UISlider) {
        let value = slider.value
        player?.volume = value
    }



}
