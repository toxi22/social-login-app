namespace :fake do
  task :create_users => :environment do
    100.times do
      email = Faker::Internet.free_email
      password = Faker::Internet.password
      User.create(email: email, password: password, password_confirmation: password)
    end
  end

  task :send_email => :environment do
    FakeMailer.welcome_email.deliver_now
  end
end