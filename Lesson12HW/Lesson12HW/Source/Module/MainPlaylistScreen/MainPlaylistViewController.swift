//
//  MainPlaylistViewController.swift
//  Lesson12HW
//

//

import UIKit

class MainPlaylistViewController: UIViewController {
    
    @IBOutlet weak var contentView: MainPlaylistView!
    var model: MainPlaylistModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        model.loadData()
    }
    
    private func setupInitialState() {
        
        model = MainPlaylistModel()
        model.delegate = self
        
        contentView.delegate = self
        
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        
        // Register custom cell class with the table view
        contentView.tableView.register(MainPlaylistTableViewCell.self, forCellReuseIdentifier: MainPlaylistTableViewCell.identifier)
    }
}

// MARK: - MainPlaylistModelDelegate
extension MainPlaylistViewController: MainPlaylistModelDelegate {
    
    func dataDidLoad() {
        contentView.tableView.reloadData()
    }
}

// MARK: - MainPlaylistViewDelegate
extension MainPlaylistViewController: MainPlaylistViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension MainPlaylistViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainPlaylistTableViewCell.identifier, for: indexPath) as? MainPlaylistTableViewCell else {
            assertionFailure()
            return UITableViewCell()
         }
         
         let song = model.items[indexPath.row]
         
         // Configure the cell with song information
         cell.titleLabel.text = song.songTitle
         cell.authorLabel.text = "Author: \(song.author)"
         cell.albumLabel.text = "Album: \(song.albumTitle)"
         cell.genreLabel.text = "Genre: \(song.genre)"
         
         return cell
    }
}

// MARK: - UITableViewDelegate
extension MainPlaylistViewController: UITableViewDelegate {
    
}
