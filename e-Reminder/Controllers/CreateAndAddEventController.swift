//
//  CreateAndAddEventController.swift
//  e-Reminder
//
//  Created by Ibraheem rawlinson on 3/7/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import UIKit
import EventKit
class CreateAndAddEventController: UIViewController {
    @IBOutlet var contentView: CreateAndAddEventView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllerActions()
        
    }
    private func viewControllerActions(){
        contentView.goBackToViewBttn.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        contentView.eventBttn.addTarget(self, action: #selector(createEvent), for: .touchUpInside)
    }

    @objc private func dismissVC(){
        self.dismiss(animated: true, completion: nil)
    }
    @objc private func createEvent(){
        // creating and instance of eventStore
        let eventStore: EKEventStore = EKEventStore()
        //Request Access to that eventstore
          // Setting the EKEntityType to be represented as an event and create the completion handler to requesting access
        eventStore.requestAccess(to: .event) { (granted, error) in
            // create a case for the access
            if (granted) && (error == nil) {
                // Testing Access
                print("Have you been granted Access? \(granted) and error status is \(String(describing: error))")
                //creating the event
                let event: EKEvent = EKEvent.init(eventStore: eventStore) //Creates and returns a new event belonging to a specified event store
                // Setting the event Title
                event.title = "Follow UP Event 😊" // Title of the event calendar
                // Setting the event dates. Has Put on the main thread
                DispatchQueue.main.async {
                    event.startDate = self.contentView.startDate.date
                    event.endDate = self.contentView.endDate.date
                }
                //creating the notes
                event.notes = "✏️ Here is where you add notes about the event you are about to create" // Notes associated with the calendar item
                //
                event.calendar = eventStore.defaultCalendarForNewEvents //The calendar that events are added by default, as specified by the user settings
                //Create a do catch to try and save the event to the user's calendar
                do {
                    try eventStore.save(event, span: .thisEvent)// saves the events to the calendar perminetly
                    // .thisEvent = Modifications to this event instance should affect only this instance
                } catch {
                    print("Error is \(error)")
                }
                print("Event has been saved")
            } else {
                print("Else error statment is: \(String(describing: error))")
            }
        }
    }

}
