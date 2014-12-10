class FakeMailer < ApplicationMailer
  def welcome_email
    mail(to: 'ruby-test-job@yandex.ru', subject: 'Welcome')
  end
end
