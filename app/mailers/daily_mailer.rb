class DailyMailer < ApplicationMailer
    default :from => ENV['USER_NAME']

    def daily_send_mail
        mail( :bcc => User.pluck(:email) , :subject => "dailymail" )
    end
end
