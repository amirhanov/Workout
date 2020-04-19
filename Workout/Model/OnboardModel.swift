import UIKit
import Foundation

struct OnboardModel {
    
    let title: String
    let caption: String
}

let onboardArray: [OnboardModel] = [
    OnboardModel(title: "Новичок", caption: "Ты только начинаешь тренироваться"),
    OnboardModel(title: "Средний", caption: "Ты тренируешься регулярно"),
    OnboardModel(title: "Продвинутый", caption: "Ты в хорошей форме и готов к интенсивным тренировкам")
]

let goalArray: [OnboardModel] = [
    OnboardModel(title: "Похудеть", caption: "И привести тело в порядок"),
    OnboardModel(title: "Укрепить мыщцы", caption: "И набрать массу"),
    OnboardModel(title: "Уменьшить уровень стресса", caption: "И улучшить сон")
]


//        slideII.titleLabel.text = "What are your goals?"
//        slideII.descriptionLabel.text = "We will use this data when selecting workouts for you"
