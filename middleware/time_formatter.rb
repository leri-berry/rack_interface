class TimeFormatter

  FORMAT_TIME = {"year" => "Y", "month" => "m", "day" => "d", "hour" => "H", "minute" => "M", "second" => "S"}.freeze

  attr_reader :invalid_string

  def initialize
    @valid_string = []
    @invalid_string = []
  end

  def call(request_with_data)
    acceptable_format = FORMAT_TIME.keys
    request_with_data.each do |element_date|
      if acceptable_format.include? element_date
        @valid_string << FORMAT_TIME[element_date]
      else
        @invalid_string << element_date
      end
    end
  end

  def success?
    @invalid_string.empty?
  end

  def response_time
    Time.now.strftime("%" + @valid_string.join('-%'))
  end
end