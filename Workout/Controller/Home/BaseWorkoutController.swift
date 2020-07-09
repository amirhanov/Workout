//
//  BaseWorkoutController.swift
//  Workout
//
//  Created by Рустам Амирханов on 04.04.2020.
//  Copyright © 2020 IDOLE. All rights reserved.
//

import UIKit
import AVKit
import Firebase
import SDWebImage
import AVFoundation
import FacebookCore
import YandexMobileMetrica

class BaseWorkoutController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let analyticModel = AnalyticModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
    }
    
    //MARK:- CollectionView
    
    func setupCollectionView() {
        setupCollectionViewData()
        setupCollectionViewLayout()
    }
    
    func setupCollectionViewLayout() {
        collectionView.layer.shadowColor = UIColor.black.cgColor
        collectionView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        collectionView.layer.shadowOpacity = 0.2
        collectionView.layer.shadowRadius = 8
        collectionView.clipsToBounds = false
        collectionView.layer.masksToBounds = false
    }
    
    func setupCollectionViewData() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseWorkoutArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! BaseWorkoutCell
        let section = baseWorkoutArray[indexPath.row]
        
        cell.titleLabel.text = section.title
        cell.descriptionLabel.text = section.description
        cell.coverImageView.sd_setImage(with: URL(string: section.img)) { (image, error, cache, url) in
            if (error != nil) {
                cell.indicatorActivity.startAnimating()
            } else {
                cell.coverImageView.image = image
                cell.indicatorActivity.isHidden = true
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.2) {
            if let cell = collectionView.cellForItem(at: indexPath) as? BaseWorkoutCell {
                cell.contentView.transform = .init(scaleX: 0.98, y: 0.98)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.2) {
            if let cell = collectionView.cellForItem(at: indexPath) as? BaseWorkoutCell {
                cell.contentView.transform = .identity
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        AudioServicesPlaySystemSound(1520)
        analyticModel.setEvent(event: "Открыть_базовое_упражнение", key: "Упражнение", value: baseWorkoutArray[indexPath.row].title)
        openWorkout(url: baseWorkoutArray[indexPath.row].url)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    //MARK:- Открыть видео
    
    func openWorkout(url: String) {
        let videoURL = URL(string: url)
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) { playerViewController.player!.play() }
    }
}
