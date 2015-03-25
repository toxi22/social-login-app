ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../../../config/environment', __FILE__)
require 'rails/test_help'
require_relative '../../test_data/oauth.rb'

class OAuthTest
  test_data = OAuthData.new
  test_data.oauth_data.each_pair do |key, data|
    user = User.create_user_from_omniauth(data)
    if user.save
      puts "#{key} pass"
      user.destroy
    else
      puts "#{key} error"
      p user.errors_messages
    end
  end
  binding.pry
end
