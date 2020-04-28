//
//  GoalsController.swift
//  Workout
//
//  Created by Рустам Амирханов on 11.04.2020.
//  Copyright © 2020 IDOLE. All rights reserved.
//

import UIKit
import AudioToolbox

class GoalsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continueButton.isHidden = true
        setupTableView()
        setupNavigationBar()
        setupContinueButton()
    }
    
    override func viewDidLayoutSubviews() {
        gradient.frame = continueButton.bounds
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        AudioServicesPlaySystemSound(1520)
        let vc = storyboard?.instantiateViewController(identifier: "subscriptionController") as! SubscriptionController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:- Настройка кнопки
    
    let gradient = CAGradientLayer()
    fileprivate func setupContinueButton() {
        let colorLeft = #colorLiteral(red: 0.968627451, green: 0.3333333333, blue: 0.431372549, alpha: 1).cgColor
        let colorRight = #colorLiteral(red: 0.8666666667, green: 0.0862745098, blue: 0.4392156863, alpha: 1).cgColor
        gradient.colors = [colorLeft, colorRight]
        
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.frame = continueButton.bounds
        
        continueButton.layer.addSublayer(gradient)
        continueButton.setTitleColor(.white, for: .normal)
    }
    
    //MARK:- NavigationBar
    
    func setupNavigationBar() {
        setupNavigationBarTitle()
        setupNavigationBarLayout()
        setupNavigationBarBackButton()
    }
    
    func setupNavigationBarTitle() {
        title = "Шаг 2 из 3"
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
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goalArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! GoalsCell
        let section = goalArray[indexPath.row]
        
        cell.titleLabel.text = section.title
        cell.captionLabel.text = section.caption
        cell.checkImageView.isHidden = true
        
        let selectionView = UIView()
        selectionView.backgroundColor = UIColor(named: "SelectedColor")
        cell.selectedBackgroundView = selectionView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? GoalsCell {
            cell.checkImageView.isHidden = true
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        continueButton.isHidden = false
        AudioServicesPlaySystemSound(1520)
        if let cell = tableView.cellForRow(at: indexPath) as? GoalsCell {
            cell.checkImageView.isHidden = false
            cell.checkImageView.image = #imageLiteral(resourceName: "check_22").withRenderingMode(.alwaysTemplate)
            cell.checkImageView.tintColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
    }
}
