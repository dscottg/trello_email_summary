require 'net/http'
require 'json'
require 'mail'
require 'erb'
require 'ostruct'

class TrelloMailer
  attr_accessor :config

  def initialize(config)
    @config = config
    @template_path = "templates/email.html.erb"
    @subject = "Trello Summary for " + Time.now.strftime("%m/%d/%Y")
  end

  def send
    url_param_app_name = @config.app_name.split.join("+")
    auth_url="https://trello.com/1/authorize?key=#{config.app_key}&name=" +
      "#{url_param_app_name}&expiration=#{config.expiration_window}&response_type=token"

    lists_url = "https://api.trello.com/1/boards/#{config.board_id}/lists?cards=open" + 
      "&card_fields=name,url&fields=name,url&key=#{config.app_key}&token=#{config.auth_token}"   

    uri = URI(lists_url)

    response = Net::HTTP.get(uri)
    board_lists = JSON.parse(response)
    todays_date = Time.now.strftime("%m/%d/%Y")

    email_content = ERB.new(File.read(@template_path)).result(OpenStruct.new().instance_eval { binding })

    email(email_content)
  end

  private

  def email(email_content)
    options = { :address              => @config.smtp_options.address,
                :port                 => @config.smtp_options.port,
                :domain               => @config.smtp_options.domain,
                :user_name            => @config.smtp_options.user_name,
                :password             => @config.smtp_options.password,
                :authentication       => @config.smtp_options.authentication,
                :enable_starttls_auto => @config.smtp_options.enable_start_ttls_auto  }

    Mail.defaults do
      delivery_method :smtp, options
    end

    config = @config
    subject = @subject
    mail = Mail.new do
      from config.sender_name
      to config.destination_email
      subject subject
    end

    html_part = Mail::Part.new do
      content_type 'text/html; charset=UTF-8'
      body email_content
    end

    mail.html_part = html_part

    mail.deliver!
  end

end