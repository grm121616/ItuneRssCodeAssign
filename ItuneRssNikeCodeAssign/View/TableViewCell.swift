//
//  TableViewCell.swift
//  ItuneRssNikeCodeAssign
//
//  Created by Ruoming Gao on 5/4/20.
//  Copyright © 2020 Ruoming Gao. All rights reserved.
//
import UIKit

class TableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.numberOfLines = 0
        return nameLabel
    }()
    
    let albumNameLabel: UILabel = {
        let albumName = UILabel()
        albumName.translatesAutoresizingMaskIntoConstraints = false
        albumName.widthAnchor.constraint(equalToConstant: 200).isActive = true
        albumName.font = UIFont.boldSystemFont(ofSize: 20)
        albumName.numberOfLines = 0
        return albumName
    }()
    
    let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    func setup() {
        let viewsDict = [
            "name": nameLabel,
            "albumName": albumNameLabel,
            "albumImage": albumImageView
        ]
        contentView.addSubview(nameLabel)
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(albumImageView)
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[name]-[albumName]", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[name]-[albumImage]", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[albumName]-[albumImage]|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[albumImage(150)]-|", options: [], metrics: nil, views: viewsDict))
    }
    
    func getConfigure(viewModel: ResultViewModel?) {
        nameLabel.text = "Artist: \(viewModel?.getName() ?? "Not available")"
        albumNameLabel.text = "Album: \(viewModel?.getAlbumName() ?? "")"
        viewModel?.getImage(completion: { (data) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.albumImageView.image = UIImage(data: data)
            }
        })
    }
}
