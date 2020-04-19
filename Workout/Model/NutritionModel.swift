import UIKit
import Foundation

struct NutritionModel {
    
    let img: String
    let url: String
    let title: String
    let caption: String
    let description: String
}

let nutritionArray: [NutritionModel] = [
    NutritionModel(img: "https://s3.eu-north-1.amazonaws.com/workout.apps/workouts_week/img/warmup.png",
                   url: "https://s3.eu-north-1.amazonaws.com/workout.apps/workouts_week/video/warmup.mp4",
                   title: "Разминка",
                   caption: "Начинающий • 2:45",
                   description: "Хорошая разминка перед началом тренировки"),
    NutritionModel(img: "https://s3.eu-north-1.amazonaws.com/workout.apps/workouts_week/img/workout.png",
                   url: "https://s3.eu-north-1.amazonaws.com/workout.apps/workouts_week/video/workout.mp4",
                   title: "Основная тренировка",
                   caption: "Средний • 21:26",
                   description: "Тренировка направлена на развитие ягодичных мышц"),
    NutritionModel(img: "https://s3.eu-north-1.amazonaws.com/workout.apps/workouts_week/img/hitch.png",
                   url: "https://s3.eu-north-1.amazonaws.com/workout.apps/workouts_week/video/hitch.mp4",
                   title: "Заминка",
                   caption: "Средний • 9:10",
                   description: "Растяжка после тренировки")
]
