require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RubyTestJob
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time
    # _zone = 'Central Time (US & Canada)'
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.default_locale = :ru
    # ======================================================
    #  Mailer settings
    # ======================================================
    config.action_mailer.default_url_options = { host: Settings.mailer.host }

    if Settings.mailer.service == 'smtp'
      config.action_mailer.delivery_method = :smtp
      config.action_mailer.raise_delivery_errors = true

      config.action_mailer.smtp_settings = {
          address: Settings.mailer.smtp.address,
          domain:  Settings.mailer.smtp.domain,
          port:    Settings.mailer.smtp.port,

          user_name: Settings.mailer.smtp.user_name,
          password:  Settings.mailer.smtp.password,

          authentication: Settings.mailer.smtp.authentication,
          enable_starttls_auto: true
      }
    elsif Settings.mailer.service == 'sendmail'
      config.action_mailer.raise_delivery_errors = true

      config.action_mailer.sendmail_settings = {
          location:  Settings.mailer.sendmail.location,
          arguments: Settings.mailer.sendmail.arguments
      }
    else
      config.action_mailer.delivery_method = :test
      config.action_mailer.raise_delivery_errors = false
    end
    # ======================================================
    #  ~ Mailer settings
    # ======================================================
  end
end
