# eReminder

Overview: 
The  eReminder loads a list of your contacts aka connections, you created in the app,  based on the location(s) you have met the other individual at.
    - The user should be able to search their connections based on location or name 
    - The user should be to save a connection to their Favorites
    - The user should be able to adjust the reminder time to any time they see fit in the Settings 
    - The user should be able to create connections that are added to their connetions list section.
    - Users should be able to delete any connection from the connections list 
    - The user should be able to segue to a detail view of the connection they created showing more information
        - The user should be able to send a message un the detail view to the user either via email or text message. 
    
Detailed Outline: 
    - There are 4 Tab bar categories the user can select from
        - Connection List, Draft Section, Favorite Section, & Settings Section
        Connection List View: 
            - In one of the cells of the list it should display the icon, image or the initals of the saved connection, on the far left. in the center of the cell the title should display the name of the user and the subtitle should display the email of the saved connection. On the far right should display the default alarm reminder to follow of with the person
                - The default alarm time is set 1 hour from the time you create the connection 
                    - When the alarm goes off, "Don't forget to follow up with (name of person) about (text description)" it takes you to the detail view so you can add a description and follow up with them
            - The user should be able to create connections by selecting the Right Top Bar Button Item called, "Create"
            Segeue From Colletion Lists View to Detail View: 
                - In the Detail View it should display what the user saved (Icon, Name, Email, and Location)
                - The user will have the abilty to make a connection a favorite and put it in their favorites collections 
                - They will have the abilty to add a message about the person they save 
                - There will be a button, but only active when you have added a description
            Draft View
                - The Draft view will have a display of incomplete connections that have been attempted to have been create. It will send you an alert stating "Your connection has been saved to the draft becuase you have not filled in the requirements to put it in your collection list"
                - This is for you get out of the app or if the app crashes
                - Once when you you complete the required fillins it will go to your collections list
            Favorites View
                - Will look like your connections list view but will only display the people you have made a favourite 
           Create View 
            - When the users selects the add button the users should be able to add people they have met to their connection list 
            - They can input a name and email 
            - The will be a button that saves the location of where the user me the person
                - once when that happens it takes them back to the connections view show a new connection created by the user 
                
  Summary:
     - When it comes to networking or just meeting people at an event I would sometimes forget to contact them after. I hate forgetting the people I connect with because I see them as potentially impactful, whether it is for business or pleasure. This app will help remind you to follow up with these people for whatever reason you would like to follow up with them for. What is great about this app to is that when you save a contact it saves the location of where you two met. For me I have a lot of contacts in my phone so its hard remembering where I met this person from, so with this feature I can put 2 and 2 together
Development:
There are a number of features that will need to be developed to make the app functional and provide a solid user experience (But not limited to):
1 | Signup & Login
2 | Local Notifications
3 | Geolocation tracking
4 | Maps integration
5 |  Link to Google / Apple Maps
6 |Messaging (via Text & Email)

Benfits: 

- Being able to get notificatioions to remind you (in intervals as well too) to follow up with your connection 
- Being able to send an email to one of your connection lists
- See variuos locations of where you met your connection

