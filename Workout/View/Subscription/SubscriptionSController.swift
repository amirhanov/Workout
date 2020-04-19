//
//  SubscriptionSController.swift
//  Workout
//
//  Created by Рустам Амирханов on 18.04.2020.
//  Copyright © 2020 IDOLE. All rights reserved.
//

import UIKit
import AudioToolbox

class SubscriptionSController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var lifetimeActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var monthlyActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var annualActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var monthlyView: UIView!
    @IBOutlet weak var annualView: UIView!
    @IBOutlet weak var lifetimeView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var subscriptionTextView: UITextView!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    
    let animationModel = AnimationModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        annualView.layer.borderWidth = 3
        annualView.layer.borderColor = #colorLiteral(red: 0.137254902, green: 0.737254902, blue: 0.4470588235, alpha: 1)
        
        startTimer()
        setupTableView()
        setupTextAndLink()
        setupNavigationBar()
        setupActivityIndicator()
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
        setupNavigationBarRightButton()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { self.setupNavigationBarLeftButton() }
    }
    
    func setupNavigationBarTitle() {
        title = "Подписка"
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
    
    func setupNavigationBarLeftButton() {
        let menuButton = UIBarButtonItem()
        menuButton.image = #imageLiteral(resourceName: "close_22").withRenderingMode(.alwaysOriginal)
        menuButton.style = .plain
        menuButton.target = self
        menuButton.action = #selector(handleClose)
        self.navigationItem.leftBarButtonItem  = menuButton
    }
    
    @objc func handleClose() {
        dismiss(animated: true, completion: nil)
    }
    
    func setupNavigationBarLayout() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! SubscriptionSCell
        
        cell.nameLabel.text = subscriptionArray[indexPath.row]
        
        let selectedView = UIView()
        selectedView.backgroundColor = .clear
        cell.selectedBackgroundView = selectedView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK:- Настройка таймера
    
    var releaseDate: NSDate?
    var countdownTimer = Timer()
    
    fileprivate func startTimer() {

        let releaseDateString = "2030-02-01 08:00:00"
        let releaseDateFormatter = DateFormatter()
        
        releaseDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        releaseDate = releaseDateFormatter.date(from: releaseDateString)! as NSDate
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerRunning), userInfo: nil, repeats: true)
        
        RunLoop.main.add(countdownTimer, forMode: .common)
    }

    @objc fileprivate func timerRunning() {
    
        let currentDate = Date()
        let calendar = Calendar.current
        let diffDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: releaseDate! as Date)
        
        let countdownHours = "\(diffDateComponents.hour ?? 0)"
        let countdownMinutes = "\(diffDateComponents.minute ?? 0)"
        let countdownSeconds = "\(diffDateComponents.second ?? 0)"

        hoursLabel.text = "\(countdownHours)"
        minuteLabel.text = "\(countdownMinutes)"
        secondLabel.text = "\(countdownSeconds)"
    }
}
