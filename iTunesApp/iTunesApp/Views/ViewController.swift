//
//  ViewController.swift
//  iTunesApp
//
//  Created by Guru Prasad on 09/12/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchTextfield: UITextField!
    @IBOutlet weak var mediaView: UIView!
    
    var viewModel = ItunsMusicViewModel()
    var selectedMedia = "music"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        mediaView.isUserInteractionEnabled = true
        mediaView.addGestureRecognizer(tapgesture)
        
        let stackView = UIStackView(arrangedSubviews: [mediaView])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        mediaView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @IBAction func submitAction(_ sender: UIButton) {
        viewModel.fetchMusic(search: searchTextfield.text ?? "", media: selectedMedia) {
            DispatchQueue.main.async {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AlbumViewController") as! AlbumViewController
                vc.mediaAlbums = self.viewModel.itunseResults
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @objc func tapAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MediaViewController") as! MediaViewController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
}

extension ViewController: MediaDelegate {
    
    func didSelectMedia(_ mediaArray: [String]) {
        print(mediaArray)
        selectedMedia = mediaArray.joined(separator: ",")
    }
    
}
