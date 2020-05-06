//
//  DetailViewController.swift
//  ItuneRssNikeCodeAssign
//
//  Created by Ruoming Gao on 5/4/20.
//  Copyright © 2020 Ruoming Gao. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var artistUrl: String?
    
    let artistNameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.numberOfLines = 0
        return nameLabel
    }()
    
    let albumNameLabel: UILabel = {
        let albumName = UILabel()
        albumName.translatesAutoresizingMaskIntoConstraints = false
        albumName.font = UIFont.boldSystemFont(ofSize: 20)
        albumName.numberOfLines = 0
        return albumName
    }()
    
    let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let releaseDateLabel: UILabel = {
        let releaseDataLabel = UILabel()
        releaseDataLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDataLabel.font = UIFont.boldSystemFont(ofSize: 20)
        releaseDataLabel.numberOfLines = 0
        return releaseDataLabel
    }()
    
    let copyrightLabel: UILabel = {
        let copyrightLabel = UILabel()
        copyrightLabel.translatesAutoresizingMaskIntoConstraints = false
        copyrightLabel.font = UIFont.boldSystemFont(ofSize: 20)
        copyrightLabel.numberOfLines = 0
        return copyrightLabel
    }()
    
    let genreLabel: UILabel = {
        let genresLabel = UILabel()
        genresLabel.translatesAutoresizingMaskIntoConstraints = false
        genresLabel.font = UIFont.boldSystemFont(ofSize: 20)
        genresLabel.numberOfLines = 0
        return genresLabel
    }()
    
    let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = UIStackView.Alignment.leading
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let ituneButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.blue
        button.setTitle(Constant.appStore, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func buttonAction(sender: UIButton!) {
        guard let artistURL = artistUrl, let url = URL(string: artistURL) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(albumImageView)
        labelStackView.addArrangedSubview(artistNameLabel)
        labelStackView.addArrangedSubview(albumNameLabel)
        labelStackView.addArrangedSubview(releaseDateLabel)
        labelStackView.addArrangedSubview(copyrightLabel)
        labelStackView.addArrangedSubview(genreLabel)
        view.addSubview(labelStackView)
        view.addSubview(ituneButton)
        
        let viewsDict = [
            "albumImage": albumImageView,
            "labelStackView": labelStackView,
            "ituneButton": ituneButton
        ]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[albumImage(300)]-[labelStackView]", options: [], metrics: nil, views: viewsDict))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[ituneButton(30)]-20-|", options: [], metrics: nil, views: viewsDict))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[albumImage]-|", options: [], metrics: nil, views: viewsDict))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[labelStackView]-|", options: [], metrics: nil, views: viewsDict))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[ituneButton]-20-|", options: [], metrics: nil, views: viewsDict))
    }
    
    func getConfigure(viewModel: ResultViewModel?) {
        artistUrl = viewModel?.getArtistUrl()
        artistNameLabel.text = viewModel?.getName()
        albumNameLabel.text = viewModel?.getAlbumName()
        releaseDateLabel.text = viewModel?.getReleaseDate()
        copyrightLabel.text = viewModel?.getCopyRights()
        genreLabel.text = viewModel?.getGenre()
        viewModel?.getImage(completion: { (data) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.albumImageView.image = UIImage(data: data)
            }
        })
    }
}
