//
//  PlaylistMoveDeleteViewController.swift
//  Lesson12HW
//

//

import UIKit

class PlaylistMoveDeleteViewController: UIViewController {
    
    @IBOutlet weak var contentView: PlaylistMoveDeleteView!
    var model: PlaylistMoveDeleteModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        model.loadData()
    }
    
    private func setupInitialState() {
        
        model = PlaylistMoveDeleteModel()
        
        contentView.delegate = self
        
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        
        // Register custom cell class with the table view
        contentView.tableView.register(MainPlaylistTableViewCell.self, forCellReuseIdentifier: MainPlaylistTableViewCell.identifier)
        
        // Add a button to toggle edit mode in the navigation bar
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditMode))
        navigationItem.rightBarButtonItem = editButton
    }
    
    @objc func toggleEditMode() {
        let isEditing = !contentView.tableView.isEditing
        contentView.tableView.setEditing(isEditing, animated: true)
        navigationItem.rightBarButtonItem?.title = isEditing ? "Done" : "Edit"
    }
}

// MARK: - PlaylistMoveDeleteModelDelegate
extension PlaylistMoveDeleteViewController: PlaylistMoveDeleteModelDelegate {
    func dataDidLoad() {
        contentView.tableView.reloadData()
    }
}

// MARK: - PlaylistMoveDeleteViewDelegate
extension PlaylistMoveDeleteViewController: PlaylistMoveDeleteViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension PlaylistMoveDeleteViewController: UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Allow editing (deleting) rows only when editing mode is enabled
        return contentView.tableView.isEditing
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        model.moveSong(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
}

// MARK: - UITableViewDelegate
extension PlaylistMoveDeleteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            model.deleteSong(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
