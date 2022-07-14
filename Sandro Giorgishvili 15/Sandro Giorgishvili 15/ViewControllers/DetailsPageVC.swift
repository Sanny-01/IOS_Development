//
//  DetailsPageVC.swift
//  Sandro Giorgishvili 15
//
//  Created by TBC on 12.07.22.
//

import UIKit

protocol MainPageDelegate{
    func addToFavorite(title: String) -> [Movie]
}

class DetailsPageVC: UIViewController{
    
    enum Section {
        case one
    }
    
    var delegate: MainPageDelegate!
    
    var indexPath: IndexPath?
    
    var filmTitle: String?
    var releaseDate: String?
    var imdb: Double?
    var genre: Genre?
    var mainActor: String?
    var seen: Bool?
    var isFavourite: Bool?
    var descriptionOfFilm: String?
    
    var difDataSource: UICollectionViewDiffableDataSource<Section, Movie>!
    var moviesToShow = [Movie]()
    var allMovies = ViewController().moviesToShow + ViewController().moviesForSection1 + ViewController().moviesForSection2
    var allMoviesWithCorrectIndexpath = [Movie]()
    
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var imdbLbl: UILabel!
    @IBOutlet weak var mainActorLbl: UILabel!
    @IBOutlet weak var seenLbl: UILabel!
    @IBOutlet weak var detailsPageCollectionView: UICollectionView!
    @IBOutlet weak var isFavouriteLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var favoriteDeciderButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(allMoviesWithCorrectIndexpath)
        fillData()
        
        configureCollectionView()
        updatedataSource()
    }
    
    func fillData() {
        guard let isFavourite = isFavourite else {
            return
        }
        
        if isFavourite { favoriteDeciderButton.isHidden = true }
        else { favoriteDeciderButton.isHidden = false }
        
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
        
        moviesToShow = allMovies.filter{ ($0.genre == genre && $0.title != filmTitle) }
    }
    
    func showPopUpWithTitleAndMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
    
    @IBAction func addToFavorite(_ sender: Any) {
        
        guard let filmTitle = filmTitle else {
            return
        }
        
        allMoviesWithCorrectIndexpath = delegate.addToFavorite(title: filmTitle)
        favoriteDeciderButton.isHidden = true
        isFavouriteLbl.text = "Is Favourite: True"
        showPopUpWithTitleAndMessage(title: "Success", message: "Film added to favorite list")
    }
    
    func configureCollectionView() {
        detailsPageCollectionView.delegate = self
        
        let customFlowLayout = UICollectionViewFlowLayout()
        customFlowLayout.minimumLineSpacing = 25
        customFlowLayout.scrollDirection = .horizontal
        detailsPageCollectionView.collectionViewLayout = customFlowLayout
        
        createDifDatasource()
    }
    
    func createDifDatasource() {
        difDataSource = UICollectionViewDiffableDataSource(collectionView: detailsPageCollectionView, cellProvider: { collectionView, indexPath,
            movie in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsPageCell", for: indexPath) as! DetailsPageCell
            cell.filmTitle = movie.title
            return cell
        })
    }
    
    func updatedataSource() {
        var screenshot = NSDiffableDataSourceSnapshot<Section,Movie>()
        screenshot.appendSections([.one])
        screenshot.appendItems(moviesToShow, toSection: .one)
        difDataSource.apply(screenshot)
    }
}
