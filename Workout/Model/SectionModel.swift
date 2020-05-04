import UIKit
import Foundation

struct SectionModel {
    
    var isFree: Bool
    let title:  String
    let cover:  String
    let badgeName: String
    let badgeColor: [CGColor]
    let description: String
    var isLock: Bool
    var array: [WorkoutModel]
    var caption: String
}

var sectionArray: [SectionModel] = [
    SectionModel(isFree: true,
                 title: "КАРДИО",
                 cover: "https://s3.eu-north-1.amazonaws.com/workout.apps/workouts_section/cardio/cover/1.png",
                 badgeName: "ПОПУЛЯРНОЕ",
                 badgeColor: [#colorLiteral(red: 0.968627451, green: 0.3333333333, blue: 0.431372549, alpha: 1), #colorLiteral(red: 0.8666666667, green: 0.0862745098, blue: 0.4392156863, alpha: 1)],
                 description: "ВЫСОКОИНТЕНСИВНЫЕ ТРЕНИРОВКИ",
                 isLock: false,
                 array: cardioArray,
                 caption: "\(cardioArray.count) WORKOUTS + 3 УРОВНЯ"),
    SectionModel(isFree: false,
                 title: "ЗАРЯДКА",
                 cover: "https://s3.eu-north-1.amazonaws.com/workout.apps/workouts_section/charging/cover/1.png",
                 badgeName: "ЭФФЕКТИВНОЕ",
                 badgeColor: [#colorLiteral(red: 0.1019607843, green: 0.8784313725, blue: 0.7490196078, alpha: 1), #colorLiteral(red: 0.07450980392, green: 0.6470588235, blue: 0.8470588235, alpha: 1)],
                 description: "ХОРОШЕЕ И БОДРОЕ НАСТРОЕНИЕ",
                 isLock: true,
                 array: chargingArray,
                 caption: "\(chargingArray.count) WORKOUTS + 3 УРОВНЯ"),
    SectionModel(isFree: false,
                 title: "ЙОГА & ПИЛАТЕС",
                 cover: "https://s3.eu-north-1.amazonaws.com/workout.apps/workouts_section/yoga/cover/2.png",
                 badgeName: "",
                 badgeColor: [#colorLiteral(red: 0.968627451, green: 0.3333333333, blue: 0.431372549, alpha: 1), #colorLiteral(red: 0.8666666667, green: 0.0862745098, blue: 0.4392156863, alpha: 1)],
                 description: "ГАРМОНИЯ И ГИБКОСТЬ ТЕЛА",
                 isLock: true,
                 array: yogaArray,
                 caption: "\(yogaArray.count) WORKOUTS + 3 УРОВНЯ"),
//    SectionModel(isFree: false,
//                 title: "РАСТЯЖКА",
//                 cover: "https://s3.eu-north-1.amazonaws.com/workout.apps/workouts_section/stretching/cover/2.png",
//                 badgeName: "",
//                 badgeColor: [#colorLiteral(red: 0.968627451, green: 0.3333333333, blue: 0.431372549, alpha: 1), #colorLiteral(red: 0.8666666667, green: 0.0862745098, blue: 0.4392156863, alpha: 1)],
//                 description: "",
//                 isLock: true,
//                 array: stretchingArray,
//                 caption: "\(stretchingArray.count) WORKOUTS + 3 LEVELS"),
//    SectionModel(isFree: true,
//                 title: "НАБОР",
//                 cover: "https://s3.eu-north-1.amazonaws.com/workout.apps/workouts_section/strength/cover/1.png",
//                 badgeName: "",
//                 badgeColor: [#colorLiteral(red: 0.968627451, green: 0.3333333333, blue: 0.431372549, alpha: 1), #colorLiteral(red: 0.8666666667, green: 0.0862745098, blue: 0.4392156863, alpha: 1)],
//                 description: "",
//                 isLock: true,
//                 array: strenghtArray,
//                 caption: "\(strenghtArray.count) WORKOUTS + 3 LEVELS"),
    SectionModel(isFree: false,
                 title: "СИЛА",
                 cover: "https://s3.eu-north-1.amazonaws.com/workout.apps/workouts_section/musclegain/cover/1.png",
                 badgeName: "",
                 badgeColor: [#colorLiteral(red: 0.968627451, green: 0.3333333333, blue: 0.431372549, alpha: 1), #colorLiteral(red: 0.8666666667, green: 0.0862745098, blue: 0.4392156863, alpha: 1)],
                 description: "РАЗВИТИЕ СИЛЫ И ВЫНОСЛИВОСТИ",
                 isLock: true,
                 array: musclegainArray,
                 caption: "\(musclegainArray.count) WORKOUTS + 3 УРОВНЯ"),
    SectionModel(isFree: false,
                 title: "ПОХУДЕНИЕ",
                 cover: "https://s3.eu-north-1.amazonaws.com/workout.apps/workouts_section/slimming/cover/2.png",
                 badgeName: "",
                 badgeColor: [#colorLiteral(red: 0.968627451, green: 0.3333333333, blue: 0.431372549, alpha: 1), #colorLiteral(red: 0.8666666667, green: 0.0862745098, blue: 0.4392156863, alpha: 1)],
                 description: "СТРОЙНОЕ И КРАСИВОЕ ТЕЛО",
                 isLock: true,
                 array: slimmingArray,
                 caption: "\(slimmingArray.count) WORKOUTS + 3 УРОВНЯ"),
    SectionModel(isFree: false,
                 title: "РЕЛЬЕФ",
                 cover: "https://s3.eu-north-1.amazonaws.com/workout.apps/workouts_section/relief/cover/2.png",
                 badgeName: "",
                 badgeColor: [#colorLiteral(red: 0.968627451, green: 0.3333333333, blue: 0.431372549, alpha: 1), #colorLiteral(red: 0.8666666667, green: 0.0862745098, blue: 0.4392156863, alpha: 1)],
                 description: "УПРУГОСТЬ И РЕЛЬЕФН",
                 isLock: true,
                 array: reliefArray,
                 caption: "\(reliefArray.count) WORKOUTS + 3 УРОВНЯ")
]
