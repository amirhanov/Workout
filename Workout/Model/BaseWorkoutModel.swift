import UIKit
import Foundation

struct BaseWorkoutModel {
    
    let img:         String
    let title:       String
    let description: String
    let url:         String
}

let baseWorkoutArray: [BaseWorkoutModel] = [
    BaseWorkoutModel(img: "https://s3.eu-north-1.amazonaws.com/workout.apps/workouts_base/squats.png",
                     title: "Приседания",
                     description: "Ягодицы",
                     url: "https://s3.eu-north-1.amazonaws.com/workout.apps/workouts_base/video/squats.mp4"),
    
    BaseWorkoutModel(img: "https://s3.eu-north-1.amazonaws.com/workout.apps/workouts_base/pushups.png",
                     title: "Отжимания",
                     description: "Грудь",
                     url: "https://s3.eu-north-1.amazonaws.com/workout.apps/workouts_base/video/pushups.mp4"),
    
    BaseWorkoutModel(img: "https://s3.eu-north-1.amazonaws.com/workout.apps/workouts_base/backpushups.png",
                     title: "Обратные отжимания",
                     description: "Трицепс",
                     url: "https://s3.eu-north-1.amazonaws.com/workout.apps/workouts_base/video/backpushups.mp4"),
    
    BaseWorkoutModel(img: "https://s3.eu-north-1.amazonaws.com/workout.apps/workouts_base/strap.png",
                     title: "Планка",
                     description: "Пресс",
                     url: "https://s3.eu-north-1.amazonaws.com/workout.apps/workouts_base/video/strap.mp4")
]
