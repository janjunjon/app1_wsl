class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user, token)
    @user = user
    @token = token
    mail(
      to:      @user.email,
      from:    'no-replay@lagis-index.com',
      subject: 'アカウントの有効化'
    )
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user, token)
    @user = user
    @token = token
    mail(
      to:      @user.email,
      from:    'no-replay@lagis-index.com',
      subject: 'パスワードの再設定'
    )
  end
end
