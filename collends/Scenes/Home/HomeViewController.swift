//
//  HomeViewController.swift
//  collends
//
//  Created by ymgn on 2019/08/10.
//  Copyright © 2019 ymgn. All rights reserved.
//

import UIKit
import APIKit
import Kingfisher

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var imageList: [APOD] = []
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let now = Date()
        
        for diff in 1...18 {
            let dd = Calendar.current.date(byAdding: .day, value: diff * -1, to: now)!
            let date: String = formatter.string(from: dd)
            let request = NASAAPI.AstronomyPtictureOfTheDay(date: date)
            Session.send(request) { result in
                switch result {
                    case .success(let response):
                        self.imageList.append(response)
                        self.collectionView.reloadData()
                    case .failure(let error):
                        print(error)
                }
            }
        }
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        collectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpaceCell", for: indexPath)
        let urlStr = imageList[indexPath.row].url
        if urlStr.contains(".jpg") || urlStr.contains(".png") {
            let url = URL(string: urlStr)!
            if let imageView = cell.contentView.viewWithTag(1) as? UIImageView {
                imageView.setImage(with: url)
            }
        } else {
            if let imageView = cell.contentView.viewWithTag(1) as? UIImageView {
                imageView.image = UIImage(named: "noimage")
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizontalSpace: CGFloat = 20
        let cellSize: CGFloat = self.view.bounds.width / 3 - horizontalSpace
        return CGSize(width: cellSize, height: cellSize)
    }
}
