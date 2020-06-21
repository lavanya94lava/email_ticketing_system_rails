class AdminController < ApplicationController
 
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

  def labels

    if current_user.admin

      client = Signet::OAuth2::Client.new(access_token: session[:access_token])
    
      service = Google::Apis::GmailV1::GmailService.new
    
      service.authorization = client
    
      @labels_list = service.list_user_labels('me')

      @emails = service.list_user_messages(
        'me',
        max_results: 4,
        q: "from: anahita.spv@gmail.com"
      )
      @email_array = []
      if set = @emails.messages
        set.each do |i|
        email = service.get_user_message('me', i.id)
        sender = email.payload.headers.find{|h| h.name =="From"}.value.split("<")[1]
        
        subject = email.payload.headers.find { |header| header.name == "Subject" }.value

        puts "emailpayload"

        # puts email.payload[0].body.data
        date = email.payload.headers.find {|h| h.name == "Date" }.value
        body = email.payload.parts[0].body.data
        mail_id = i.id 

        
        
        puts body
        puts sender

        prev_mail = Email.find_by(mail_id: i.id);


        if prev_mail.nil?
          Email.create(
            subject: subject,
            sender:sender[0, sender.length-1], 
            body: body.force_encoding('UTF-8'),
            date: date,
            mail_id: i.id,
          )
        end

        

        
        # my_email = {
        #     sender: sender[0, sender.length-1].force_encoding('UTF-8'),
        #     subject: subject.force_encoding('UTF-8'),
        #     date: date.force_encoding('UTF-8'),
        #     body: body,
        #     mail_id:mail_id.force_encoding('UTF-8')
        # }
        # @email_array.push(my_email)


      end
      @email_array  = Email.all
    else 
      redirect_to "/users/#{current_user.id}"
    end

  end

  def index 
    @emails = Email.all;
  end

end

end

