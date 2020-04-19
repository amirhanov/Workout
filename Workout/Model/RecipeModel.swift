import UIKit
import Foundation

struct RecipeModel {
    let title: String
    let img: String
    let kcal: String
    let time: String
    let detail: [RecipeDetailModel]
}

let recipesArray: [RecipeModel] = [
    RecipeModel(title: "123", img: "", kcal: "456", time: "789", detail: recipe_1Array),
    RecipeModel(title: "123", img: "", kcal: "456", time: "789", detail: recipe_1Array),
]

struct RecipeDetailModel {
    let squirrels: String
    let fats: String
    let carbohydrates: String
    let kcal: String
    let complexity: String
    let Ingredients: String
    let inventory: String
    let steps: [RecipeStepsModel]
}

let recipe_1Array: [RecipeDetailModel] = [
    RecipeDetailModel(squirrels: "", fats: "", carbohydrates: "", kcal: "", complexity: "", Ingredients: "", inventory: "", steps: recipe_1stepsArray)
]


struct RecipeStepsModel {
    
    let text: String
    let img: String
}

let recipe_1stepsArray: [RecipeStepsModel] = [
    RecipeStepsModel(text: "", img: "")
]
