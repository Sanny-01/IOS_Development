//
//  detailsPageVC + CollectionView.swift
//  Sandro Giorgishvili 15
//
//  Created by sgiorgishvili on 14.07.22.
//

import UIKit

extension DetailsPageVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 120, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let film = difDataSource.itemIdentifier(for: indexPath)
        
        let movieUpdated =  allMoviesWithCorrectIndexpath.filter { $0.title == film?.title}
        
        guard let film = film else {
            return
        }
        
        filmTitle = movieUpdated[0].title
        releaseDate = movieUpdated[0].releaseDate
        imdb = movieUpdated[0].imdb
        genre =  movieUpdated[0].genre
        mainActor = movieUpdated[0].mainActor
        seen = movieUpdated[0].seen
        isFavourite = movieUpdated[0].isFavourite
        descriptionOfFilm = movieUpdated[0].description
        
        fillData()
        
        moviesToShow.removeAll()
        moviesToShow = allMovies.filter{ $0.genre == genre && $0.title != (film.title) }
        updatedataSource()
    }
}
