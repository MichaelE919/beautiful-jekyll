---
layout: post
title: Happy New Year! (And where have I been)
---

This is probably too late for your traditional New Year post; however, it's my first post of 2019, so there you go. It's also the first since last summer, and a lot has happened since my last post. About that... 

The major things are still the same- family, job, and home are still the same. Unfortunately for this blog and it's name, my journey to become a wannabe data scientist has stalled a bit. It's not because I've given up or it's become unrealistic. It is really because I've been really busy.

I know, I know- everyone is busy. But that's what happened. I procrastinate anyway, so that's how a blog that should have seen new posts on a weekly basis turn into a monthly blog. What turned it into a semi-annual blog was my job at the Teacher Retirement System. Now as a business analyst, I'm always busy, especially with a major pension administration system modernization project going on.

The difference this time was beginning to work on an Enterprise Data Management project. There's a lot going on with this, but it is basically an endeavor to move raw data from the aforementioned pension administration database to a target data warehouse, to be consumed by everyone from business users to data scientists. My role on this project is a Python developer working on an Extract Transform Load (ETL) application which talks to a Microsoft SQL Server database to monitor and start jobs to move data. Before I go on- did you hear what I just said? I GET PAID TO WRITE PYTHON CODE! Of course, only 10% of my time is allocated to this project, so it's really only a couple of bucks. But still.

I don't plan on getting into too much detail about the application and I also will not be adding to my Projects page (at least not yet). It can probably be open source but as long as it's tied so closely to our specific server and databases, it really cannot. 

Basically, here is what the application does. Despite being over a thousand lines of code, it's quite simple. Every five seconds it pings the database to see if there are any jobs that are ready to run. If it finds one such job, it runs it, and logs the output. Actually the basic structure (which is just the base Python code) was already written by one of our data architects by the time I joined the project. My job is to take the application and adapt it to run on a Linux-based distributed container platform.

To date I have completed the following major milestones:
* Added [Kerberos](https://web.mit.edu/Kerberos/) authentication. This allows a Linux-based application to be authenticated to Active Directory.
* Added [Pyro - Python Remote Objects](https://pythonhosted.org/Pyro4/). This allows the containers to call objects remotely (such as those running ETL jobs)
* Containerized the application to run on [Openshift](https://www.openshift.com/). This includes creating Docker images to run the application and adding calls to the Openshift API to create and delete containers as needed.

I've successfully created a proof-of-concept. It is not moving any data at this point, but it is working to the point that I should be able make a few tweaks and enable the application to trigger actual source-to-target jobs. Unfortunately, as far as the project goes, this Python application is a temporary solution. That being said, the model that is in place where a "controller" container identifies jobs to run and spins up on-demand "worker" containers to run those jobs and deletes them when they are no longer needed has use cases beyond our current project. Perhaps when that concept can be refined you'll read about all the details and check it out on my Github page.

For now you'll just have to accept this post as to why I haven't been blogging about pretending to be a data scientist. Actually, I haven't explained anything yet. Since starting to work on this application I've spent just about all my free time on it. That's the same free time I was spending on data science/machine learning projects. Hopefully now that I've gotten most of the difficult work out of the way I can resume those projects, and this blog can go back to being a regular thing.

Don't mind me, I'm just rambling.
