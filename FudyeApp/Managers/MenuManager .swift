import Foundation

var menu = [Menu]()
class MenuManagerHelper {
    var callback: (() -> Void)?
    
    func parseMenu() {
        if let file = Bundle.main.url(forResource: "Menu", withExtension: "json") {
            print("File URL: \(file)") // Debug print
            do {
                let data = try Data(contentsOf: file)
                print("Raw JSON data: \(String(data: data, encoding: .utf8) ?? "Invalid Data")") // Debug print
                menu = try JSONDecoder().decode([Menu].self, from: data)
                print("Parsed menu: \(menu)") // Debug print
                callback?()
            } catch {
                print("Error parsing JSON: \(error)") // Debug print
                callback?()
            }
        } else {
            print("File not found") // Debug print
        }
    }
    
    func extractAllFoods() -> [Food] {
        var allFoods: [Food] = []
        for menuItem in menu {
            for restaurant in menuItem.restaurants {
                allFoods.append(contentsOf: restaurant.foods)
            }
        }
        return allFoods
    }
}
