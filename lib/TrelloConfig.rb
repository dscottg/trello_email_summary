require_relative "SMTPOptions"

class TrelloConfig
  attr_accessor :app_key, :app_secret, :app_name, :auth_token, :board_id, 
    :destination_email, :sender_name, :smtp_options, :expiration_window

  def initialize(config)
    @app_key = config["app_key"] 
    @app_secret  = config["app_secret"] 
    @app_name = config["app_name"] 
    @auth_token = config["auth_token"] 
    @board_id = config["board_id"] 
    @destination_email = config["destination_email"] 
    @sender_name = config["sender_name"] 
    @expiration_window = config["expiration_window"]
    @smtp_options = SMTPOptions.new(config["smtp_options"]) 
  end
end