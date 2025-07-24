//
//  MoviesTableViewCell.swift
//  CleanArchitectureWithMvvm
//
//  Created by mahesh mahara on 15/02/2025.
//

import UIKit
import SDWebImage

class MoviesTableViewCell: UITableViewCell {

    var userImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        return img
    }()

    var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    var releaseDate: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()

    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.numberOfLines = 10
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // Add UI elements to content view
        contentView.addSubview(userImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
      //  contentView.addSubview(releaseDate)

        // Set constraints for UI elements
        userImage.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
     //   releaseDate.translatesAutoresizingMaskIntoConstraints = false

        //Setup constraints
        NSLayoutConstraint.activate([
            userImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            userImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            userImage.widthAnchor.constraint(equalToConstant: 100),
            userImage.heightAnchor.constraint(equalToConstant: 150),
            

            nameLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            

            descriptionLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 10),
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10)
        ])
        
       
        
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(with moviesList:Result){
        print("image path = \(moviesList.posterPath)")
        // Example: Remote image URL
        let imageURL = "https://image.tmdb.org/t/p/w500\(moviesList.posterPath)"
        userImage.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
        nameLabel.text = moviesList.originalTitle
        releaseDate.text = "Release Date\(moviesList.releaseDate)"
        descriptionLabel.text = moviesList.overview
        
    }
    
    func filter(with moviesList:SearchResult){
        print("image path = \(moviesList.posterPath)")
        // Example: Remote image URL
        let imageURL = "https://image.tmdb.org/t/p/w500\(moviesList.posterPath)"
        userImage.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
        nameLabel.text = moviesList.originalTitle
        releaseDate.text = "Release Date\(moviesList.releaseDate)"
        descriptionLabel.text = moviesList.overview
        
    }
    
    
    
    
    
   
}
