//
//  DataController.swift
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 1/29/20.
//  Copyright © 2020 whatspoppinREPO. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class DataController: NSObject {
    
    // 1.
    let persistentContainer = NSPersistentContainer(name: "Poppin")
    
    public func initalizeStack() {
        
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        // 2.
        self.persistentContainer.loadPersistentStores { description, error in
            
            // 3.
            if let error = error {
                
                print("could not load store \(error.localizedDescription)")
                return
                
            }
            
            do {
                
                //try self.deletePopsicles() // ----> Uncomment to reset popsicles in coreData
                
                let oldUserInfo = try self.fetchUserInfo()
                
                if oldUserInfo.0 == "-NoUsername-" && oldUserInfo.1.jpegData(compressionQuality: 0.3) == UIImage(named: "profilePictureHolder")?.jpegData(compressionQuality: 0.3){
                    
                    print("\nFirstTimeLoggingIn\n")
                    
                    try self.insertUser(with: nil, profilePicture: nil)
                    
                }
                
            } catch {
                
                print("\nERROR: Unable to insert template user in coreData\n")
                
            }
            
            print("store loaded")
            
        }
        
    }
    
    lazy var context: NSManagedObjectContext = {
        
        return self.persistentContainer.viewContext
        
    }()
    
    public func insertUser(with username: String?, profilePicture: UIImage?) throws {
        
        let userInfo = UserInfo(context: self.context)
        
        userInfo.username = username
        
        if let pp = profilePicture {
            
            userInfo.profilePicture = pp.jpegData(compressionQuality: 0.3)
            
        } else {
            
            userInfo.profilePicture = nil
            
        }
        
        self.context.insert(userInfo)
        
        try self.context.save()
        
    }
    
    public func fetchUserInfo() throws -> (String, UIImage) {
        
        let userInfo = try self.context.fetch(UserInfo.fetchRequest() as NSFetchRequest<UserInfo>)
        
        var username = "-NoUsername-"
        var profilePicture = #imageLiteral(resourceName: "profilePictureHolder")
        
        if userInfo.count == 1 {
            
            if let un = userInfo[0].username {
                
                username = un
                
            }
            
            if let ppData = userInfo[0].profilePicture {
                
                if let pp = UIImage(data: ppData) {
                    
                    profilePicture = pp
                    
                }
                
            }
            
        } else {
            
            do {
            
                try deleteUserInfo()
                
            } catch {
                
                print("\nERROR: Unable to delete userInfo\n")
                
            }
            
        }
        
        return (username, profilePicture)
        
    }
    
    public func fetchUsername() throws -> String {
        
        let userInfo = try self.context.fetch(UserInfo.fetchRequest() as NSFetchRequest<UserInfo>)
        
        var username = "-NoUsername-"
        
        if userInfo.count == 1 {
            
            if let un = userInfo[0].username {
                
                username = un
                
            }
            
        }
        
        return username
        
    }
    
    public func fetchProfilePic() throws -> UIImage {
        
        let userInfo = try self.context.fetch(UserInfo.fetchRequest() as NSFetchRequest<UserInfo>)
        
        var profilePicture = #imageLiteral(resourceName: "profilePictureHolder")
        
        if userInfo.count == 1 {
            
            if let ppData = userInfo[0].profilePicture {
                
                if let pp = UIImage(data: ppData) {
                    
                    profilePicture = pp
                    
                }
                
            }
            
        }
        
        return profilePicture
        
    }
    
    public func deleteUserInfo() throws {
        
        let userInfo = UserInfo.fetchRequest() as NSFetchRequest<NSFetchRequestResult>
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: userInfo)
        
        try self.context.execute(deleteRequest)
        
        try self.context.save()
        
    }
    
    public func updateUserInfo(with newUsername: String?, newProfilePicture: UIImage?) throws {
        
        let userInfo = try self.context.fetch(UserInfo.fetchRequest() as NSFetchRequest<UserInfo>)
        
        if userInfo.count == 1 {
            
            if let nu = newUsername {
                
                userInfo[0].username = nu
                
            }
            
            if let newpp = newProfilePicture {
                
                userInfo[0].profilePicture = newpp.jpegData(compressionQuality: 0.3)
                
            }
            
        }
        
        try self.context.save()
        
    }
    
    public func insertPopsicle(pinPopsicle: pinPopsicle) throws {
        
        let popsicle = Popsicle(context: self.context)
        
        popsicle.eventName = pinPopsicle.popsicleData.eventName
        popsicle.eventInfo = pinPopsicle.popsicleData.eventInfo
        popsicle.eventDate = pinPopsicle.popsicleData.eventDate
        popsicle.eventDuration = pinPopsicle.popsicleData.eventDuration
        popsicle.eventCategory = pinPopsicle.popsicleData.eventCategory
        popsicle.eventCategoryDetails = pinPopsicle.popsicleData.eventCategoryDetails
        popsicle.eventSubcategory1 = pinPopsicle.popsicleData.eventSubcategory1
        popsicle.eventSubcategory1Details = pinPopsicle.popsicleData.eventSubcategory1Details
        popsicle.eventSubcategory2 = pinPopsicle.popsicleData.eventSubcategory2
        popsicle.eventSubcategory2Details = pinPopsicle.popsicleData.eventSubcategory2Details
        popsicle.eventLatitude = pinPopsicle.popsicleData.eventLocation.latitude
        popsicle.eventLongitude = pinPopsicle.popsicleData.eventLocation.longitude
        
        self.context.insert(popsicle)
        
        try self.context.save()
        
    }
    
    public func insertPopsicle(eventName: String, eventInfo: String, eventDate: String, eventDuration: String, eventCategory: String,
                               eventCategoryDetails: String, eventSubcategory1: String, eventSubcategory1Details: String, eventSubcategory2: String, eventSubcategory2Details: String, eventLongitude: Double, eventLatitude: Double) throws {
        
        let popsicle = Popsicle(context: self.context)
        
        popsicle.eventName = eventName
        popsicle.eventInfo = eventInfo
        popsicle.eventDate = eventDate
        popsicle.eventDuration = eventDuration
        popsicle.eventCategory = eventCategory
        popsicle.eventCategoryDetails = eventCategoryDetails
        popsicle.eventSubcategory1 = eventSubcategory1
        popsicle.eventSubcategory1Details = eventSubcategory1Details
        popsicle.eventSubcategory2 = eventSubcategory2
        popsicle.eventSubcategory2Details = eventSubcategory2Details
        popsicle.eventLatitude = eventLatitude
        popsicle.eventLongitude = eventLongitude
     
        self.context.insert(popsicle)
        
        try self.context.save()
        
    }
    
    public func fetchPopsicles() throws -> Set<pinPopsicle> {
        
        let popsicles = try self.context.fetch(Popsicle.fetchRequest() as NSFetchRequest<Popsicle>)
        
        var pinPopsicles: Set<pinPopsicle> = []
        
        for popsicle in popsicles {
            
            let newPinPopsicle: pinPopsicle = pinPopsicle()
            
            newPinPopsicle.popsicleData = pinData(eventName: popsicle.eventName ?? "", eventInfo: popsicle.eventInfo ?? "", eventDate: popsicle.eventDate ?? "", eventDuration: popsicle.eventDuration ?? "", eventCategory: popsicle.eventCategory ?? "", eventCategoryDetails: popsicle.eventCategoryDetails ?? "", eventSubcategory1: popsicle.eventSubcategory1 ?? "", eventSubcategory1Details: popsicle.eventSubcategory1 ?? "", eventSubcategory2: popsicle.eventSubcategory1 ?? "", eventSubcategory2Details: popsicle.eventSubcategory1 ?? "", eventLocation: CLLocationCoordinate2D(latitude: popsicle.eventLatitude, longitude: popsicle.eventLongitude))
            
            newPinPopsicle.coordinate = newPinPopsicle.popsicleData.eventLocation
            
            pinPopsicles.insert(newPinPopsicle)
            
        }
        
        return pinPopsicles
        
    }
    
    public func fetchPopsicles(withCategory eventCategory: String) throws -> Set<pinPopsicle> {
        
        let request = NSFetchRequest<Popsicle>(entityName: "Popsicle")
        
        request.predicate = NSPredicate(format: "eventCategory == %@", eventCategory)
        
        let popsicles = try self.context.fetch(request)
        
        var pinPopsicles: Set<pinPopsicle> = []
        
        for popsicle in popsicles {
            
            let newPinPopsicle: pinPopsicle = pinPopsicle()
            
            newPinPopsicle.popsicleData = pinData(eventName: popsicle.eventName ?? "", eventInfo: popsicle.eventInfo ?? "", eventDate: popsicle.eventDate ?? "", eventDuration: popsicle.eventDuration ?? "", eventCategory: popsicle.eventCategory ?? "", eventCategoryDetails: popsicle.eventCategoryDetails ?? "", eventSubcategory1: popsicle.eventSubcategory1 ?? "", eventSubcategory1Details: popsicle.eventSubcategory1 ?? "", eventSubcategory2: popsicle.eventSubcategory1 ?? "", eventSubcategory2Details: popsicle.eventSubcategory1 ?? "", eventLocation: CLLocationCoordinate2D(latitude: popsicle.eventLatitude, longitude: popsicle.eventLongitude))
            
            newPinPopsicle.coordinate = newPinPopsicle.popsicleData.eventLocation
            
            pinPopsicles.insert(newPinPopsicle)
            
        }
        
        return pinPopsicles
        
    }
    
    public func fetchPopsicles(withName eventName: String) throws -> Set<pinPopsicle> {
        
        let request = NSFetchRequest<Popsicle>(entityName: "Popsicle")
        
        request.predicate = NSPredicate(format: "eventName == %@", eventName)
        
        let popsicles = try self.context.fetch(request)
        
        var pinPopsicles: Set<pinPopsicle> = []
        
        for popsicle in popsicles {
            
            let newPinPopsicle: pinPopsicle = pinPopsicle()
            
            newPinPopsicle.popsicleData = pinData(eventName: popsicle.eventName ?? "", eventInfo: popsicle.eventInfo ?? "", eventDate: popsicle.eventDate ?? "", eventDuration: popsicle.eventDuration ?? "", eventCategory: popsicle.eventCategory ?? "", eventCategoryDetails: popsicle.eventCategoryDetails ?? "", eventSubcategory1: popsicle.eventSubcategory1 ?? "", eventSubcategory1Details: popsicle.eventSubcategory1 ?? "", eventSubcategory2: popsicle.eventSubcategory1 ?? "", eventSubcategory2Details: popsicle.eventSubcategory1 ?? "", eventLocation: CLLocationCoordinate2D(latitude: popsicle.eventLatitude, longitude: popsicle.eventLongitude))
            
            newPinPopsicle.coordinate = newPinPopsicle.popsicleData.eventLocation
            
            pinPopsicles.insert(newPinPopsicle)
            
        }
        
        return pinPopsicles
        
    }
    
    public func update(popsicleWithName popsicleName: String, withNewName newEventName: String? = nil, withNewInfo newEventInfo: String? = nil, withNewDate newEventDate: String? = nil, withNewDuration newEventDuration: String? = nil, withNewCategory newEventCategory: String? = nil, withNewCategoryDetails newEventCategoryDetails: String? = nil, withNewSubcategory1 newEventSubcategory1: String? = nil, withNewSubcategory1Details newEventSubcategory1Details: String? = nil, withNewSubcategory2 newEventSubcategory2: String? = nil, withNewSubcategory2Details newEventSubcategory2Details: String? = nil, withNewLongitude newEventLongitude: Double? = nil, withNewLatitude newEventLatitude: Double? = nil) throws {
        
        let request = NSFetchRequest<Popsicle>(entityName: "Popsicle")
        
        request.predicate = NSPredicate(format: "eventName == %@", popsicleName)
        
        let popsicles = try self.context.fetch(request)
        
        if popsicles.count == 1 {
            
            let popsicle = popsicles.first!
            
            if (newEventName != nil) {
                
                popsicle.eventName = newEventName
                
            }
            
            if (newEventInfo != nil) {
                
                popsicle.eventInfo = newEventInfo
                
            }
            
            if (newEventDate != nil) {
                
                popsicle.eventDate = newEventDate
                
            }
            
            if (newEventDuration != nil) {
                
                popsicle.eventDuration = newEventDuration
                
            }
            
            if (newEventCategory != nil) {
                
                popsicle.eventCategory = newEventCategory
                
            }
            
            if (newEventCategoryDetails != nil) {
                
                popsicle.eventCategoryDetails = newEventCategoryDetails
                
            }
            
            if (newEventSubcategory1 != nil) {
                
                popsicle.eventSubcategory1 = newEventSubcategory1
                
            }
            
            if (newEventSubcategory1Details != nil) {
                
                popsicle.eventSubcategory1Details = newEventSubcategory1Details
                
            }
            
            if (newEventSubcategory2 != nil) {
                
                popsicle.eventSubcategory2 = newEventSubcategory2
                
            }
            
            if (newEventSubcategory2Details != nil) {
                
                popsicle.eventSubcategory2Details = newEventSubcategory2Details
                
            }
            
            if (newEventLongitude != nil) {
                
                popsicle.eventLongitude = newEventLongitude!
                
            }
            
            if (newEventLatitude != nil) {
                
                popsicle.eventLatitude = newEventLatitude!
                
            }
            
        } else {
            
            print("\nERROR: Trying to update multiple popsicles\n")
            
        }
        
        try self.context.save()
        
    }
    
    public func delete(pinPopsicle: pinPopsicle) throws {
        
        let request = NSFetchRequest<Popsicle>(entityName: "Popsicle")
        
        request.predicate = NSPredicate(format: "eventName == %@", pinPopsicle.popsicleData.eventName)
        
        let popsicles = try self.context.fetch(request)
        
        if (popsicles.count == 1) {
            
            let popsicle = popsicles.first!
        
            self.context.delete(popsicle)
            
        } else {
            
            print("\nERROR: Trying to delete multiple popsicles\n")
            
        }
        
        try self.context.save()
        
    }
    
    public func delete(popsicleWithName popsicleName: String) throws {
        
        let request = NSFetchRequest<Popsicle>(entityName: "Popsicle")
        
        request.predicate = NSPredicate(format: "eventName == %@", popsicleName)
        
        let popsicles = try self.context.fetch(request)
        
        if (popsicles.count == 1) {
            
            let popsicle = popsicles.first!
        
            self.context.delete(popsicle)
            
        } else {
            
            print("\nERROR: Trying to delete multiple popsicles\n")
            
        }
        
        try self.context.save()
        
    }
    
    public func deletePopsicles() throws {
        
        let fetchRequest = Popsicle.fetchRequest() as NSFetchRequest<NSFetchRequestResult>
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        try self.context.execute(deleteRequest)
        
        try self.context.save()
        
    }
    
}

