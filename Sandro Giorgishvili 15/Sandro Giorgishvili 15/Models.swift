//
//  Models.swift
//  Sandro Giorgishvili 15
//
//  Created by sgiorgishvili on 12.07.22.
//

import Foundation

struct Movie {
    
    static let movies = [
        Movie(title: "Avatar", releaseDate: "2009", imdb: 7.9, mainActor: "Sam Worthington", seen: false, isFavourite: true),
        Movie(title: "Bronx Tale", releaseDate: "2009", imdb: 9.5, mainActor: "Sam Worthington", seen: true, isFavourite: false),
        Movie(title: "Shawshank Redemption", releaseDate: "12", imdb: 9.2, mainActor: "Sam xxz", seen: false, isFavourite: false)

    ]
    
    let title: String
    let releaseDate: String
    let imdb: Double
    let mainActor: String
    let seen: Bool
    var isFavourite: Bool
    let description = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"
}
