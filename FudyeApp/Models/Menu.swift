import Foundation

struct Menu: Codable {
    let cuisineName: String?
    let cuisinePhoto: String?
    let restaurants: [Restaurant]
}

struct Restaurant: Codable {
    let name: String?
    let restaurantPhoto: String?
    let aboutRestaurant: String?
    let foods: [Food]
}

struct Food: Codable, Equatable {
    let foodName: String?
    let foodPhoto: String?
    let foodPrice: String?
    var priceValue: Double? {
        return Double(foodPrice?.replacingOccurrences(of: "$", with: "") ?? "0")
    }
    
    static func == (lhs: Food, rhs: Food) -> Bool {
        return lhs.foodName == rhs.foodName &&
               lhs.foodPhoto == rhs.foodPhoto &&
               lhs.foodPrice == rhs.foodPrice
    }
}
struct FoodItem: Codable {
    let food: Food
    var count: Int
}
