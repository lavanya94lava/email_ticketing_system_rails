class EmailsMailbox < ApplicationMailbox
  def process
    Email.create(
      subject: mail.subject,
      sender: mail.from,
      body: mail.decoded,
      date: mail.to_s,
    )
  end

end
