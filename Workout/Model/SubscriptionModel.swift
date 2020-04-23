import UIKit
import Foundation

var subscriptionArray = [
    "Еженедельный план тренировок, питания и заданий",
    "Доступ к 100+ тренировкам и подсказкам",
    "Полезные и правильные рецепты",
    "Вы в лучшей форме уже через месяц"
]

struct ReviewModel {
    
    let body: String
    let name: String
}

let reviewArray: [ReviewModel] = [
    ReviewModel(body: "Раньше не могли и 20 раз присесть, а сейчас 100! Не знаю даже о таких простых упражнениях.", name: "Анна, Москва"),
    ReviewModel(body: "Приложение очень удобное, поможет держать тело в тонусе.", name: "Елена, Волгоград"),
    ReviewModel(body: "Мотивирует! Очень удобный план тренировок, но главное - это результат!", name: "Светлана, Москва"),
    ReviewModel(body: "Действительно помогает! Каждый день новые занятия.", name: "Виктория, СПБ"),
]
