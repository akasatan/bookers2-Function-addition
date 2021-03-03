class ThanksMailer < ApplicationMailer
    default :from => ENV['USER_NAME']

    def send_signup_email(user)
        @user = user
        @greeting = "@greetingの部分だよ～"
        mail( :to => @user , :subject => "会員登録が完了しました。" )
    end
end
