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
        nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        nameLabel.numberOfLines = 0
        return nameLabel
    }()
    
    let albumNameLabel: UILabel = {
        let albumName = UILabel()
        albumName.translatesAutoresizingMaskIntoConstraints = false
        albumName.font = UIFont.boldSystemFont(ofSize: 15)
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
        releaseDataLabel.font = UIFont.boldSystemFont(ofSize: 15)
        releaseDataLabel.numberOfLines = 0
        return releaseDataLabel
    }()
    
    let copyrightLabel: UILabel = {
        let copyrightLabel = UILabel()
        copyrightLabel.translatesAutoresizingMaskIntoConstraints = false
        copyrightLabel.font = UIFont.boldSystemFont(ofSize: 15)
        copyrightLabel.numberOfLines = 0
        return copyrightLabel
    }()
    
    let genreLabel: UILabel = {
        let genresLabel = UILabel()
        genresLabel.translatesAutoresizingMaskIntoConstraints = false
        genresLabel.font = UIFont.boldSystemFont(ofSize: 15)
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
        button.backgroundColor = UIColor.green
        button.setTitle(Constant.appStore, for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        return button
    }()
    
    @objc func buttonAction(sender: UIButton!) {
        guard let artistURL = artistUrl, let url = URL(string: artistURL) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            let alert = UIAlertController(title: Constant.message, message: Constant.notAvailable, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: Constant.ok, style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
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
        artistNameLabel.text = "Artist: \(viewModel?.getName() ?? Constant.notAvailable)"
        albumNameLabel.text = "Album : \(viewModel?.getAlbumName() ?? Constant.notAvailable)"
        releaseDateLabel.text = "Relase Date:  \(viewModel?.getReleaseDate() ?? Constant.notAvailable)"
        copyrightLabel.text = "Copy Right: \(viewModel?.getCopyRights() ?? Constant.notAvailable)"
        genreLabel.text = "Genre: \(viewModel?.getGenre() ?? Constant.notAvailable)"
        viewModel?.getImage{ (data) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.albumImageView.image = UIImage(data: data)
            }
        }
    }
}
