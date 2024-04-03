//
//  PlaylistModesModel.swift
//  Lesson12HW
//

//

import Foundation

enum PlaylistMode: Int, CaseIterable {
    case all = 0
    case genre
    case author

    var segmentTitle: String {
        switch self {
        case .all:
            return "All"
        case .genre:
            return "Genre"
        case .author:
            return "Author"
        }
    }
    
    static var segmentTitles: [String] {
        return PlaylistMode.allCases.map { $0.segmentTitle }
    }
}

protocol PlaylistModesModelDelegate: AnyObject {
    func dataDidLoad()
}

class PlaylistModesModel {
    
    weak var delegate: PlaylistModesModelDelegate?
    private let dataLoader = DataLoaderService()

    var selectedMode: PlaylistMode = .all
    
    private var songs: [Song] = []
    private var songsByGenre: [String: [Song]] = [:]
    private var songsByAuthor: [String: [Song]] = [:]
    
    func loadData() {
        dataLoader.loadPlaylist { [weak self] playlist in
            guard let self = self else { return }
            if let playlist = playlist {
                self.songs = playlist.songs
                self.songsByGenre = Dictionary(grouping: playlist.songs, by: { $0.genre })
                self.songsByAuthor = Dictionary(grouping: playlist.songs, by: { $0.author })
                self.delegate?.dataDidLoad()
            }
        }
    }
    
    func numberOfSongs() -> Int {
        return songs.count
    }
    
    func numberOfSongs(inGenre genre: String) -> Int {
        return songsByGenre[genre]?.count ?? 0
    }
    
    func numberOfSongs(byAuthor author: String) -> Int {
        return songsByAuthor[author]?.count ?? 0
    }
    
    func song(at index: Int) -> Song {
        return songs[index]
    }
    
    func song(at index: Int, inGenre genre: String) -> Song {
        let genreSongs = songsByGenre[genre] ?? []
        return genreSongs[index]
    }
    
    func song(at index: Int, byAuthor author: String) -> Song {
        let authorSongs = songsByAuthor[author] ?? []
        return authorSongs[index]
    }
    
    func numberOfGenres() -> Int {
        return songsByGenre.keys.count
    }
    
    func genre(at index: Int) -> String {
        return Array(songsByGenre.keys)[index]
    }
    
    func numberOfAuthors() -> Int {
        return songsByAuthor.keys.count
    }
    
    func author(at index: Int) -> String {
        return Array(songsByAuthor.keys)[index]
    }
}
