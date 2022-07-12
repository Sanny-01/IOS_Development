//
//  ViewController.swift
//  Sandro Giorgishvili 15
//
//  Created by TBC on 12.07.22.
//

import UIKit

class ViewController: UIViewController, MovieCellDelegate, MainPageDelegate {
    
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var filterButoon: UIButton!
    
    var movies = [Movie]()
    var moviesForSection1 = [Movie]()
    var moviesForSection2 = [Movie]()
    
    var filterUsingSeen = true
    
    func addToFavorite(indexPath: IndexPath) -> Bool {
        
        if indexPath.section == 0 {
            movies[indexPath.row].isFavourite = true
            
            return movies[indexPath.row].isFavourite
        }
        else if indexPath.section == 1 {
            moviesForSection1[indexPath.row].isFavourite = true
            let check = moviesForSection2[indexPath.row].isFavourite
            if filterUsingSeen == false {
                reArrangeDataUsingFavorite()
            }
            
            return check
            
        }
        else {
            moviesForSection2[indexPath.row].isFavourite = true
            let check = moviesForSection2[indexPath.row].isFavourite
            if filterUsingSeen == false {
                reArrangeDataUsingFavorite()
            }
        
            return check
        }
    }
    
    func reArrangeDataUsingFavorite() {
        var allMoviesInFilteredSections = [Movie]()
        moviesForSection1.forEach{ allMoviesInFilteredSections.append($0) }
        moviesForSection2.forEach{ allMoviesInFilteredSections.append($0) }
        
        moviesForSection1.removeAll()
        moviesForSection2.removeAll()
        
        moviesForSection1 = allMoviesInFilteredSections.filter{ $0.isFavourite }
        moviesForSection2 = allMoviesInFilteredSections.filter{ $0.isFavourite == false }
        
        moviesTableView.reloadData()
    }
    
    func addMovie(cell: MovieCell) {
        
        if let indexPath = moviesTableView.indexPath(for: cell) {
            
            // check if there are movies left in first section
            if movies.count > 0 {
                if filterUsingSeen {
                    let movie = movies[indexPath.row]
                    
                    // check if movie is seen or not
                    if movie.seen {
                        moviesForSection1.append(movie)
                    } else {
                        moviesForSection2.append(movie)
                    }
                    // remove movie
                    let filteredMovies =  movies.filter{
                        $0.title != movies[indexPath.row].title
                    }
                    movies.removeAll()
                    movies = filteredMovies
                    moviesTableView.reloadData()
                } else {
                    let movie = movies[indexPath.row]
                    
                    // check if movie is seen or not
                    if movie.isFavourite {
                        moviesForSection1.append(movie)
                    } else {
                        moviesForSection2.append(movie)
                    }
                    
                    // remove movie
                    let filteredMovies =  movies.filter{
                        $0.title != movies[indexPath.row].title
                    }
                    movies.removeAll()
                    movies = filteredMovies
                    moviesTableView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesTableView.reloadData()
        // get all movies
        if Movie.movies.count > movies.count {
            Movie.movies.forEach{
                movies.append($0)
            }
            
            if filterUsingSeen {
                filterButoon.setTitle("Using Favorite", for: .normal)
            } else {
                filterButoon.setTitle("Using Seen", for: .normal)
            }
        }
        
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
    }
    
    @IBAction func changeParameter(_ sender: Any) {
        
        if filterUsingSeen {
            filterUsingSeen = false
            filterButoon.setTitle("Using Seen", for: .normal)
            
            var allMoviesInFilteredSections = [Movie]()
            moviesForSection1.forEach{ allMoviesInFilteredSections.append($0) }
            moviesForSection2.forEach{ allMoviesInFilteredSections.append($0) }
            
            moviesForSection1.removeAll()
            moviesForSection2.removeAll()
            
            moviesForSection1 = allMoviesInFilteredSections.filter{ $0.isFavourite }
            moviesForSection2 = allMoviesInFilteredSections.filter{ $0.isFavourite == false }
            
        } else {
            filterUsingSeen = true
            filterButoon.setTitle("Using Favorite", for: .normal)
            
            var allMoviesInFilteredSections = [Movie]()
            moviesForSection1.forEach{ allMoviesInFilteredSections.append($0) }
            moviesForSection2.forEach{ allMoviesInFilteredSections.append($0) }
            
            moviesForSection1.removeAll()
            moviesForSection2.removeAll()
            
            moviesForSection1 = allMoviesInFilteredSections.filter{ $0.seen }
            moviesForSection2 = allMoviesInFilteredSections.filter{ $0.seen == false }
        }
        moviesTableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return movies.count
        } else if section == 1 {
            return moviesForSection1.count
        } else {
            return moviesForSection2.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let currentMovie = movies[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
            cell.imdbLbl.text = "\(currentMovie.imdb)"
            cell.movieTitleLbl.text = "\(currentMovie.title)"
            cell.delegate = self
            return cell
        } else if indexPath.section == 1 {
            
            let currentMovie1 = moviesForSection1[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
            cell.imdbLbl.text = "\(currentMovie1.imdb)"
            cell.movieTitleLbl.text = "\(currentMovie1.title)"
            return cell
        } else {
            let currentMovie2 = moviesForSection2[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
            cell.imdbLbl.text = "\(currentMovie2.imdb)"
            cell.movieTitleLbl.text = "\(currentMovie2.title)"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewForHeader = UIView()
        if section == 0 {
            viewForHeader.backgroundColor = .gray
        } else if section == 1 {
            viewForHeader.backgroundColor = .green
        } else {
            viewForHeader.backgroundColor = .red
        }
        return viewForHeader
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
             return "Movies to Filter"
        } else if section == 1 {
            return "Seen/Favorite Movies"
        } else {
            return "Not Favorite/Seen Movies"
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var moviesToPass = [Movie]()
        
        if indexPath.section == 0 { moviesToPass = movies }
        else if indexPath.section == 1 { moviesToPass = moviesForSection1 }
        else { moviesToPass = moviesForSection2 }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "details_page_vc") as? DetailsPageVC
        
        guard let detailsPageVC = vc else { return }
        detailsPageVC.delegate = self
        
        detailsPageVC.indexPath = indexPath
        detailsPageVC.filmTitle = moviesToPass[indexPath.row].title
        detailsPageVC.releaseDate = moviesToPass[indexPath.row].releaseDate
        detailsPageVC.imdb = moviesToPass[indexPath.row].imdb
        detailsPageVC.mainActor = moviesToPass[indexPath.row].mainActor
        detailsPageVC.seen = moviesToPass[indexPath.row].seen
        detailsPageVC.isFavourite = moviesToPass[indexPath.row].isFavourite
        detailsPageVC.descriptionOfFilm = moviesToPass[indexPath.row].description
        
        self.navigationController?.pushViewController(detailsPageVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}
