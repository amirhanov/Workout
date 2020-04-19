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
}

let sectionArray: [SectionModel] = [
    SectionModel(isFree: true,
                 title: "ЙОГА & ПИЛАТЕС",
                 cover: "https://s3.eu-north-1.amazonaws.com/workout.apps/workouts_section/yoga/cover/2.png",
                 badgeName: "ПОПУЛЯРНОЕ",
                 badgeColor: [#colorLiteral(red: 0.968627451, green: 0.3333333333, blue: 0.431372549, alpha: 1), #colorLiteral(red: 0.8666666667, green: 0.0862745098, blue: 0.4392156863, alpha: 1)],
                 description: "",
                 isLock: false,
                 array: yogaArray),
    SectionModel(isFree: false,
                 title: "ЗАРЯДКА",
                 cover: "https://s3.eu-north-1.amazonaws.com/workout.apps/workouts_section/charging/cover/1.png",
                 badgeName: "ЭФФЕКТИВНОЕ",
                 badgeColor: [#colorLiteral(red: 0.1019607843, green: 0.8784313725, blue: 0.7490196078, alpha: 1), #colorLiteral(red: 0.07450980392, green: 0.6470588235, blue: 0.8470588235, alpha: 1)],
                 description: "",
                 isLock: true,
                 array: yogaArray),
    SectionModel(isFree: false,
                 title: "КАРДИО",
                 cover: "https://s3.eu-north-1.amazonaws.com/workout.apps/workouts_section/cardio/cover/1.png",
                 badgeName: "",
                 badgeColor: [#colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)],
                 description: "",
                 isLock: true,
                 array: yogaArray),
    SectionModel(isFree: false,
                 title: "STRETCHING",
                 cover: "",
                 badgeName: "",
                 badgeColor: [#colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)],
                 description: "",
                 isLock: true,
                 array: yogaArray),
    SectionModel(isFree: false,
                 title: "НАБОР",
                 cover: "https://s3.eu-north-1.amazonaws.com/workout.apps/workouts_section/strength/cover/1.png",
                 badgeName: "",
                 badgeColor: [#colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)],
                 description: "",
                 isLock: true,
                 array: strenghtArray),
    SectionModel(isFree: false,
                 title: "MUSCLE GAIN",
                 cover: "",
                 badgeName: "",
                 badgeColor: [#colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)],
                 description: "",
                 isLock: true,
                 array: yogaArray),
    SectionModel(isFree: false,
                 title: "SLIMMING",
                 cover: "",
                 badgeName: "",
                 badgeColor: [#colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)],
                 description: "",
                 isLock: true,
                 array: yogaArray),
    SectionModel(isFree: false,
                 title: "РЕЛЬЕФ",
                 cover: "https://s3.eu-north-1.amazonaws.com/workout.apps/workouts_section/relief/cover/2.png",
                 badgeName: "",
                 badgeColor: [#colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)],
                 description: "",
                 isLock: true,
                 array: reliefArray)
]
