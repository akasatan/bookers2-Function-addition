class Batch::DailymailSender
  def self.daily_mail_batch
    users = User.all
    users.each do |user|
      DailyMailer.daily_send_mail(user).deliver
    end
    p "デイリーメールを送信しました"
  end
end