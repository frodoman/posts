
# iOS Demo Project Specs: 

From a high level point of view the demo consists of a list of posts, where each post has its own detail.

* Posts Screen

A post has a title and it's up to you how to display it. To retrieve the posts, you can use the following API:

http://jsonplaceholder.typicode.com/posts
When a post is tapped, you should go to the detail screen.

* Detail screen

A post detail screen will have:

Its author.
Its description (via the body).
The number of comments it has.
You can retrieve the remaining information from these API:

. http://jsonplaceholder.typicode.com/users
. http://jsonplaceholder.typicode.com/comments


* The following requirements should be met:

Use Swift 3.0 or above.
The information (posts and post details) should be available offline. It's assumed that, if it's the first time you are accessing the app and you are offline, you shouldn't see any data.
The code should be production grade.
It should compile and run.
