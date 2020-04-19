//
//  ViewController.swift
//  Workout
//
//  Created by Рустам Амирханов on 01.04.2020.
//  Copyright © 2020 IDOLE. All rights reserved.
//

import UIKit
import StoreKit
import MessageUI
import SDWebImage
import AudioToolbox

class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var subscriptionButton: UIButton!
    @IBOutlet weak var showAllButton: UIButton!
    
    let animationModel = AnimationModel()
    let spAlertModel = SPAlertModel()
    let items = ["Быстрая тренировка", "Оценить приложение", "Написать нам"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupPageControl()
        setupNavigationBar()
        setupCollectionView()
    }
    
    
    @IBAction func subscriptionButtonTapped(_ sender: Any) {
    }
    
    //MARK:- PageControl
    
    func setupPageControl() {
        pageControl.currentPage = 0
    }

    //MARK:- NavigationBar
    
    func setupNavigationBar() {
        setupNavigationBarTitle()
        setupNavigationBarLayout()
        setupNavigationBarBackButton()
        setupNavigationBarLeftButton()
        setupNavigationBarRightButton()
    }
    
    func setupNavigationBarTitle() {
        navigationItem.titleView = UIImageView(image: UIImage(named: "logotype_22.png"))
    }
    
    func setupNavigationBarBackButton() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
    
    func setupNavigationBarLeftButton() {
        let menuButton = UIBarButtonItem()
        menuButton.image = #imageLiteral(resourceName: "menu_22").withRenderingMode(.alwaysOriginal)
        menuButton.style = .plain
        menuButton.target = self
        menuButton.action = #selector(handleMenu)
        self.navigationItem.leftBarButtonItem  = menuButton
    }
    
    func setupNavigationBarRightButton() {
        let gradientLayer = CAGradientLayer()
        let colorLeft = #colorLiteral(red: 0.968627451, green: 0.3333333333, blue: 0.431372549, alpha: 1).cgColor
        let colorRight = #colorLiteral(red: 0.8666666667, green: 0.0862745098, blue: 0.4392156863, alpha: 1).cgColor
        
        gradientLayer.colors = [colorLeft, colorRight]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = subscriptionButton.bounds
        
        subscriptionButton.layer.insertSublayer(gradientLayer, at: 0)
        subscriptionButton.setTitleColor(.white, for: .normal)
        subscriptionButton.layer.cornerRadius = 4
    }
    
    func setupNavigationBarLayout() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @objc func handleMenu() {
        let vc = storyboard?.instantiateViewController(identifier: "menuController")
        self.present(vc!, animated: true)
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
        let count = sectionArray.count

        pageControl.numberOfPages = count
        pageControl.isHidden = !(count > 1)

        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! HomeCollectionCell
        let section = sectionArray[indexPath.row]
        let gradientLayer = CAGradientLayer()
        
        cell.badgeFreeView.layer.borderWidth = 1
        cell.badgeFreeView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.badgeFreeView.layer.cornerRadius = 4
        
        gradientLayer.colors = [section.badgeColor[0], section.badgeColor[1]]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = cell.badgeGradientView.bounds
        cell.badgeGradientView.layer.insertSublayer(gradientLayer, at: 0)
        cell.badgeGradientView.layer.cornerRadius = 4
        
        if section.isFree == true { cell.badgeFreeView.isHidden = false } else { cell.badgeFreeView.isHidden = true }
        
        cell.badgeTitleLabel.text = section.badgeName
        cell.titleLabel.text = section.title
        
        if section.badgeName == "" {
            cell.badgeGradientView.isHidden = true
        } else {
            cell.badgeGradientView.isHidden = false
        }
        
        if section.isLock == false {
            cell.lockImageView.isHidden = true
        } else {
            cell.lockImageView.isHidden = false
        }
        
        cell.coverImageView.sd_setImage(with: URL(string: section.cover)) { (image, error, cache, url) in
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
            if let cell = collectionView.cellForItem(at: indexPath) as? HomeCollectionCell {
                cell.contentView.transform = .init(scaleX: 0.98, y: 0.98)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.1) {
            if let cell = collectionView.cellForItem(at: indexPath) as? HomeCollectionCell {
                cell.contentView.transform = .identity
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? HomeCollectionCell
        let section = sectionArray[indexPath.row]
        
        if section.isLock == true  {
            AudioServicesPlaySystemSound(1521)
            animationModel.shakeAnimation(sender: cell!.infoStackView)
        } else {
            AudioServicesPlaySystemSound(1520)
            let vc = storyboard?.instantiateViewController(identifier: "workoutController") as! WorkoutController
            vc.data = section
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
         if (indexPath.row == sectionArray.count - 1 ) {
            animationModel.scaleAnimationButton(sender: showAllButton, scaleX: 1.1, scaleY: 1.1, duration: 0.3)
         }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl?.currentPage = Int(scrollView.contentOffset.x)/Int(scrollView.frame.width)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl?.currentPage = Int(scrollView.contentOffset.x)/Int(scrollView.frame.width)
    }
    
    //MARK:- TableView
    
    func setupTableView() {
        
        setupTableViewData()
        setupTableViewLayout()
    }
    
    func setupTableViewData() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupTableViewLayout() {
        tableView.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! HomeTableCell
        let section = items[indexPath.row]
        let row = indexPath.row
        
        cell.titleLabel.text = section
        cell.contentView.alpha = 0
        
        if row == 0 {
            cell.badgeView.isHidden = false
        } else {
            cell.badgeView.isHidden = true
        }
        
        let selectedView = UIView()
        selectedView.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.3333333333, blue: 0.431372549, alpha: 0.1)
        cell.selectedBackgroundView = selectedView
        
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.4) {
            cell.contentView.alpha = 1
            cell.transform = CGAffineTransform.identity
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 && row == 0 {
            
        } else if section == 0 && row == 1 {
            self.rateApp(appID: "")
        } else if section == 0 && row == 2 {
            self.sendMail(to: "studio@byidole.com")
        } else {
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK:- Оценить приложение
    
    func rateApp(appID: String) {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + appID) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else { UIApplication.shared.openURL(url) }
        }
    }
    
    //MARK:- Почта
    
    func sendMail(to: String) {
        if MFMailComposeViewController.canSendMail() {
            let composeVC = MFMailComposeViewController()
            let infoDevice = UIDevice.current
            let body = "Напишите здесь свой вопрос или предложение по приложению 😜</br></br></br>Информация iPhone: " + "OS: \(infoDevice.systemVersion), Модель: \(infoDevice.name)"
            
            composeVC.mailComposeDelegate = self
            composeVC.setToRecipients([to])
            composeVC.setSubject("Workout Поддержка")
            composeVC.setMessageBody(body, isHTML: true)
            
            self.present(composeVC, animated: true, completion: nil)
        } else {
            spAlertModel.openIconSPAlert(title: "Ошибка",
                                         message: "На Вашем iPhone не настроен iCLoud",
                                         preset: .message,
                                         duration: 3)
        }
    }
    
    func setupMFMail() {
        if !MFMailComposeViewController.canSendMail() { return }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
