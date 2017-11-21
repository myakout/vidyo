#coding: UTF-8
require 'digest'
require 'openssl'
require 'base64'

def to_bytes(x)
  x.force_encoding('utf-8').unpack("C*")
end

module Vidyo
  class Token
    def initialize(key:, application_id:, user_name:, expires_in:)
      @key = key
      @application_id = application_id
      @user_name = user_name
      @expires_in = expires_in
    end

    def epoch_seconds
      # Converts 1970-01-01 to seconds since 0 AD.
      62167219200
    end

    def expires_at
      epoch_seconds + Time.now.gmtime.to_i + @expires_in
    end

    def jid
      "#{@user_name}@#{@application_id}"
    end

    def separator
      [0]
    end

    def request_type
      "provision"
    end

    def body
      to_bytes(request_type) + separator + to_bytes(jid) + separator + to_bytes(expires_at.to_s) + separator
    end

    def mac
      sha384 = OpenSSL::HMAC.new(@key, OpenSSL::Digest.new('sha384'))
      sha384.update(body.pack("C*"))
    end

    def unserialized
      (body + separator).pack("C*") + mac.hexdigest
    end

    def serialize
      Base64.strict_encode64(unserialized)
    end
  end
end
