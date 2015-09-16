---
title: "Parse Cloud Code"
slug: cloud-code
---

> [info]
> This guide will help you get started with Cloud Code.

#What Is Cloud Code?

By now, you are used to creating objects and querying them in Swift. You have also set up ACL to protect users' data. However, there are so many things you can do on server side that Parse is limited to because they are being done on the client side. This is where Parse Cloud Code comes in. It is a way to upload code to the server and be able to trigger them from the client side. Also, one advantage of Cloud Code is that you can immediately change the code on the server, where in order to update your app's code, you have to submit an update to the App Store.

#Get Started

First, we need to install Parse command line tool to be able to upload code to the cloud.

> [action]
> Enter this in your terminal:
>
>      curl -s https://www.parse.com/downloads/cloud_code/installer.sh | sudo /bin/bash

Once the tool is installed, you should be able to use it like any other command line tool.

> [action]
> In terminal, go to your project's folder:
>
>      cd MyProject

> [action]
> Enter:
>
>      parse new

You will be asked to enter your email and password for Parse. If you logged into Parse through Facebook, you need to go into your Parse account settings and set a password. Once you log in, you will have to choose between "new" and "existing." If you have already created a project on Parse, choose "existing." You will see a list of your projects show up; pick the project you are working on.

#Getting Started With Code

Once you are done with the process of setting up your project for Cloud Code, you will see a main.js file within cloud directory that was created for you. main.js is the file that will contain your Cloud Code.

#Triggers

One of the things that Cloud Code is great for is running a block of code when something happens. Specifically, Cloud Code provides beforeSave, afterSave, beforeDelete, and afterDelete triggers for any object type. This is how you would define one of the trigger functions:

       Parse.Cloud.beforeSave("Message", function(request, response) {

       });

The block of code gets two parameters: request and response. We are able to get more information about what is being saved and who is saving it from the request object, and we have to use the response object to let the backend know whether this block of code succeeded or failed. Notice that we also have a parameter "Message" sent to beforeSave function. This is to let the backend know that this block of code is specifically for saving objects of type Message.

#Check For Duplicates

Let's look at a real use of Cloud Code to get a better understanding of how to implement them.


>     Parse.Cloud.beforeSave("Channel", function(request, response) {
>           var name = request.object.get('name'); //1
>
>           //2
>	        var query = new Parse.Query("Channel");
>	        query.equalTo('name', name); 
>	        query.first({ //3
>   	        success: function(object) { //4
>       		      if (object) {
>                     console.log("failed to save channel"); //5
>	          		      response.error(name + " already exists!"); //6
>	        	      } else {
>			    	          console.log("channel saved successfully");
>	                    response.success(); //7
>	        	      }
> 	  	      },
>  	  	      error: function(error) {
>     	    		  response.error("oops...an error occurred while trying to make a new channel!");
>  	  	     }
>         });
>     });

//1: request.object represent the object being saved. We are using it here to get the name of the channel that user wants save on the database.

//2: We want to query our database to see if any channels already exist with that name.

//3: We only need to get one item back, if any, to prove that a channel already exists, so we say query.first.

//4: Once the query is done, it could succeed or fail. If it succeeds, it will return the first object to us.

//5: We can print messages into our console this way. You can see these messages on Parse website.

//6: In order to prevent the object to save, we call response.error().

//7: Otherwise, we call response.success().

#Using Master Key

Once you have set up your ACL, you would want to still allow other users to change objects created by someone else. For example, if an object represents a note that is shared by a few people, using the default ACL will not allow users other than the creator of the note to edit it and save it on Parse. In order to get away with this issue, you can use Cloud Code to save and override the ACL settings by using the master key.

> [action]
> All you have to do is, write line below to get access:
>
>     Parse.Cloud.useMasterKey();

By typing the line above at the beginning of a trigger, you can do anything regardless of the ACL. Regarding the above example, you can use the master key to allow the save. All you have to do is check and make sure the user saving the note is actually a contributor of the note object. That's it!

#Cloud Code Functions

Instead of using triggers, you can also define functions that can be called directly from the client app.

       Parse.Cloud.define("numberOfFriends", function(request, response) {
             ...
       });

Now, all you have to do is use PFCloud in Swift to call the function.

        PFCloud.callFunctionInBackground("numberOfFriends", withParameters: ["userID": PFUser.currentUser()!.objectId!]) { (result: AnyObject!, error: NSError!) -> Void in
             ...
        }

#Uploading Cloud Code

In order to upload, let's go back to the terminal and make sure you are still in your project's directory.

> [action]
> Enter code below to upload your Cloud Code to Parse:
>
>     parse deploy

Your cloud code will be immediately on Parse, ready to be used by your app.






