//
//  DetailsPageVC.swift
//  Sandro Giorgishvili 15
//
//  Created by TBC on 12.07.22.
//

import UIKit

protocol MainPageDelegate {
    func addToFavorite(indexPath: IndexPath) -> Bool
}

class DetailsPageVC: UIViewController {
    
    var delegate: MainPageDelegate!
    
    var indexPath: IndexPath?
    
    var filmTitle: String?
    var releaseDate: String?
    var imdb: Double?
    var mainActor: String?
    var seen: Bool?
    var isFavourite: Bool?
    var descriptionOfFilm: String?
    
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var imdbLbl: UILabel!
    @IBOutlet weak var mainActorLbl: UILabel!
    @IBOutlet weak var seenLbl: UILabel!
    @IBOutlet weak var isFavouriteLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var favoriteDeciderButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let isFavourite = isFavourite else {
            return
        }

        if isFavourite { favoriteDeciderButton.isHidden = true }
        
        guard let filmTitle = filmTitle else {
            return
        }

        guard let releaseDate = releaseDate else {
            return
        }

        guard let imdb = imdb else {
            return
        }

        guard let mainActor = mainActor else {
            return
        }

        guard let seen = seen else {
            return
        }

        guard let descriptionOfFilm = descriptionOfFilm else {
            return
        }


        titleLbl.text = "Title: \(filmTitle)"
        releaseDateLbl.text = "Release Date: \(releaseDate)"
        imdbLbl.text = "IMDB: \(imdb)"
        mainActorLbl.text = "Main Actor: \(mainActor)"
        seenLbl.text = "Seen: \(seen)"
        isFavouriteLbl.text = "Is Favourite: \(isFavourite)"
        descriptionLbl.text = "Description: \(descriptionOfFilm)"
    }
    
    func showPopUpWithTitleAndMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
    
    @IBAction func addToFavorite(_ sender: Any) {
        guard let indexPath = indexPath else {
            return
        }
        if delegate.addToFavorite(indexPath: indexPath) {
            favoriteDeciderButton.isHidden = true
            isFavouriteLbl.text = "Is Favourite: True"
            showPopUpWithTitleAndMessage(title: "Success", message: "Film added to favorite list")
        }
        else {
            showPopUpWithTitleAndMessage(title: "Failure", message: "Film could not be dded to favorite list")
        }
    }
}
