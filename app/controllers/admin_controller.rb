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
    client = Signet::OAuth2::Client.new(access_token: session[:access_token])
  
    service = Google::Apis::GmailV1::GmailService.new
  
    service.authorization = client
  
    @labels_list = service.list_user_labels('me')

    @emails = service.list_user_messages(
      'me',
      max_results: 100,
      q: "from: ananya@codingninjas.in"
    )
    @email_array = []
    if set = @emails.messages
      set.each do |i|
      email = service.get_user_message('me', i.id)
      sender = email.payload.headers.find{|h| h.name =="From"}.value.split("<")[1]

      subject = email.payload.headers.find { |header| header.name == "Subject" }.value
      date = email.payload.headers.find {|h| h.name == "Date" }.value
      body = email.payload.parts[0].body.data


      puts i.id
      prev_mail = Email.find_by(mail_id: i.id);
      
      if prev_mail.nil?
        Email.create(
          subject: subject.force_encoding('UTF-8'),
          sender:sender[0, sender.length-1].force_encoding('UTF-8') ,
          body: body.force_encoding('UTF-8'),
          date: date.force_encoding('UTF-8'),
          mail_id: i.id.force_encoding('UTF-8')
        )
      end
    

    my_email = {
        sender: sender[0, sender.length-1],
        subject: subject,
        date: date,
        body: body
    }
    @email_array.push(my_email)
  end
  @email_array
end
  end

  def index 
    @emails = Email.all;
  end

  def temp

  end
end


