//
//  VideoItemCell.swift
//  QuipperTest
//
//  Created by Rahman Bramantya on 23/05/24.
//

import UIKit
import Kingfisher

class VideoItemCell: UITableViewCell {
    // MARK: Properties Declaration
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .black
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        return titleLabel
    }()
    
    lazy var presenterNameLabel: UILabel = {
        let presenterNameLabel = UILabel()
        presenterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        presenterNameLabel.textColor = .subtleTextColor

        return presenterNameLabel
    }()
    
    lazy var videoDurationLabel: UILabel = {
        let videoDurationLabel = UILabel()
        videoDurationLabel.translatesAutoresizingMaskIntoConstraints = false
        videoDurationLabel.textColor = .black
        videoDurationLabel.lineBreakMode = .byTruncatingTail
        videoDurationLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        videoDurationLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
 
        return videoDurationLabel
    }()
    
    lazy var videoThumbnail: UIImageView = {
        let videoThumbnail = UIImageView()
        videoThumbnail.translatesAutoresizingMaskIntoConstraints = false
        videoThumbnail.contentMode = .scaleAspectFill

        return videoThumbnail
    }()
    
    
    // MARK: Initialization

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    override func layoutSubviews() {
        videoThumbnail.layer.cornerRadius =  videoThumbnail.frame.size.width / 14
        videoThumbnail.clipsToBounds = true
    }
    
    func setData(videoItemData: PlaylistModel) {
        titleLabel.text = videoItemData.title ?? ""
        presenterNameLabel.text = videoItemData.presenterName ?? ""
        videoThumbnail.kf.setImage(with: videoItemData.thumbnailURL)
        videoDurationLabel.text = videoItemData.formatMilliseconds()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

// MARK: Setup UI
extension VideoItemCell {
    func setupUI() {
        setupThumbnailUI()
        setupTitleLabelUI()
        setupPresenterNameLabelUI()
        setupVideoDurationLaelUI()
    }
    
    func setupThumbnailUI() {
        self.addSubview(videoThumbnail)
        NSLayoutConstraint.activate([
            videoThumbnail.topAnchor.constraint(equalTo: topAnchor),
            videoThumbnail.centerXAnchor.constraint(equalTo: centerXAnchor),
            videoThumbnail.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.9),
            videoThumbnail.heightAnchor.constraint(equalTo: videoThumbnail.widthAnchor, multiplier: 9.0/16.0)
        ])
    }
    
    func setupTitleLabelUI() {
        self.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: videoThumbnail.bottomAnchor,constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8)
        ])
    }
    
    func setupPresenterNameLabelUI() {
        self.addSubview(presenterNameLabel)
        NSLayoutConstraint.activate([
            presenterNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 6),
            presenterNameLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ])
    }
    
    func setupVideoDurationLaelUI() {
        self.addSubview(videoDurationLabel)
        NSLayoutConstraint.activate([
            videoDurationLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor,constant: 8),
            videoDurationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            videoDurationLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor)
        ])
    }
}
