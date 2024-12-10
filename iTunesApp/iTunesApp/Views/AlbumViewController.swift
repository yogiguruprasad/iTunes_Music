//
//  AlbumViewController.swift
//  iTunesApp
//
//  Created by Guru Prasad on 09/12/24.
//

import UIKit

class AlbumViewController: UIViewController {
    
    @IBOutlet weak var gridView: UICollectionView!
    @IBOutlet weak var listView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    var mediaAlbums = [ItunsListResult]()
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segmentControl.setTitleTextAttributes(titleTextAttributes, for: .selected)
        gridView.isHidden = false
        listView.isHidden = true
        
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth - 40, height: screenWidth)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        gridView.collectionViewLayout = layout
    }
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            gridView.isHidden = false
            listView.isHidden = true
        case 1:
            gridView.isHidden = true
            listView.isHidden = false
        default:
            gridView.isHidden = false
            listView.isHidden = true
        }
        
    }
}

extension AlbumViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        if collectionView == gridView {
//            return 3
//        } else {
//            return 1
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == gridView {
            return mediaAlbums.count
        } else {
            return mediaAlbums.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == gridView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCell", for: indexPath) as! AlbumCell
            cell.albumImageView.downloaded(from: mediaAlbums[indexPath.row].artworkUrl100 ?? "")
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCell", for: indexPath) as! ListCell
            cell.imageView.downloaded(from: mediaAlbums[indexPath.row].artworkUrl100 ?? "")
            cell.titleLabel.text = mediaAlbums[indexPath.row].collectionName ?? ""
            cell.artsitsLabel.text = mediaAlbums[indexPath.row].artistName
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AlbumDetailsViewController") as! AlbumDetailsViewController
        vc.album = mediaAlbums[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension AlbumViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == gridView {
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

            let numberofItem: CGFloat = 3
            
            let collectionViewWidth = self.gridView.bounds.width
            
            let extraSpace = (numberofItem - 1) * flowLayout.minimumInteritemSpacing
            
            let inset = flowLayout.sectionInset.right + flowLayout.sectionInset.left
            
            let width = Int((collectionViewWidth - extraSpace - inset) / numberofItem)
            
            print(width)
            
            return CGSize(width: width, height: width)
        } else {
            return CGSize(width: self.view.frame.size.width - 40, height: 100)
        }
    }
}
