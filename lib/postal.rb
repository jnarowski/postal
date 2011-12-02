require "postal/version"
require "postal/imap_client"

module Postal
  GMAIL = :gmail
  GENERAL = :general
  
  class << self
    # Creates new Postal IMAP client. Based on mode value
    # it will create either Gmail or general IMAP client.
    #
    # === Examples
    # 
    #   Postal.new("postal@gmail.com", "secret_pass", Postal::GMAIL,
    #     { :authentication=>:plain })
    #   Postal.new("postal@gmail.com", "secret_pass", Postal::GMAIL,
    #     { :authentication => :xoauth })
    #
    #   Postal.new("postal@myimap.com", "secret_pass",
    #     Postal::GENERAL,
    #     { :imap_server => "imap.myimap.com",
    #       :imap_port => 993,
    #       :smtp_server => "smtp.myimap.com",
    #       :smtp_port => 25 })
    #
    # Also it can be used with a block
    #
    #   Postal.new("postal@myimap.com", "secret_pass",
    #     Postal::GENERAL,
    #     { :imap_server => "imap.myimap.com",
    #       :imap_port => 993,
    #       :smtp_server => "smtp.myimap.com",
    #       :smtp_port => 25 }) do |client|
    #     # .. do something here
    #   end
    
    def new(username, password, mode, options = {})
      client = nil

      if mode == GMAIL
        auth_mode = options.delete(:authentication) || :plain
        if auth_mode == :plain
          client = Gmail.new(username, password)
        else
          client = Gmail.new(username, options)
        end
      else
        client = ImapClient.new(username, password, options)
      end

      if block_given?
        yield client
      end

      client
    end
  end
end
