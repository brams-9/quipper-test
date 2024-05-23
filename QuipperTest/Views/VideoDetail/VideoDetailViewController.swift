//
//  VideoDetailViewController.swift
//  QuipperTest
//
//  Created by Rahman Bramantya on 23/05/24.
//

import UIKit
import AVKit

class VideoDetailViewController: UIViewController {
    // MARK: Properties

    var playlistData: PlaylistModel?
    
    lazy var thumbnailImage: CustomImageView = {
        let thumbnailImage = CustomImageView()
        thumbnailImage.translatesAutoresizingMaskIntoConstraints = false
    
        return thumbnailImage
    }()
    
    lazy var videoTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        
        return label
    }()
    
    lazy var videoPresenterName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .subtleTextColor
        
        return label
    }()
    
    lazy var videoDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var videoDuration: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Play Video", for: .normal)
        button.addTarget(self, action: #selector(navigateToVideoPlayer), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
        
    }()
    
    @objc func navigateToVideoPlayer() {
        let playerViewController = AVPlayerViewController()
        if let playlistData = playlistData, let videoURL = playlistData.videoURL {
            let player = AVPlayer(url: videoURL)
            playerViewController.player = player
            
            self.present(playerViewController, animated: true) {
                player.play()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupVideoDetailData()
        setupUI()
    }
    
    // MARK: Initialization
    func setupVideoDetailData() {
        if let playlistData = playlistData {
            videoDuration.text = "Duration: \(playlistData.formatMilliseconds())"
            videoTitle.text = "Presented By:\(playlistData.title ?? "")"
            videoDescription.text = playlistData.description
            videoPresenterName.text = playlistData.presenterName
            thumbnailImage.kf.setImage(with: playlistData.thumbnailURL)
        }
    }
    

}

// MARK: Setup UI
extension VideoDetailViewController {
    func setupUI() {
        setupThumbnailImage()
        setupPlayButton()
        setupVideoDuration()
        setupVideoTitle()
        setupDescription()
    }
    

    
    func setupThumbnailImage() {
        self.view.addSubview(thumbnailImage)
        NSLayoutConstraint.activate([
            thumbnailImage.topAnchor.constraint(equalTo: self.view.topAnchor),
            thumbnailImage.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            thumbnailImage.heightAnchor.constraint(equalTo: thumbnailImage.widthAnchor, multiplier: 9.0/16.0)
        ])
    }
    
    func setupPlayButton() {
        self.view.addSubview(playButton)
        NSLayoutConstraint.activate([
            playButton.topAnchor.constraint(equalTo: thumbnailImage.bottomAnchor,constant: 8),
            playButton.widthAnchor.constraint(equalTo: view.widthAnchor,constant: 16)
        ])
    }
    
    func setupVideoDuration() {
        self.view.addSubview(videoDuration)
        NSLayoutConstraint.activate([
            videoDuration.topAnchor.constraint(equalTo: playButton.bottomAnchor,constant: 16),
            videoDuration.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16)
        ])
    }
    
    func setupVideoTitle() {
        self.view.addSubview(videoTitle)
        NSLayoutConstraint.activate([
            videoTitle.topAnchor.constraint(equalTo: videoDuration.bottomAnchor, constant: 16),
            videoTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
        ])
    }
    
    func setupDescription() {
        self.view.addSubview(videoDescription)
        NSLayoutConstraint.activate([
            videoDescription.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 16),
            videoDescription.topAnchor.constraint(equalTo: videoTitle.bottomAnchor,constant: 16)
        ])
    }
}
