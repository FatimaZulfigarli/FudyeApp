import Foundation

struct RegisterModel: Codable {
    let registerPassword: String
    let registerMail: String
    let registerNumber: String
    let registerCardNumber: String
    let registerExpiryDate: String
    let registerCVE: String
    var basket: [FoodItem]?
}
