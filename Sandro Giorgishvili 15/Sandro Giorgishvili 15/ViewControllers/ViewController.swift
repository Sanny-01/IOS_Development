//
//  ViewController.swift
//  Sandro Giorgishvili 15
//
//  Created by TBC on 12.07.22.
//

import UIKit

class ViewController: UIViewController, MovieCellDelegate, MainPageDelegate {
    
    enum Section {
        case one
    }
    
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var genresCollectionView: UICollectionView!
    @IBOutlet weak var filterButoon: UIButton!
    
    var moviesToShow = Movie.movies
    var allMovies = Movie.movies
    
    var moviesForSection1 = [Movie]()
    var moviesForSection2 = [Movie]()
    
    var moviesForSection0ByGenre = [Movie]()
    var moviesForSection1ByGenre = [Movie]()
    var moviesForSection2ByGenre = [Movie]()
    // use this as parameter
    var sortByGenre = "all"
    var allSectionMoviesByGenre: ([Movie], [Movie], [Movie]) = ([], [], [])
    
    var genreForCells = Genres.genres
    
    var difDataSource: UICollectionViewDiffableDataSource<Section, Genres>!
    
    var filterUsingSeen = true
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        moviesTableView.reloadData()
        
        if filterUsingSeen {
            filterButoon.setTitle("Using Favorite", for: .normal)
        } else {
            filterButoon.setTitle("Using Seen", for: .normal)
        }
        
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        
        configureCollectionView()
        updatedataSource()
    }
    
    // if you add movie to favorite from details page
    func addToFavorite(title: String) -> [Movie] {
        var row = 0
        var section = 0
        
        if allSectionMoviesByGenre.0.contains(where: {$0.title == title}) {
            section = 0
            for i in 0..<allSectionMoviesByGenre.0.count {
                if allSectionMoviesByGenre.0[i].title == title {
                    row = i
                    break;
                }
            }
        } else if allSectionMoviesByGenre.1.contains(where: {$0.title == title}) {
            section = 1
            
            for i in 0..<allSectionMoviesByGenre.1.count {
                if allSectionMoviesByGenre.1[i].title == title {
                    row = i
                    break;
                }
            }
        } else {
            section = 2
            
            for i in 0..<allSectionMoviesByGenre.2.count {
                if allSectionMoviesByGenre.2[i].title == title {
                    row = i
                    break;
                }
            }
        }
        
        
        if section == 0 {
            allSectionMoviesByGenre.0[row].isFavourite = true
            let addedToFavoriteMovieTitle = allSectionMoviesByGenre.0[row].title
            
            for i in 0..<moviesToShow.count {
                if moviesToShow[i].title == addedToFavoriteMovieTitle {
                    moviesToShow[i].isFavourite = true
                    break
                }
            }
            
            moviesTableView.reloadData()
        }
        else if section == 1 {
            allSectionMoviesByGenre.1[row].isFavourite = true
            let addedToFavoriteMovieTitle = allSectionMoviesByGenre.1[row].title
            
            
            for i in 0..<moviesForSection1.count {
                if moviesForSection1[i].title == addedToFavoriteMovieTitle {
                    moviesForSection1[i].isFavourite = true
                    break
                }
            }
            
            moviesTableView.reloadData()
            
        }
        else {
            allSectionMoviesByGenre.2[row].isFavourite = true
            let addedToFavoriteMovieTitle = allSectionMoviesByGenre.2[row].title
            
            
            for i in 0..<moviesForSection2.count {
                if moviesForSection2[i].title == addedToFavoriteMovieTitle {
                    moviesForSection2[i].isFavourite = true
                    break
                }
            }
            
            moviesTableView.reloadData()
        }
        
        return allSectionMoviesByGenre.0 + allSectionMoviesByGenre.1 + allSectionMoviesByGenre.2
    }
    
    func configureCollectionView() {
        genresCollectionView.delegate = self
        
        let customFlowLayout = UICollectionViewFlowLayout()
        customFlowLayout.minimumLineSpacing = 25
        customFlowLayout.scrollDirection = .horizontal
        genresCollectionView.collectionViewLayout = customFlowLayout
        
        createDifDatasource()
    }
    
    func createDifDatasource() {
        difDataSource = UICollectionViewDiffableDataSource(collectionView: genresCollectionView, cellProvider: { collectionView, indexPath,
            genresForCells in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCell", for: indexPath) as! GenreCell
            cell.genre = "\(genresForCells.genre)"
            return cell
        })
    }
    
    func updatedataSource() {
        var screenshot = NSDiffableDataSourceSnapshot<Section,Genres>()
        screenshot.appendSections([.one])
        screenshot.appendItems(genreForCells, toSection: .one)
        difDataSource.apply(screenshot)
    }
    
    
    func reArrangeDataUsingFavorite() {
        let allMoviesInFilteredSections = getAllMoviesFromFilteredSections()
        eraseAllMoviesInFilteredSection()
        
        moviesForSection1 = allMoviesInFilteredSections.filter{ $0.isFavourite }
        moviesForSection2 = allMoviesInFilteredSections.filter{ $0.isFavourite == false }
        
        moviesTableView.reloadData()
    }
    
    func addMovie(cell: MovieCell) {
        
        // გვაქს სამი მასივი სექციებისთვის. ერთგან არის ის ფილმები, რომლებიც ჟანრის ფილტრის გარეშე იქნებოდა გამოტანილი თითოეულ სექციაში და მეორეგან არის ფილმები, რომლებიც ჟანრის გაფილტვრის მერე გამოვა შესაბამის სექციებში. ასე იმიტომ გვინდა, რომ დავუშვათ, როცა რომელიმე ჯანრის ფილმები გვაქვს მხოლოდ გაფილტრული და სექციაში ვამატებთ ფილმს, შემდეგ კი ვუბრუნდებით საწყისს მდგომარეობას და ვაჩენთ ყველა ჟანრის ფილმს, ყველა მონაცემი შენახული იქნება შესაბამის სექციაში და აღად დასჭირდება ახლიდან ჩამატება.
        
        if let indexPath = moviesTableView.indexPath(for: cell) {
            
            // check if there are movies left in first section
            if moviesToShow.count > 0 {
                let movie = moviesForSection0ByGenre[indexPath.row]
                
                if filterUsingSeen {
                    // check if movie is seen or not
                    if movie.seen {
                        moviesForSection1.append(movie)
                    } else {
                        moviesForSection2.append(movie)
                    }
                } else {
                    
                    // check if movie is favorite or not
                    if movie.isFavourite {
                        moviesForSection1.append(movie)
                    } else {
                        moviesForSection2.append(movie)
                    }
                }
                
                let filteredMovies =  moviesToShow.filter{
                    $0.title != movie.title
                }
                moviesToShow.removeAll()
                moviesToShow = filteredMovies
                moviesTableView.reloadData()
            }
        }
    }
    
    func getAllMoviesFromFilteredSections() ->[Movie] {
        return moviesForSection1 + moviesForSection2
    }
    
    func eraseAllMoviesInFilteredSection() {
        moviesForSection1.removeAll()
        moviesForSection2.removeAll()
    }
    
//    func filterUsing
    @IBAction func changeParameter(_ sender: Any) {
        
        if filterUsingSeen {
            filterUsingSeen = false
            filterButoon.setTitle("Using Seen", for: .normal)
            
            let allMoviesInFilteredSections = getAllMoviesFromFilteredSections()
            eraseAllMoviesInFilteredSection()

            moviesForSection1 = allMoviesInFilteredSections.filter{ $0.isFavourite }
            moviesForSection2 = allMoviesInFilteredSections.filter{ $0.isFavourite == false }
            
        } else {
            filterUsingSeen = true
            filterButoon.setTitle("Using Favorite", for: .normal)
            
            let allMoviesInFilteredSections = getAllMoviesFromFilteredSections()
            eraseAllMoviesInFilteredSection()
            
            moviesForSection1 = allMoviesInFilteredSections.filter{ $0.seen }
            moviesForSection2 = allMoviesInFilteredSections.filter{ $0.seen == false }
        }
        moviesTableView.reloadData()
    }
}
