//
//  PlaylistDeleteViewController.swift
//  Lesson12HW
//

//

import UIKit

class PlaylistDeleteViewController: UIViewController {
    
    @IBOutlet weak var contentView: PlaylistDeleteView!
    var model: PlaylistDeleteModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        model.loadData()
    }
    
    private func setupInitialState() {
        
        model = PlaylistDeleteModel()
        
        contentView.delegate = self
        
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        
        // Register custom cell class with the table view
        contentView.tableView.register(MainPlaylistTableViewCell.self, forCellReuseIdentifier: MainPlaylistTableViewCell.identifier)
    }
}

// MARK: - PlaylistDeleteModelDelegate
extension PlaylistDeleteViewController: PlaylistDeleteModelDelegate {
    func dataDidLoad() {
        contentView.tableView.reloadData()
    }
}

// MARK: - PlaylistDeleteViewDelegate
extension PlaylistDeleteViewController: PlaylistDeleteViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension PlaylistDeleteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.numberOfSongs()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainPlaylistTableViewCell.identifier, for: indexPath) as? MainPlaylistTableViewCell else {
            assertionFailure()
            return UITableViewCell()
         }
         
        let song = model.song(at: indexPath.row)
        
        // Configure the cell with song information
        cell.titleLabel.text = song.songTitle
        cell.authorLabel.text = "Author: \(song.author)"
        cell.albumLabel.text = "Album: \(song.albumTitle)"
        cell.genreLabel.text = "Genre: \(song.genre)"
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PlaylistDeleteViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            model.deleteSong(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

