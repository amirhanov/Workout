import AVKit
import AVFoundation
import UIKit
import CoreData

class WorkoutDetailController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var data: WorkoutModel!
    let gradientModel = GradientModel()
    let animationModel = AnimationModel()
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
        setupBlurView()
        setupVideoView()
        setupTableView()
        setupStartButton()
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        saveData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func getData() {
        sectionLabel.text = data.titleSection
        titleLabel.text = data.title
        timeLabel.text = "\(data.level) - \(data.duration)"
        descriptionLabel.text = data.description
    }
    
    func saveData() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
            let workouts = Workouts(context: context)
            workouts.title = data.title
            workouts.duration = durationData
            workouts.img = data.img
            workouts.date = "\(DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .short))"
            workouts.level = data.level
            
            do {
                try context.save()
            } catch let error as NSError {
                print(error.userInfo)
            }
        }
    }
    
    //MARK:-
    
    var durationData: Float = 0.0
    @IBAction func startButtonTapped(_ sender: Any) {
        let videoURL = URL(string: data.video)
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
            let assets = AVAsset(url: videoURL!)
            let duration = assets.duration
            self.durationData =  Float(CMTimeGetSeconds(duration) / 60)
        }
    }
    
    func setupStartButton() {
        let gradient = CAGradientLayer()
        
        let colorLeft = #colorLiteral(red: 0.968627451, green: 0.3333333333, blue: 0.431372549, alpha: 1).cgColor
        let colorRight = #colorLiteral(red: 0.8666666667, green: 0.0862745098, blue: 0.4392156863, alpha: 1).cgColor
        gradient.colors = [colorLeft, colorRight]
        
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.frame = startButton.bounds
        
        startButton.layer.addSublayer(gradient)
        startButton.setTitleColor(.white, for: .normal)
    }
    
    //MARK:-
    func setupVideoView() {
        let videoURL = URL(string: "http://byidole.com/\(data.previewVideo)")
        let player = AVPlayer(url: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = videoView.frame
        playerLayer.videoGravity = .resizeAspectFill
        self.videoView.layer.addSublayer(playerLayer)
        player.isMuted = true
        player.play()
    }
    
    //MARK:- BlurView
    
    func setupBlurView() {
        
        let gradientLayer = CAGradientLayer()
        let colorBottom = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        let colorTop = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0).cgColor
        
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.frame = blurView.bounds
        
        blurView.layer.insertSublayer(gradientLayer, at: 0)
        blurView.backgroundColor = .clear
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! WorkoutDetailCell
            
        cell.nameLabel.text = "123"
        cell.typeLabel.text = "123"
        cell.timeLabel.text = "123"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension WorkoutDetailController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 460 {
            dismissButton.backgroundColor = .black
            dismissButton.setImage(#imageLiteral(resourceName: "close_22").withRenderingMode(.alwaysTemplate), for: .normal)
            dismissButton.tintColor = .white
        } else {
            dismissButton.backgroundColor = .white
            dismissButton.setImage(#imageLiteral(resourceName: "close_22").withRenderingMode(.alwaysTemplate), for: .normal)
            dismissButton.tintColor = .black
        }
    }
}
