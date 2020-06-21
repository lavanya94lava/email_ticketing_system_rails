## this file is the root file of the whole app. In this we first fetch email from our gmail account and then add them to our database(sqlite3), depending upon their condition, for example it could be unread, it could be from somone, etc,


class AdminController < ApplicationController
 

  #here we are configuring our app with gmail account, first we are authorizing ourself
  def redirect
    client = Signet::OAuth2::Client.new({
      client_id: "994880020784-j1fiagj1brm0tgv7t6mrl425u34bm1oa.apps.googleusercontent.com",
      client_secret: "UsRZfdGseQJiNgJ8_AAb-fxl",
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      scope: Google::Apis::GmailV1::AUTH_GMAIL_READONLY,
      redirect_uri: "http://localhost:3000/callback"
    })
  
    redirect_to client.authorization_uri.to_s
  end

  #first action will redirect here and here we will get access token using our authorized credentials
  def callback
    client = Signet::OAuth2::Client.new({
      client_id: "994880020784-j1fiagj1brm0tgv7t6mrl425u34bm1oa.apps.googleusercontent.com",
      client_secret: "UsRZfdGseQJiNgJ8_AAb-fxl",
      token_credential_uri: 'https://oauth2.googleapis.com/token',
      redirect_uri: "http://localhost:3000/callback",
      code: params[:code]
    })
  
    response = client.fetch_access_token!
  
    session[:access_token] = response['access_token']
  
    redirect_to url_for(:action => :labels)
  end


  #after getting the the access token, we fetch the data from gmail and use it, manipulate it according to our own needs
  def labels
    if (current_user && current_user.admin)

      # these are certain functionalities provided by google-api-ruby 
      client = Signet::OAuth2::Client.new(access_token: session[:access_token])
    
      service = Google::Apis::GmailV1::GmailService.new
    
      service.authorization = client
    
      @labels_list = service.list_user_labels('me')

      @emails = service.list_user_messages(
        'me',
        max_results: 5,
        q: "vibhujawa@gmail.com"
      )
      @email_array = []
      #we get an array of messages
      if set = @emails.messages
        set.each do |i|
          email = service.get_user_message('me', i.id)

          sender = email.payload.headers.find{|h| h.name =="From"}.value.split("<")[1]
          subject = email.payload.headers.find { |header| header.name == "Subject" }.value

          # puts email.payload[0].body.data
          date = email.payload.headers.find {|h| h.name == "Date" }.value
          body = email.payload.parts[0].body.data
          mail_id = i.id 

          prev_mail = Email.find_by(mail_id: i.id);

          #if theere is a previous mail by same id, then we wont create a new entry in db.
          if prev_mail.nil?
            Email.create(
              subject: subject,
              sender:sender[0, sender.length-1], 
              body: body,
              date: date,
              mail_id: i.id,
            )
          end
      end
      #use this array in view files
      @email_array  = Email.all
    else 
      redirect_to "/login"
    end

  end

end

end

