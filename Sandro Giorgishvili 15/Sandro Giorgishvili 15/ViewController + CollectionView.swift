//
//  ViewController + CollectionView.swift
//  Sandro Giorgishvili 15
//
//  Created by sgiorgishvili on 14.07.22.
//

import UIKit

extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let genres = difDataSource.itemIdentifier(for: indexPath)
        guard let genre = genres?.genre else {
            return
        }
        
        sortByGenre = "\(genre)"
        moviesTableView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 70, height: 50)
    }
}
