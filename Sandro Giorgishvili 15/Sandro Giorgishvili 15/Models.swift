//
//  Models.swift
//  Sandro Giorgishvili 15
//
//  Created by sgiorgishvili on 12.07.22.
//

import Foundation

struct Movie: Hashable {
    
    static let movies = [
        Movie(title: "Avatar", releaseDate: "2009", genre: .action, imdb: 7.9, mainActor: "Sam Worthington", seen: false, isFavourite: true),
        Movie(title: "Bronx Tale", releaseDate: "2009", genre: .drama, imdb: 9.5, mainActor: "Sam Worthington", seen: true, isFavourite: false),
        Movie(title: "Shawshank Redemption", releaseDate: "2001", genre: .drama, imdb: 9.2, mainActor: "Sam xxz", seen: false, isFavourite: false),
        Movie(title: "Film4", releaseDate: "1999", genre: .action, imdb: 9.2, mainActor: "Actor1", seen: true, isFavourite: false),
        Movie(title: "Film5", releaseDate: "1995", genre: .drama, imdb: 7.5, mainActor: "Actor2", seen: false, isFavourite: false),
        Movie(title: "Film6", releaseDate: "1994", genre: .comedy, imdb: 6.8, mainActor: "Sam xxz", seen: true, isFavourite: true),
        Movie(title: "Film7", releaseDate: "2005", genre: .drama, imdb: 9.1, mainActor: "Actor6", seen: false, isFavourite: false),
        Movie(title: "Film8", releaseDate: "2003", genre: .action, imdb: 9.1, mainActor: "Actor 5", seen: true, isFavourite: false),
        Movie(title: "Film9", releaseDate: "2004", genre: .comedy, imdb: 8.5, mainActor: "Actonr3", seen: true, isFavourite: true)
    ]
    
    let title: String
    let releaseDate: String
    let genre: Genre
    let imdb: Double
    let mainActor: String
    let seen: Bool
    var isFavourite: Bool
    let description = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"
}

enum Genre {
    case comedy, action, drama
}

struct Genres: Hashable {
    static let genres = [ Genres(genre: "all"),
                          Genres(genre: "\(Genre.comedy)"),
                          Genres(genre: "\(Genre.action)"),
                          Genres(genre: "\(Genre.drama)")
    ]
    let genre: String
}
