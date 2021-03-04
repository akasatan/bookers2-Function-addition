class Batch::DailymailSender
  def daily_mail_batch
      DailyMailer.daily_send_mail.deliver_now
  end
end