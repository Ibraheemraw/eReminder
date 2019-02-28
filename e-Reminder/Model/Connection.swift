//
//  Connection.swift
//  e-Reminder
//
//  Created by Ibraheem rawlinson on 2/26/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import UIKit
import CoreData
import Kingfisher
class Connection: NSManagedObject {
 // create a function that returns a connection and takes in connection info and context
    static func createConnections(connectionInfo: ConnectionInfo, context: NSManagedObjectContext) throws -> Connection {
        //Intialize the NSFetchRequest
        let request: NSFetchRequest<Connection> = Connection.fetchRequest() //NSFetchRequest<Connection> specifies what we want to fetch
        // Assign NSSortDescriptor
        request.sortDescriptors = [NSSortDescriptor.init(key: "name", ascending: true)]
        // Config the NSPredicate
           // NSPredicate.init(format: String, args: CVarArg...) - Initializes a predicate by substituting the values in an argument list into a format string and parsing the result
        request.predicate = NSPredicate.init(format: "name = %@", connectionInfo.name)
        // Use the NSManagedObjectContext
        do {
            let connectionResults = try context.fetch(request) // connectionResults is an array of Connection
            if connectionResults.count > 0 { // avoid dubplicates
                return connectionResults[0] // if the item exist, return the connection
            }
        } catch {
            //re-throwing the error
            throw error
        }
        
        // Create a new connection
        let connection = Connection(context: context)
        connection.name = connectionInfo.name
        connection.email =  connectionInfo.email
        connection.detailDescription = connectionInfo.description
        connection.createdDate = connectionInfo.createdDate
        connection.lastMeetupDate = connectionInfo.lastMeetupDate
        connection.address = connectionInfo.address
        connection.lat =  connectionInfo.latitude
        connection.lng =  connectionInfo.longitude
        // saving image data to Core Data
        let imageView = UIImageView()
        //imageView.kf.setImage(with:)
        imageView.image = UIImage.init(data: connectionInfo.connectionPicture)
       if let imageData = imageView.image?.jpegData(compressionQuality: 0.5){
            connection.picture = imageData as NSObject
        }
        // get the User matching the passed in "name" from this method
        do {
            // Create relationship
            let user = try User.getUser(name: connectionInfo.user, context: context) // This gets incremented everytime it gets called
            connection.user = user
        } catch {
            throw error
        }
        return connection
    }
}
