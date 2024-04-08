//
//  PlaylistMoveDeleteModel.swift
//  Lesson12HW
//

//

import Foundation

protocol PlaylistMoveDeleteModelDelegate: AnyObject {
    
    func dataDidLoad()
}

class PlaylistMoveDeleteModel {
    
    weak var delegate: PlaylistMoveDeleteModelDelegate?
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
    
    func moveSong(from sourceIndex: Int, to destinationIndex: Int) {
        let songToMove = songs.remove(at: sourceIndex)
        songs.insert(songToMove, at: destinationIndex)
    }
}
