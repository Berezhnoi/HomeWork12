//
//  PlaylistModesView.swift
//  Lesson12HW
//

//

import UIKit

protocol PlaylistModesViewDelegate: AnyObject {
    func segmentedControlDidChange(mode: PlaylistMode)
}

class PlaylistModesView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    weak var delegate: PlaylistModesViewDelegate?
    
    override func awakeFromNib() {
         super.awakeFromNib()
         setupSegmentedControl()
     }
    
    private func setupSegmentedControl() {
        segmentedControl.selectedSegmentIndex = PlaylistMode.all.rawValue
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        guard let mode = PlaylistMode(rawValue: sender.selectedSegmentIndex) else { return }
        delegate?.segmentedControlDidChange(mode: mode)
    }
}
