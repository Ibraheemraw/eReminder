//
//  User.swift
//  e-Reminder
//
//  Created by Ibraheem rawlinson on 2/26/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import UIKit
import CoreData
class User: NSManagedObject {
    static func getUser(name: String, context: NSManagedObjectContext) throws -> User{
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        request.predicate = NSPredicate.init(format: "name = %@", name)
        var userResults = [User]()
        do {
            userResults = try context.fetch(request)
        } catch {
            throw error
        }
        if userResults.count > 0 {
            return userResults[0]
        }
        // Create a new connection
        let user = User(context: context)
        user.name = name
        return user
        
    }
}
