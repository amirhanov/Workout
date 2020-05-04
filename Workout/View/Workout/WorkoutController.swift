//
//  WorkoutController.swift
//  Workout
//
//  Created by Рустам Амирханов on 07.04.2020.
//  Copyright © 2020 IDOLE. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import FacebookCore
import AudioToolbox
import YandexMobileMetrica

class WorkoutController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var data: SectionModel!
    let analyticModel = AnalyticModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupCollectionView()
    }
    
    //MARK:- NavigationBar
    
    func setupNavigationBar() {
        setupNavigationBarTitle()
        setupNavigationBarLayout()
        setupNavigationBarBackButton()
    }
    
    func setupNavigationBarBackButton() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
    
    func setupNavigationBarTitle() {
        title = data.title
    }
    
    func setupNavigationBarLayout() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
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
        
        return data.array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! WorkoutsCell
        let section = data.array[indexPath.row]
        
        cell.titleLabel.text = section.title
        cell.descriptionLabel.text = section.description
        cell.captionLabel.text = "\(section.level) - \(section.duration) мин"
        cell.coverImageView.sd_setImage(with: URL(string: section.img)) { (image, error, cache, url) in
            if (error != nil) {
                cell.activityIndicator.startAnimating()
            } else {
                cell.coverImageView.image = image
                cell.activityIndicator.isHidden = true
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.1) {
            if let cell = collectionView.cellForItem(at: indexPath) as? WorkoutsCell {
                cell.contentView.transform = .init(scaleX: 0.98, y: 0.98)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.1) {
            if let cell = collectionView.cellForItem(at: indexPath) as? WorkoutsCell {
                cell.contentView.transform = .identity
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            let width = view.frame.width - 32
            return CGSize(width: width, height: 120)
        case .pad:
            let width = (view.frame.width - 16*3)/2
            return CGSize(width: width, height: 120)
        case .unspecified:
            let width = view.frame.width - 32
            return CGSize(width: width, height: 120)
        case .tv:
            print("tvOS")
        case .carPlay:
            print("carPlay")
        @unknown default:
            let width = view.frame.width - 32
            return CGSize(width: width, height: 120)
        }
        
        let width = view.frame.width - 32
        return CGSize(width: width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return  UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = data.array[indexPath.row]
        AudioServicesPlaySystemSound(1520)
        analyticModel.setEvent(event: "Перейти_к_тренировке", key: "Тренировка", value: data.array[indexPath.row].title)
        let vc = storyboard?.instantiateViewController(identifier: "workoutDetailController") as! WorkoutDetailController
        vc.data = section
        self.present(vc, animated: true)
        
    }
    
}
