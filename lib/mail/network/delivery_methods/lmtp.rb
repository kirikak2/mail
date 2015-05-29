require 'mail/check_delivery_params'

module Mail
  # == Sending Email with LMTP
  #
  # Mail allows you to send emails using LMTP.
  class LMTP
    include Mail::CheckDeliveryParams

    def initialize(values)
      self.settings = {
        :address => "localhost",
        :port => 24,
        :domain => "localhost.localdomain",
        :user_name => nil,
        :password => nil,
        :authtype => :plain
      }.merge!(values)
    end

    attr_accessor :settings

    def deliver!(mail)
      lmtp_from, lmtp_to, message = check_delivery_params(mail)

      lmtp = Net::LMTP.new(settings[:address], settings[:port])

      response = nil
      lmtp.start(settings[:domain], settings[:user_name], settings[:password], settings[:authtype]) do |lmtp_obj|
        response = lmtp_obj.sendmail(message, lmtp_from, lmtp_to)
      end

      if settings[:return_response]
        response
      else
        self
      end
    end
  end
end
