require "api_key_tools/version"
require 'digest/sha1'

module ApiKeyTools
  DELIMITER = "-"

  class Encoder
    attr_reader :time
    def initialize(id, user_key, time)
      @id = id
      @user_key = user_key
      @time = time
    end

    def to_s
      Digest::SHA1.hexdigest([@id, @user_key, @time].join(DELIMITER))
    end

    def as_json
      { id: @id, key: to_s, time: @time}
    end
  end

  class Validator
    TIME_THRESHOLD = 60 * 5 # 5 minutes or 300 seconds

    def initialize(encoder, value)
      @encoder = encoder
      @value = value
    end

    def valid?
      within_time_limit? && @encoder.to_s == @value
    end

    private
    def within_time_limit?
      time_now_as_int = Time.now.to_i
      @encoder.time >= time_now_as_int - TIME_THRESHOLD &&
        @encoder.time < time_now_as_int
    end
  end
end
