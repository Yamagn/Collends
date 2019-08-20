//
//  HomeViewController.swift
//  collends
//
//  Created by ymgn on 2019/08/10.
//  Copyright © 2019 ymgn. All rights reserved.
//

import UIKit
import APIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var imageList: [APOD] = []
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let now = Date()
        
        for diff in 1...18 {
            let dd = Calendar.current.date(byAdding: .day, value: diff * -1, to: now)!
            let date: String = formatter.string(from: dd)
            print(date)
            let request = NASAAPI.AstronomyPtictureOfTheDay(date: date)
            Session.send(request) { result in
                switch result {
                    case .success(let response):
                        print(response)
                    case .failure(let error):
                        print(error)
                }
            }
        }
        super.viewDidLoad()
        let nib = UINib(nibName: "SpaceCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "SpaceCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpaceCell", for: indexPath) as! SpaceCollectionViewCell
        return cell
    }
}
