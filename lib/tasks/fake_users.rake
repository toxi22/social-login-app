namespace :fake_users do
  task :create => :environment do
    100.times do
      email = Faker::Internet.free_email
      password = Faker::Internet.password
      User.create(email: email, password: password, password_confirmation: password)
    end
  end
end