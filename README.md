# eReminder

> The  eReminder loads a list of your contacts aka connections, you created in the app,  based on the location(s) you have met the other individual at. Also Creating reminders and notifications to yourself about those people you have saved in the app.
- The user should be able to search their connections based on location or name 
    - The user should be to save a connection to their Favorites
    - The user should be able to adjust the reminder time to any time they see fit in the Settings 
    - The user should be able to create connections that are added to their connections list section.
    - Users should be able to delete any connection from the connections list 
    - The user should be able to segue to a detail view of the connection they created showing more information
       - The user should be able to send a message un the detail view to the user either via email or text message.

## Table of contents
* [General info](#general-info)
* [Gifs](#screenshots)
* [Technologies](#technologies)
* [Setup](#setup)
* [Features](#features)
* [Status](#status)
* [Inspiration](#inspiration)
* [Contact](#contact)

## General info
I am the type of person who likes to socialize. I go to networking events, paint and sips, neighborhood events, happy hours, etc and I end up making great connections with these people at the events, but after the event is over I forget to hit them up about doing other things with them. Sure there Is social media but with social media there is so many things going on in your feed you tend to forget why you go on sometimes. With this app it has one purpose and you can focus on have custom reminders for these specific people.

## Gifs
* ConnectionList 
    - Displays a list of the connections you have created. It is Organized by names
    
![Connectionlist](https://media.giphy.com/media/eePNcOFAgOzSpfxe5V/giphy.gif)
* Messaging View (FMO)
    - Allows users to chat with one another in the app 
    
    ![messagingview](https://user-images.githubusercontent.com/43886009/54216484-1cda7800-44c0-11e9-8a52-ad9621721a43.jpeg)
* Creating A Connection
    - This allows the user to create a connection. Each Connection contains:  
        - Image
        - Name 
        - Email
        - Description (Something about the person to help you remember them)
        - The location where you met the person (To save the location you long press on the Map and type in the location of the place you met them.)
        - Genterates a notification that notifies you within an hour after creating the connection

    ![CreatationView1](https://media.giphy.com/media/9A5fAni7pY7MrnEbox/giphy.gif)
    
    ![CreatationView1](https://media.giphy.com/media/MWu51c6bNKdxC5VOsl/giphy.gif)
    
    ![CreatationView1](https://media.giphy.com/media/6EcxyycU8h064clecb/giphy.gif)
    
    ![CreatationView1](https://media.giphy.com/media/p3qSxkhMoTdn0z8tJa/giphy.gif)![notificationConnection](https://user-images.githubusercontent.com/43886009/54218314-b8211c80-44c3-11e9-896f-597c3290b0e4.jpeg)
* Detail View of your Connection
    - This view shows:
        - Connection Image
        - Connection Name 
        - Connection Email
        - Connection Description 
        - Collection view of the other connections you have
    - In this view you are able to: 
        - save a connection 
        - create and email 
        - create an event that will be sent to your calendar
        - You can click on one of the other connection to switch the image and detail information up top

![CreatationView1](https://media.giphy.com/media/KWwQthUpXXnVaRiZcp/giphy.gif)![CreatationView2](https://media.giphy.com/media/3XHacOqjTEmZVzUBtu/giphy.gif)

  - Saving To Favorites
  
       ![CreatationView3](https://media.giphy.com/media/lo58hPNvu8L88p34Cu/giphy.gif)
        
  - Sending an email to your connection
  
       ![CreatationView4](https://media.giphy.com/media/26ot6lkkQWz1apfZim/giphy.gif)
       
  - Creating an event
  
       ![CreatationView5](https://media.giphy.com/media/x0dr6PtjboKYNesOG0/giphy.gif)![CreatationView6](https://media.giphy.com/media/1qebRmKyXx7AN3DUEg/giphy.gif)
* MapView of your connection
    - shows a annotation of all the connections you have created 
    - The annotations have: 
        - name 
        - location title where you me the person 

    ![MapView](https://media.giphy.com/media/mkwIf6MpYZOedLBe5M/giphy.gif)
    
* Creating your own notifications
    - The user is able to:
       - Choose the name as the notification title 
       - Add a description for the notification body 
       - Set the time they what to be notified 

    ![CreateYourOwnNotificationView](https://media.giphy.com/media/fwW6QjFmEpUopRZjVd/giphy.gif)![IMG_5610](https://user-images.githubusercontent.com/43886009/54222121-24ebe500-44cb-11e9-800c-8b8432563075.jpeg)
    
    
## Technologies
* FavButton(Cocoapods)
* Toucan - version 1.1
* CoreData
* MessageUI
* UserNotification
* Mapkit
* Userlocation(FMO)
* UIKit 
* EventKit
* Geocding (Google Api)

## Features
List of features ready and TODOs for future development
* Creating custom notifications
* Creating events to the calendar 
* Sending email messages to the connection
* Creates a notification when you create a connection 
* Saves the location of where you met the person

To-do list:
* Improve search and filtering 
* Setup images in the map annotions
* Creating profiles
* Creating QR codes for each profile user 
* Improving creation of saving connection's location

## Status
Project is: in Progress and why? This app has met MVP but this will be placed in the app store later this year. Summer of 2019

## Inspiration
This project was inpsired by two Apps: Rememorate & Wmsy

## Contact
Created by Ibraheem K. Rawlinson (https://www.linkedin.com/in/ibraheem-rawlinson-83199962/) - feel free to contact me!

## Presentation
To see my presentation click on the link: (https://prezi.com/view/F51O6fPObofCRBJalO3C/)

## Proposal
To see Proposal click on the link: (https://betterproposals.io/proposal/cover?ProposalID=xxYNthpqYi8FbxvcOa-FvTFHQWVZHRN9RsmbNpwGto4&ContactID=CaCrMZ7820lhokuzU405BPCRdKLP5IggyHuYiMFAMn8)
