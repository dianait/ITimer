import Foundation

class StorageController {
    var workList: [Work] = []
    var userLongBrake: Int = 15
    
    init(){
        self.workList = get()
        self.userLongBrake = getLongBrake()
    }
    
    func saveLongBrake(userLongBrake: Int) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(userLongBrake)
            UserDefaults.standard.set(data, forKey: "userLongBrake")
            }
        catch {
            print("Unable to Encode Score Array (\(error))")
        }
    }
    
    func getLongBrake() -> Int {
        var userLongBrake: Int = 15
        if let data = UserDefaults.standard.data(forKey: "userLongBrake") {
            do {
                let decoder = JSONDecoder()
                userLongBrake = try decoder.decode(Int.self, from: data)
                return userLongBrake
            } catch {
                print("Unable to Decode Score Array (\(error))")
            }
        }
        return userLongBrake
    }
    
    func save(workList: [Work]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(workList)
            UserDefaults.standard.set(data, forKey: "workList")
            }
        catch {
            print("Unable to Encode Score Array (\(error))")
        }
    }

    func get() -> [Work] {
        var workList: [Work] = []
        if let data = UserDefaults.standard.data(forKey: "workList") {
            do {
                let decoder = JSONDecoder()
                workList = try decoder.decode([Work].self, from: data)
                return workList
            } catch {
                print("Unable to Decode Score Array (\(error))")
            }
        }
        return workList
    }
    
}
