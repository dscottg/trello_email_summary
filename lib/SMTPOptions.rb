class SMTPOptions 
  attr_accessor :address, :port, :domain, :user_name, :password, :authentication, 
    :enable_start_ttls_auto

  def initialize(config)
    @address = config["address"]
    @port = config["port"]
    @domain = config["domain"]
    @user_name = config["user_name"]
    @password = config["password"]
    @authentication = config["authentication"]
    @enable_start_ttls_auto = config["enable_start_ttls_auto"]
  end
end