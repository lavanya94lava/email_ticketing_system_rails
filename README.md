# Email Ticketing System

In this project, we are making a web app, where we can access our Gmail Inbox and reply to those messages through our app without going to Gmail, We have used the ruby on rails web framework to make this webapp. Here, there is an admin who assigns those emails queries to other employees and when the query gets resolved, it shows up to admin as well as the user who replied to it. We have used various libraries and sqlite3 database for this.

# Software Requirements

1. Ruby 2.5+
2. Rails 5.2+
3. Nodejs 8+
4. Yarn
5. SQLite3

# Dependencies Used

1. google-api-ruby-client
2. bcrypt

# setup

1. git clone https://github.com/lavanya94lava/email_ticketing_system_rails.git
2. put gem 'google-api-client', '~> 0.9', require: 'google/apis/gmail_v1' in your gemfile
3. Configure your Gmail and get Client Id and client secret from https://developers.google.com/gmail/api/quickstart/ruby.
4. bundle install
5. rails server
6. go to http://localhost/3000/redirect to sign in to google

# How Application Works

1. User signs up, first user is always the admin, others can join but only as employees.
2. We configure our Gmail credentials and connect our app with Gmail and start getting emails using the google-client-ruby-api
3. Only Admin has the power, when he is logged in, then itself new entries could be created in the database. Other Employees can just see their work.
4. Admin, then gets all the new entries in DB, and then assigns them one by one to Employees.
5. Admin can create, delete and see the details of every user, An Employee can just create it's account.
6. Admin can see who has got which query to answer.
7. Once the work is delegated to an Employee, they reply to it and that makes it resolved, which also shows up in admin controller.
8. Replies to an email is done using ActionMailer, which comes inbuilt with rails, we just need to configure our gmail to it and it works.
9. Everyone can see, whether a query is updated or resolved.


# Way forward

1. Everytime we perform an operation, page gets reloaded, we can embed AJAX into it to make it more user friendly.
2. We can have pagination for every page as the queries might be in thousand or lakhs and loading all of them in one go is not feasible.
3. We can have separate divs for resolved and unresolved queries, for better UI/UX.


# Issues with The App

1. Google authetication might cause a problem here as the security is very robust and it doesn't allow more than a few mails to be sent from it using a third party app.

2. Also, if you are having two-way authentication in Gmail, you may never use your app to send mails, disable two-way authentication before coming here.

3. UTF-8 encoding might be an issue, this app works fine for genuine emails sent by individuals, but for automated mails, it throws an error as many headers which we use for processing data, is missing from those mails.

