//
//  ViewController.swift
//  Workout
//
//  Created by Рустам Амирханов on 01.04.2020.
//  Copyright © 2020 IDOLE. All rights reserved.
//

import UIKit
import Firebase
import StoreKit
import CoreData
import MessageUI
import SDWebImage
import FacebookCore
import AudioToolbox
import SwiftyStoreKit
import YandexMobileMetrica

class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var subscriptionStackView: UIStackView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var subscriptionButton: UIButton!
    
    let analyticModel = AnalyticModel()
    let animationModel = AnimationModel()
    let spAlertModel = SPAlertModel()
    let sskModel = SSKModel()
    let items = ["Поделиться", "Оценить", "Написать нам", "Иконка приложения", "Сбросить прогресс"]
    let status = UserDefaults.standard.bool(forKey: "isOnboardViewed")
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupTableView()
        setupPageControl()
        //validateSubscribe()
        setupNavigationBar()
        setupCollectionView()
    }

    @IBAction func subscriptionButtonTapped(_ sender: Any) {
        analyticModel.setEvent(event: "Открыть_экран_подписки", key: "Экран", value: "Главный")
        AudioServicesPlaySystemSound(1520)
    }
    
    //MARK:- Экраны настроек тренировки
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        validateOnboard()
    }
    
    func validateOnboard() {
        if status == true {
            analyticModel.setEvent(event: "Повторный_вход", key: "Экран", value: "Главный")
        } else {
            analyticModel.setEvent(event: "Первый_вход", key: "Экран", value: "Главный")
            let vc = storyboard?.instantiateViewController(identifier: "onboardController")
            self.present(vc!, animated: true)
        }
    }
    
    //MARK:- Валидация подписки
    
    func validateSubscribe() {
        let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: "6748ba82cdf84e9dac95c3df0e93fd24")
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
            if case .success(let receipt) = result {
                let productIds = Set([ "com.training.workout.monthly",
                                       "com.training.workout.halfyear",
                                       "com.training.workout.year"])
                let purchaseResult = SwiftyStoreKit.verifySubscriptions(productIds: productIds, inReceipt: receipt)
                switch purchaseResult {
                case .purchased( _, _):
                    self.haveSubscription()
                case .expired( _, _):
                    self.nothaveSubscription()
                case .notPurchased:
                    self.nothaveSubscription()
                }
            } else {
                self.nothaveSubscription()
            }
        }
    }
    
    func haveSubscription() {
        self.subscriptionStackView.isHidden = true
        for index in 0..<sectionArray.count { sectionArray[index].isLock = false }
    }
    
    func nothaveSubscription() {
        self.subscriptionStackView.isHidden = false
        let vc = storyboard?.instantiateViewController(identifier: "subscriptionSController")
        self.present(vc!, animated: true)
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
        menuButton.image = #imageLiteral(resourceName: "menu_22").withRenderingMode(.alwaysTemplate)
        menuButton.tintColor = UIColor(named: "PrimaryColor")
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
        AudioServicesPlaySystemSound(1520)
        analyticModel.setEvent(event: "Открыть_меню", key: "Экран", value: "Главный")
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
            cell.captionLabel.text = section.caption
            cell.lockImageView.isHidden = true
        } else {
            cell.captionLabel.text = "ЗАКРЫТО"
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
        
        cell.descriptionLabel.text = section.description
        
        //MARK:- BlurView

        let shadowLayer = CAGradientLayer()
        let colorBottom = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        let colorTop = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        
        shadowLayer.colors = [colorTop, colorBottom]
        shadowLayer.frame = cell.shadowView.bounds
        
        cell.shadowView.layer.insertSublayer(shadowLayer, at: 0)
        cell.shadowView.backgroundColor = .clear
        
        
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                let vc = self.storyboard?.instantiateViewController(identifier: "subscriptionSController")
                self.present(vc!, animated: true)
            }
        } else {
            AudioServicesPlaySystemSound(1520)
            setupNotification()
            analyticModel.setEvent(event: "Открыть_секцию", key: "Секция", value: sectionArray[indexPath.row].title)
            let vc = storyboard?.instantiateViewController(identifier: "workoutController") as! WorkoutController
            vc.data = section
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
         //
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl?.currentPage = Int(scrollView.contentOffset.x)/Int(scrollView.frame.width)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl?.currentPage = Int(scrollView.contentOffset.x)/Int(scrollView.frame.width)
    }
    
    //MARK:- Настройка уведомлний
        
        func setupNotification() {
            self.appDelegate?.scheduleNotification(notificationType: "Local Notification")
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
        
        if row == 3 {
            cell.badgeView.isHidden = false
        } else if row == 4 {
            cell.titleLabel.tintColor = .red
            cell.badgeView.isHidden = true
        } else {
            cell.badgeView.isHidden = true
        }
        
        
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor(named: "SelectedColor")
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
        AudioServicesPlaySystemSound(1520)
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 && row == 0 {
            self.shareApp()
            self.analyticModel.setEvent(event: "Поделиться_приложением", key: "Экран", value: "Главный")
        } else if section == 0 && row == 1 {
            self.rateApp(appID: "1367484787")
            self.analyticModel.setEvent(event: "Оценить_приложение", key: "Экран", value: "Главный")
        } else if section == 0 && row == 2 {
            self.sendMail(to: "studio@byidole.com")
            self.analyticModel.setEvent(event: "Написать_в_поддержку", key: "Экран", value: "Главный")
        } else if section == 0 && row == 3 {
            self.changeAppIcon()
            self.analyticModel.setEvent(event: "Сменить_иконку", key: "Экран", value: "Главный")
        } else if section == 0 && row == 4 {
            self.deleteProgress()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK:- Сбросить прогресс
    
    func deleteProgress() {
        let alertController = UIAlertController(title: "Подтверждение", message: "Вы точно хотите сбросить прогресс?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Подтвердить", style: .destructive, handler: { (action) in
            let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Workouts")
            let delete = NSBatchDeleteRequest(fetchRequest: request)
            
            do {
                try context!.execute(delete)
                try context!.save()
                self.spAlertModel.openTextSPAlert(message: "Не получилось сбросить прогресс! Повторте попытку.",
                                             duration: 3)
            } catch {
                self.spAlertModel.openTextSPAlert(message: "Не получилось сбросить прогресс! Повторте попытку.",
                                             duration: 3)
            }
        }))
        alertController.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK:- Сменить иконку приложения
    
    func changeAppIcon() {
        if UIApplication.shared.supportsAlternateIcons {
            if UIApplication.shared.alternateIconName != nil {
                UIApplication.shared.setAlternateIconName(nil)
            } else {
                UIApplication.shared.setAlternateIconName("AlternateAppIcon") { (error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        print("Готово")
                    }
                }
            }
        }
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
    
    //MARK:- Поделиться
    
    func shareApp() {
        let text = "This is the text...."
        let image = #imageLiteral(resourceName: "star_22")
        let url = ""
        let shareAll = [image, text, url] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll,
                                                              applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)

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
