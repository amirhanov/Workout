//
//  SubscriptionController.swift
//  Workout
//
//  Created by Рустам Амирханов on 11.04.2020.
//  Copyright © 2020 IDOLE. All rights reserved.
//

import UIKit
import AudioToolbox

class SubscriptionController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var lifetimeActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var monthlyActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var annualActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var monthlyView: UIView!
    @IBOutlet weak var annualView: UIView!
    @IBOutlet weak var lifetimeView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var subscriptionTextView: UITextView!
    
    let animationModel = AnimationModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        annualView.layer.borderWidth = 3
        annualView.layer.borderColor = #colorLiteral(red: 0.137254902, green: 0.737254902, blue: 0.4470588235, alpha: 1)
        subscriptionArray.append("Нажмите, чтобы продолжить бесплатно")
        setupTableView()
        setupTextAndLink()
        setupNavigationBar()
        setupCollectionView()
        setupActivityIndicator()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let indexPath = IndexPath(item: 1, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)
    }
    
    //MARK:- Indicator Activity
    
    func setupActivityIndicator() {
        annualActivityIndicator.isHidden = true
        annualActivityIndicator.stopAnimating()
        
        monthlyActivityIndicator.isHidden = true
        monthlyActivityIndicator.stopAnimating()
        
        lifetimeActivityIndicator.isHidden = true
        lifetimeActivityIndicator.stopAnimating()
    }
    
    //MARK:-
    
    @IBAction func annualButtonTapped(_ sender: Any) {
        AudioServicesPlaySystemSound(1520)
        animationModel.scaleAnimationView(sender: annualView, scaleX: 0.97, scaleY: 0.97, duration: 0.1)
        annualActivityIndicator.isHidden = false
        annualActivityIndicator.startAnimating()
    }
    
    @IBAction func monthlyButtonTapped(_ sender: Any) {
        AudioServicesPlaySystemSound(1520)
        animationModel.scaleAnimationView(sender: monthlyView, scaleX: 0.97, scaleY: 0.97, duration: 0.1)
        monthlyActivityIndicator.isHidden = false
        monthlyActivityIndicator.startAnimating()
    }
    
    @IBAction func lifetimeButtonTapped(_ sender: Any) {
        AudioServicesPlaySystemSound(1520)
        animationModel.scaleAnimationView(sender: lifetimeView, scaleX: 0.97, scaleY: 0.97, duration: 0.1)
        lifetimeActivityIndicator.isHidden = false
        lifetimeActivityIndicator.startAnimating()
    }
    
    //MARK:- NavigationBar
    
    func setupNavigationBar() {
        setupNavigationBarTitle()
        setupNavigationBarLayout()
        setupNavigationBarBackButton()
        setupNavigationBarRightButton()
    }
    
    func setupNavigationBarTitle() {
        title = "Шаг 3 из 3"
    }
    
    func setupNavigationBarRightButton() {
        let restoreButton = UIBarButtonItem()
        restoreButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "DIN Pro", size: 18.0)!, NSAttributedString.Key.foregroundColor: UIColor(named: "PrimaryColor")!], for: .normal)
        restoreButton.title = "Восстановить"
        restoreButton.target = self
        restoreButton.action = #selector(handleRestore)
        self.navigationItem.rightBarButtonItem  = restoreButton
    }
    
    @objc func handleRestore() {
        
    }
    
    func setupNavigationBarBackButton() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
    
    func setupNavigationBarLayout() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
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
        return subscriptionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! SubscriptionCell
        
        cell.nameLabel.text = subscriptionArray[indexPath.row]
        
        if indexPath.row == 4 {
            cell.nameLabel.textColor = .lightGray
        }
    
        let selectedView = UIView()
        selectedView.backgroundColor = .clear
        cell.selectedBackgroundView = selectedView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 && row == 4 {
            AudioServicesPlaySystemSound(1520)
            let vc = storyboard?.instantiateViewController(identifier: "homeController")
            self.present(vc!, animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK:- CollectionView
    
    func setupCollectionView() {
        setupCollectionData()
        setupCollectionViewLayout()
        
        collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: false)
    }
    
    func setupCollectionData() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupCollectionViewLayout() {
        collectionView.layer.shadowColor = UIColor.black.cgColor
        collectionView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        collectionView.layer.shadowOpacity = 0.1
        collectionView.layer.shadowRadius = 8
        collectionView.clipsToBounds = false
        collectionView.layer.masksToBounds = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviewArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! SubscriptionCollectionCell
        let section = reviewArray[indexPath.row]
        
        cell.nameLabel.text = section.name
        cell.reviewLabel.text =  section.body
        
        return cell
    }
    
    //MARK:- Описание подписки
    
    fileprivate func setupTextAndLink() {
        let attributedString = NSMutableAttributedString(string: subscriptionTextView.text)
        let urlPrivacy = URL(string: "https://www.byidole.com/privacy")!
        let urlTerms  = URL(string: "https://www.byidole.com/terms")!

        attributedString.setAttributes([.link: urlTerms], range: NSMakeRange(332, 12))
        attributedString.setAttributes([.link: urlPrivacy], range: NSMakeRange(349, 14))

        self.subscriptionTextView.attributedText = attributedString
        self.subscriptionTextView.isUserInteractionEnabled = true
        self.subscriptionTextView.isEditable = false
        self.subscriptionTextView.isScrollEnabled = false
        self.subscriptionTextView.font = .systemFont(ofSize: 8)
        self.subscriptionTextView.textColor = .lightGray
        self.subscriptionTextView.textAlignment = .center

        self.subscriptionTextView.linkTextAttributes = [
            .foregroundColor: UIColor(named: "PrimaryColor") ?? ""
        ]
    }
}

@IBDesignable extension UIView {

    @IBInspectable var shadowColor: UIColor? {
        set {
            layer.shadowColor = newValue!.cgColor
        }
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }

    @IBInspectable var shadowOpacity: Float {
        set {
            layer.shadowOpacity = newValue
        }
        get {
            return layer.shadowOpacity
        }
    }
    
    @IBInspectable var shadowOffset: CGPoint {
        set {
            layer.shadowOffset = CGSize(width: newValue.x, height: newValue.y)
        }
        get {
            return CGPoint(x: layer.shadowOffset.width, y:layer.shadowOffset.height)
        }
    }

    @IBInspectable var shadowRadius: CGFloat {
        set {
            layer.shadowRadius = newValue
        }
        get {
            return layer.shadowRadius
        }
    }
}
