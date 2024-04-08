//
//  PlaylistDeleteModel.swift
//  Lesson12HW
//

//

import Foundation

protocol PlaylistDeleteModelDelegate: AnyObject {

    func dataDidLoad()
}

class PlaylistDeleteModel {
    
    weak var delegate: PlaylistDeleteModelDelegate?
    private let dataLoader = DataLoaderService()
    
    private var songs: [Song] = []
    
    func loadData() {
        
        dataLoader.loadPlaylist { playlist in
            
            self.songs = playlist?.songs ?? []
            self.delegate?.dataDidLoad()
        }
    }
    
    func numberOfSongs() -> Int {
        return songs.count
    }
    
    func song(at index: Int) -> Song {
        return songs[index]
    }
    
    func deleteSong(at index: Int) {
        songs.remove(at: index)
    }
}
