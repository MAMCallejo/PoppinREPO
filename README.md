# Poppin - Manuel Branch
Our app prototype for our independent study class.

So far, the main project contains the following features:

  - Map View: shows our university campus with colored popsicles on it showcasing different events around campus.
  
  - Menu View: slides out from the map view and it contains popsicle filters so that you can see only the popsicles you want.     Also, it contains a little tab mentioning some of the popsicles/events you the user has created.
  
  - Create Event View: the user can fill out an event form and then place their own popsicle on the map to showcase their own     event.  
  
Now, the relevant features that still need to be added are the following:

  - Social Aspect: users will be able to create an account (or link an already existing social media one) and be able to           follow their friends on the app. Also, they can make events private so only their friends can see it, as well as, see what     events their friends are going to. Furthermore, they will be able to connect their social media accounts and share their       events on it.
  
  - Profile View: should be accessed from the menu or by pressing on somebody else's profile picture. It should allow the user     to see how their profile is publicly shown, as well as, give them the option to change it. Furthermore, if they press on       somebody else's profile picture, the profile view should show their information, as well as, give the user the option to       add this person as their friend. Moreover, their events should be accessed from this view as well. Finally, the option to     delete their account should be on this view as well.
  
  - Popsicle View: showcases the main information about an event once a popsicle has been pressed by the user. It probably         should have an initial informative view with simply the title, date, etc. With a small size so that the user can tap out       of it easily in case they are not interested enough. Then, it should have a button that opens the main Popsicle View with     all the information of the event.
  
  - My Events View: accessed from the menu view, it should contain information regarding future, current, and past events         created by the user. Its interface should be simple and straight-forward (maybe a Stack View kind of interface subdivided     into three).
  
  - Off-Campus Events View: accessed from a button on the map view, it should contain information regarding events whose           location falls outside the radius of the university campus. The interface should be also simple and straight-forward           (again, maybe a Stack View kind of interface that once a row is pressed expands showing all the important information         about the event and directions).
  
  - Animations: the app still has a non-polished feel to it since most of the animations and transitions are simply fades.         Some fades work fine but others need an improved animation (like the popsicles falling on the map, views sliding instead       of just fading in or out, etc.).
 
  - Settings View: this view should be accessed from the menu and contain location enabling settings, night/day mode enabling     setting, copyright information, terms, acknowledgements to external resources used on the app, help guide, FAQs,               tutorials, and contact information.
  
  - Automation of the event creation process: this feature is far into the future but the app should give organizations on         campus the option to let their events be shown on the app's map. Then, if they give permission we could gather their           events from a DU's database and use that information to populate our map with their events.
  
  - Online database: right now the popsicles are stored in an array on the user's phone. However, the popsicles' data should       be stored on the cloud and the map should be updated constantly to reflect the expiration and creation of the popsicles.
  
  - Loading Screen and Transition: we still need to design the loading screen and the popsicle melting animation. A suggestion     would be to create a simple GIF for the loading screen (maybe the popsicle rotating or pulsating) and then user After         Effects to create a video animation of the popsicle melting that fades into the map view. However, on the worst case           scenario we could use the Twitter fade in effect.
  
  - Tutorial Views: they should be presented the first time the user opens the up. They should help the user create an             account, show him/her how to create an event, check the events they have created, how to edit their profile, and advice       them to go into the settings if they need to see the tutorials again.
  
Once the most important features from above have been implemented, we can polish the final look of the app, test it on a closed environment, copyright the app, and publish it on the app store :D
