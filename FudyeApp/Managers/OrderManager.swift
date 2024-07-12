import Foundation

class OrderManager {
    static let shared = OrderManager()
    
    private let orderFilePath: URL
    
    private init() {
        orderFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Order.json")
    }
    
    func fetchCurrentOrder() -> [FoodItem] {
        do {
            let data = try Data(contentsOf: orderFilePath)
            let order = try JSONDecoder().decode([FoodItem].self, from: data)
            return order
        } catch {
            print("Failed to fetch current order: \(error)")
            return []
        }
    }
    
    func saveOrderToFile(_ order: [FoodItem]) {
        do {
            let data = try JSONEncoder().encode(order)
            try data.write(to: orderFilePath)
            print("Order saved to: \(orderFilePath.path)")
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Current order: \(jsonString)")
            }
        } catch {
            print("Failed to save order: \(error)")
        }
    }
    
    func updateFoodInOrder(_ food: Food, count: Int) {
        var currentOrder = fetchCurrentOrder()
        if let index = currentOrder.firstIndex(where: { $0.food == food }) {
            if count > 0 {
                currentOrder[index].count = count
            } else {
                currentOrder.remove(at: index)
            }
        } else if count > 0 {
            currentOrder.append(FoodItem(food: food, count: count))
        }
        saveOrderToFile(currentOrder)
    }
    
    func clearOrderFile() {
        do {
            try FileManager.default.removeItem(at: orderFilePath)
            print("Order file cleared")
        } catch {
            print("No existing order file to clear or failed to clear: \(error)")
        }
    }
    
    func saveBasketForUser(_ user: RegisterModel) {
        var users = fetchAllUsers()
        if let index = users.firstIndex(where: { $0.registerMail == user.registerMail }) {
            users[index].basket = fetchCurrentOrder()
            saveUser(data: users)
        }
    }
    
    func loadBasketForUser(_ email: String) -> [FoodItem]? {
        let users = fetchAllUsers()
        return users.first(where: { $0.registerMail == email })?.basket
    }
    
    func fetchAllUsers() -> [RegisterModel] {
        let fileManagerHelper = FileManagerHelper()
        var users = [RegisterModel]()
        fileManagerHelper.getUser { userItems in
            users = userItems
        }
        return users
    }
    
    func saveUser(data: [RegisterModel]) {
        let fileManagerHelper = FileManagerHelper()
        fileManagerHelper.saveUser(data: data)
    }
}
