require "gmail"

module Postal
  class ImapClient < Gmail::Client::Plain
    alias_method :orig_fill_username, :fill_username
    alias_method :orig_connect, :connect
    alias_method :orig_smtp_settings, :smtp_settings
    
    def initialize(username, password, options = {})
      super(username, password, options)
    end

    def connect(raise_errors = false)
      puts "Connecting to #{options[:imap_host]} at #{options[:imap_port]})"
      @imap = Net::IMAP.new(options[:imap_host], options[:imap_port], true, nil, false)
    rescue SocketError
      raise_errors and raise Gmail::Client::ConnectionError, "Couldn't establish connection with IMAP service"
    end

    def method_missing(method, *args, &block)
      return @client.send(method, *args, &block) if @client.respond_to?(method)
      super
    end

    def fill_username(username)
      username
    end
      
    def smtp_settings
      [:smtp, {
          :address => options[:smtp_host],
          :port => options[:smtp_port],
          :domain => mail_domain,
          :user_name => username,
          :password => password,
          :authentication => 'plain',
          :enable_starttls_auto => true
        }]
    end
  end
end
