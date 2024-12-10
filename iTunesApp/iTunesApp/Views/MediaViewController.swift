//
//  MediaViewController.swift
//  iTunesApp
//
//  Created by Guru Prasad on 09/12/24.
//

import UIKit

protocol MediaDelegate: AnyObject {
    func didSelectMedia(_ mediaArray: [String])
}

class MediaViewController: UIViewController {
    
    @IBOutlet weak var mediatTableView: UITableView!
    var mediaArray = ["Album","Movie Artist","Ebook","Movie","MusicVideo","Podcast", "Song"]
    var selectedArray = [String]()
    var delegate: MediaDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Media"
        mediatTableView.rowHeight = 60
        mediatTableView.estimatedRowHeight = UITableView.automaticDimension
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        self.navigationItem.rightBarButtonItem = doneButton
        updateDoneButton()
    }
    
    @objc func done() {
        self.delegate?.didSelectMedia(selectedArray)
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateDoneButton() {
        if selectedArray.count > 0 {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
}

extension MediaViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MediaTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MediaTableViewCell") as! MediaTableViewCell
        cell.mediaNameLbl.text = mediaArray[indexPath.row]
        cell.selectedBackgroundView = UIView()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MediaTableViewCell

        if selectedArray.contains(mediaArray[indexPath.row]) {
            guard let index = selectedArray.firstIndex(of: mediaArray[indexPath.row]) else { return }
            selectedArray.remove(at: index)
            cell.accessoryType = .none
        } else {
            selectedArray.append(mediaArray[indexPath.row])
            cell.accessoryType = .checkmark
        }
        updateDoneButton()
    }
    
}
