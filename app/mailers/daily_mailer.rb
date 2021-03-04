class DailyMailer < ApplicationMailer
    default :from => ENV['USER_NAME']

    def daily_send_mail(user)
        @user = user
        mail( :to => @user.email , :subject => "dailymailでっせ" )
    end
end
