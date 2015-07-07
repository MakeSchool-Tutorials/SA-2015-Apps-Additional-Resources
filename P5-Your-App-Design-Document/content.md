---
title: "Learn about App Design Documents"
slug: App-Design-Document
---

#App Design Documents

An App Design Document (ADD) is meant to detail the objective, audience, experience, technical requirements, and development milestones for your app.

It is a living document. You should be changing and tweaking it at least twice a week.

Once you have made an ADD, it becomes much easier to visualize everything you have to complete to get your app done and you will be able to keep track of your progress.

Whever you decide to change some aspect of your app's design or development schedule, make sure to update your ADD!

Let's take a look into what goes into an ADD in more detail.

#Objective

Explain the purpose of your app in 2-3 sentences. 

A simple example:

"PlaceholderName is an app that lets friends send each other photos and videos that are deleted after they are viewed."

#Audience

This is where you explain who you imagine would use your app. What age range, interests, background, etc... characterize the users you expect? How much time and disposable income does this audience have? In what circumstances during the day will they use your app?

#Experience

Start by describing, almost like you are telling a story, how a typical user will interact with your app. Why will they choose to open it, what will they do when it is open, what is the benefit or outcome of using it, and what should they feel when using it? 

Next list apps you think have a similar look and feel to what you want for your app. Refer back to them for inspiration on how to make interacting with your app consistent and rewarding.

#Technical

External Services: What APIs or external services will you use when making your app?

Screens: Describe each screen in your app and how you get from one to the other. Are there any screens you could remove from your MVP?

Views, View Controllers, and other Classes: List all Views, View Controllers, and other Swift classes you will need to make you app. 

Data Models: List all Parse data models your app will require.

#MVP Milestones 

This is the section that should get updated the most often. On a week by week basis, list what tasks you plan on completing. This is how you will realize if you are falling behind and need to cut more features.

For example:

Week 5:
-Add Facebook Login
-Write basic instructions for new users
-Add basic instructions to display first time app is launched
-Test with 5 new users


#Crafting Your ADD

Go to Github.com and create a new project. When viewing your empty project, there will be a link in the right sidebar that says "Wiki".

Create a new page in your project's Wiki and name it "ADD".

Create five main sections: Objective, Audience, Experience, Technical, and MVP Milestones.

Inside of Technical, create four subsections: External Services, Screens, View/View Controllers/Classes, Data Models.

Inside of MVP Milestones list each remaining week of development.

Time to start writing your ADD!

1. Fill in your app's Objective and Audience.

2. Fill in the External Services and Screens subsections.

3. Describe the Experience for your app.

4. Start breaking your app down into tasks you will complete every week. 

    If you're new to projects this long, you will have to make best guesses as to how long things will take.

    Before ordering your tasks on a week by week basis, first list every task on your plate. This should include everything you've listed in your ADD that will be in your MVP and all the non-technical work your app requires.

    For every task, estimate how many days it will take. If you think it will take less than a day, round up to a day.

    Add all the days together. Multiply by 1.2 to give yourself buffer time for unexpected delays. If you end up with more than 25 days of estimated tasks, do not change your estimates. Unless you have significant experience with large projects you should almost never change your estimates to be more optimistic. It is a big red flag if your gut tells you a task will take N days but after thinking about it you decide it won't take as long. You're almost always wrong. 

    If you have more than 25 days of work left, cut features.

    If it doesn't hurt, you aren't cutting enough features.

    Revise your ADD if necessary if you end up making significant changes to your app's design.

    Only once you have a list of tasks that fit in 25 days should you start dividing them up week by week.

5. Write out all the Views, View Controllers, Classes, and Data Models your app will require.

Congratulations, you have an ADD!