require 'json'
class OAuthData
  attr_accessor :oauth_data
  def initialize(files = {fb: 'facebook', vk: 'vkontakte',
                          google: 'google', twitter: 'twitter'})
    @oauth_data = OmniAuth::AuthHash.new
    files.each_pair do |k, v|
      @oauth_data[k] = JSON.parse(File.read(File.dirname(__FILE__)+"/#{v}.json"))
    end
  end
end