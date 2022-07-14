//
//  MovieCells.swift
//  Sandro Giorgishvili 15
//
//  Created by TBC on 14.07.22.
//

import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func filterMoviesByGenre(genre: String) -> ([Movie], [Movie], [Movie]) {
        moviesForSection1ByGenre.removeAll()
        moviesForSection2ByGenre.removeAll()
        
        if genre == "comedy" {
            moviesForSection0ByGenre = moviesToShow.filter{ $0.genre == .comedy}
            moviesForSection1ByGenre = moviesForSection1.filter{ $0.genre == .comedy}
            moviesForSection2ByGenre = moviesForSection2.filter{ $0.genre == .comedy}
        }
        else if genre == "drama" {
            moviesForSection0ByGenre = moviesToShow.filter{ $0.genre == .drama}
            moviesForSection1ByGenre = moviesForSection1.filter{ $0.genre == .drama}
            moviesForSection2ByGenre = moviesForSection2.filter{ $0.genre == .drama}
        }else if genre == "action" {
            moviesForSection0ByGenre = moviesToShow.filter{ $0.genre == .action}
            moviesForSection1ByGenre = moviesForSection1.filter{ $0.genre == .action}
            moviesForSection2ByGenre = moviesForSection2.filter{ $0.genre == .action}
        } else {
            moviesForSection0ByGenre = moviesToShow
            moviesForSection1ByGenre = moviesForSection1
            moviesForSection2ByGenre = moviesForSection2
        }
        
        return (moviesForSection0ByGenre, moviesForSection1ByGenre,  moviesForSection2ByGenre)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allSectionMoviesByGenre = filterMoviesByGenre(genre: sortByGenre)
        if section == 0 {
            return allSectionMoviesByGenre.0.count
        } else if section == 1 {
            return allSectionMoviesByGenre.1.count
        } else {
            return allSectionMoviesByGenre.2.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let currentMovie = allSectionMoviesByGenre.0[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
            cell.imdbLbl.text = "\(currentMovie.imdb)"
            cell.movieTitleLbl.text = "\(currentMovie.title)"
            cell.delegate = self
            return cell
        } else if indexPath.section == 1 {
//            let currentMovie1 = moviesForSection1[indexPath.row]
            let currentMovie1 = allSectionMoviesByGenre.1[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
            cell.imdbLbl.text = "\(currentMovie1.imdb)"
            cell.movieTitleLbl.text = "\(currentMovie1.title)"
            return cell
        } else {
            let currentMovie2 = allSectionMoviesByGenre.2[indexPath.row]
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
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//             return "Movies to Filter"
//        } else if section == 1 {
//            return "Seen/Favorite Movies"
//        } else {
//            return "Not Favorite/Seen Movies"
//        }
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var moviesToPass = [Movie]()
        
        if indexPath.section == 0 { moviesToPass = allSectionMoviesByGenre.0 }
        else if indexPath.section == 1 { moviesToPass = allSectionMoviesByGenre.1 }
        else { moviesToPass = allSectionMoviesByGenre.2 }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "details_page_vc") as? DetailsPageVC
        
        guard let detailsPageVC = vc else { return }
        detailsPageVC.delegate = self
        
        detailsPageVC.indexPath = indexPath
        detailsPageVC.filmTitle = moviesToPass[indexPath.row].title
        detailsPageVC.releaseDate = moviesToPass[indexPath.row].releaseDate
        detailsPageVC.genre = moviesToPass[indexPath.row].genre
        detailsPageVC.imdb = moviesToPass[indexPath.row].imdb
        detailsPageVC.mainActor = moviesToPass[indexPath.row].mainActor
        detailsPageVC.seen = moviesToPass[indexPath.row].seen
        detailsPageVC.isFavourite = moviesToPass[indexPath.row].isFavourite
        detailsPageVC.descriptionOfFilm = moviesToPass[indexPath.row].description
        detailsPageVC.allMoviesWithCorrectIndexpath = allSectionMoviesByGenre.0 + allSectionMoviesByGenre.1 + allSectionMoviesByGenre.2
        
        self.navigationController?.pushViewController(detailsPageVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}
