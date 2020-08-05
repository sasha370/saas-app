# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
    :user_name => '17f28bffeddeab',
    :password => 'ae5707d8d76166',
    :address => 'smtp.mailtrap.io',
    :domain => 'smtp.mailtrap.io',
    :port => '25',
    :authentication => :cram_md5
}