//
//  PlaylistByGenreViewController.swift
//  Lesson12HW
//

//

import UIKit

class PlaylistByGenreViewController: UIViewController {
    
    @IBOutlet weak var contentView: PlaylistByGenreView!
    var model: PlaylistByGenreModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        model.loadData()
    }
    
    private func setupInitialState() {
        
        model = PlaylistByGenreModel()
        
        contentView.delegate = self
        
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        
        // Register custom cell class with the table view
        contentView.tableView.register(MainPlaylistTableViewCell.self, forCellReuseIdentifier: MainPlaylistTableViewCell.identifier)
    }
}

// MARK: - PlaylistByGenreModelDelegate
extension PlaylistByGenreViewController: PlaylistByGenreModelDelegate {
    func dataDidLoad() {
        contentView.tableView.reloadData()
    }
}

// MARK: - PlaylistByGenreViewDelegate
extension PlaylistByGenreViewController: PlaylistByGenreViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension PlaylistByGenreViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.numberOfGenres()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.numberOfSongs(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainPlaylistTableViewCell.identifier, for: indexPath) as? MainPlaylistTableViewCell else {
            assertionFailure()
            return UITableViewCell()
         }
        
        let song = model.song(at: indexPath.row, inSection: indexPath.section)
        
        // Configure the cell with song information
        cell.titleLabel.text = song.songTitle
        cell.authorLabel.text = "Author: \(song.author)"
        cell.albumLabel.text = "Album: \(song.albumTitle)"
        cell.genreLabel.text = "Genre: \(song.genre)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return model.genre(at: section)
    }
}

// MARK: - UITableViewDelegate
extension PlaylistByGenreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        headerView.backgroundColor = .lightGray
        
        let titleLabel = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.frame.width - 30, height: 30))
        titleLabel.text = model.genre(at: section)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        
        headerView.addSubview(titleLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}

