//
//  MenuController.swift
//  Workout
//
//  Created by Рустам Амирханов on 12.04.2020.
//  Copyright © 2020 IDOLE. All rights reserved.
//

import UIKit
import CoreData

struct HistoryWorkoutsModel {
    
    let title: String
    let duration: Float
}

class MenuController: UIViewController, NSFetchedResultsControllerDelegate, UITableViewDelegate, UITableViewDataSource {

    fileprivate var historyArray: [Workouts] = []
    
    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var randomLabel: UILabel!
    @IBOutlet weak var minCountLabel: UILabel!
    @IBOutlet weak var workoutCountLabel: UILabel!
    @IBOutlet weak var wave_2: UIImageView!
    @IBOutlet weak var wave_3: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var kcalLabel: UILabel!
    
    let animationModel = AnimationModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        randomCount()
        setupTableView()
        setupAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAnimation()
    }
    
    //MARK:- Рандомное место в топе
    
    func randomCount() {
        let randomInt = Int.random(in: 10000..<99999)
        randomLabel.text = "Сегодня Вы продуктивнее \(randomInt) пользователей"
    }
    
    //MARK:- Получение данных
    
    fileprivate var fetchResultController: NSFetchedResultsController<Workouts>!
    func fetchData() {
        let request: NSFetchRequest<Workouts> = Workouts.fetchRequest()
        let sort = NSSortDescriptor(key: "date", ascending: true)
        request.sortDescriptors = [sort]
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
            fetchResultController = NSFetchedResultsController(fetchRequest: request,
                                                               managedObjectContext: context,
                                                               sectionNameKeyPath: nil,
                                                               cacheName: nil) // Инициализация
            fetchResultController.delegate = self // Подпись под протокол
            
            do {
                try fetchResultController.performFetch() // Получение данных с CoreData
                historyArray = fetchResultController.fetchedObjects! // Присвоение данных в массив
                historyArray = historyArray.reversed()
            } catch let error as NSError  {
                print(error.localizedDescription)
            }
        }
        
        if historyArray.count == 0 {
            historyLabel.text = " "
        }
        
        let sum = historyArray.reduce(0) { $0 + $1.duration }
        workoutCountLabel.text = "\(historyArray.count)"
        minCountLabel.text = "\(Int(sum)) мин"
        
        let kcal = sum * 12
        kcalLabel.text = "≈ \(Int(kcal)) ккал"
    }
    
    
    //MARK:- Настройка анимации
    
    func setupAnimation() {
        wave_2.transform = CGAffineTransform(translationX: 0, y: 40)
        wave_3.transform = CGAffineTransform(translationX: 0, y: 40)
    }
    
    func startAnimation() {
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            self.wave_2.transform = CGAffineTransform.identity
        }, completion: nil)
        
        UIView.animate(withDuration: 0.6, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            self.wave_3.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK:- TableView
    
    func setupTableView() {
        setupTableData()
        setupTableViewLayout()
    }
    
    func setupTableData() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupTableViewLayout() {
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return historyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! MenuCell
        let section = historyArray[indexPath.row]
        
        cell.titleLabel.text = section.title  ?? "Нет данных"
        cell.dateLabel.text = section.date  ?? "Нет данных"
        cell.levelLabel.text = "\(section.level ?? "Нет данных") уровень"
        cell.coverImageView.sd_setImage(with: URL(string: section.img ?? "")) { (image, error, cache, url) in
            if (error != nil) {
                cell.activityIndicator.startAnimating()
            } else {
                cell.coverImageView.image = image
                cell.activityIndicator.isHidden = true
            }
        }
        
        let selectedView = UIView()
        selectedView.backgroundColor = .clear
        cell.selectedBackgroundView = selectedView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
