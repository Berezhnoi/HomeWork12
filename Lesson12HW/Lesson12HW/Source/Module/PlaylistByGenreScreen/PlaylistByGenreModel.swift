//
//  PlaylistByGenreModel.swift
//  Lesson12HW
//

//

import Foundation

protocol PlaylistByGenreModelDelegate: AnyObject {
    func dataDidLoad()
}

class PlaylistByGenreModel {
    
    weak var delegate: PlaylistByGenreModelDelegate?
    private let dataLoader = DataLoaderService()
    private var songsByGenre: [String: [Song]] = [:]
    
    func loadData() {
        dataLoader.loadPlaylist { [weak self] playlist in
            guard let self = self else { return }
            if let playlist = playlist {
                self.songsByGenre = Dictionary(grouping: playlist.songs, by: { $0.genre })
                self.delegate?.dataDidLoad()
            }
        }
    }
    
    func numberOfGenres() -> Int {
        return songsByGenre.keys.count
    }
    
    func numberOfSongs(inSection section: Int) -> Int {
        let genre = Array(songsByGenre.keys)[section]
        return songsByGenre[genre]?.count ?? 0
    }
    
    func genre(at section: Int) -> String {
        return Array(songsByGenre.keys)[section]
    }
    
    func song(at index: Int, inSection section: Int) -> Song {
        let genre = Array(songsByGenre.keys)[section]
        return songsByGenre[genre]![index]
    }
}
