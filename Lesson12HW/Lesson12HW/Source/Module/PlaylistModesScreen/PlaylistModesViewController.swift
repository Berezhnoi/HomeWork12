//
//  PlaylistModesViewController.swift
//  Lesson12HW
//

//

import UIKit

class PlaylistModesViewController: UIViewController {
    
    @IBOutlet weak var contentView: PlaylistModesView!
    var model: PlaylistModesModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        model.loadData()
    }
    
    private func setupInitialState() {
        
        model = PlaylistModesModel()
        
        contentView.delegate = self
   
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        
        // Register custom cell class with the table view
        contentView.tableView.register(MainPlaylistTableViewCell.self, forCellReuseIdentifier: MainPlaylistTableViewCell.identifier)
    }
}

// MARK: - PlaylistModesModelDelegate
extension PlaylistModesViewController: PlaylistModesModelDelegate {
    func dataDidLoad() {
        contentView.tableView.reloadData()
    }
}

// MARK: - PlaylistModesViewDelegate
extension PlaylistModesViewController: PlaylistModesViewDelegate {
    func segmentedControlDidChange(mode: PlaylistMode) {
        model.selectedMode = mode
        contentView.tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension PlaylistModesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch model.selectedMode {
        case .all:
            return model.numberOfSongs()
        case .genre:
            let genre = model.genre(at: section)
            return model.numberOfSongs(inGenre: genre)
        case .author:
            let author = model.author(at: section)
            return model.numberOfSongs(byAuthor: author)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainPlaylistTableViewCell.identifier, for: indexPath) as? MainPlaylistTableViewCell else {
            assertionFailure("Failed to dequeue MainPlaylistTableViewCell")
            return UITableViewCell()
        }
        
        switch model.selectedMode {
        case .all:
            let song = model.song(at: indexPath.row)
            configureCell(cell, with: song)
        case .genre:
            let genre = model.genre(at: indexPath.section)
            let song = model.song(at: indexPath.row, inGenre: genre)
            configureCell(cell, with: song)
        case .author:
            let author = model.author(at: indexPath.section)
            let song = model.song(at: indexPath.row, byAuthor: author)
            configureCell(cell, with: song)
        }
        
        return cell
    }
    
    private func configureCell(_ cell: MainPlaylistTableViewCell, with song: Song) {
        cell.titleLabel.text = song.songTitle
        cell.authorLabel.text = "Author: \(song.author)"
        cell.albumLabel.text = "Album: \(song.albumTitle)"
        cell.genreLabel.text = "Genre: \(song.genre)"
    }
}

// MARK: - UITableViewDelegate
extension PlaylistModesViewController: UITableViewDelegate {    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch model.selectedMode {
        case .all:
            return 1
        case .genre:
            return model.numberOfGenres()
        case .author:
            return model.numberOfAuthors()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch model.selectedMode {
        case .all:
            return nil
        case .genre:
            return model.genre(at: section)
        case .author:
            return model.author(at: section)
        }
    }
}
