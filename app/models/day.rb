class Day < ApplicationRecord
  belongs_to :week

  validates_presence_of :week_day, :start, :end
  validates :week_day, inclusion: { in: %w(mon tue wed thu fri sat sun)}

  def check_start_time_stand
    self.check_time_stand(self.start)
  end

  def check_end_time_stand
    self.check_time_stand(self.end)
  end

  def try_to_save
      start_date = self.check_if_valid_parse_time(self.check_start_time_stand)
      end_date =self.check_if_valid_parse_time(self.check_end_time_stand)
      if end_date and start_date
        if end_date > start_date
          return true
        end
      end
      false
  end

  def start_date
    self.check_if_valid_parse_time(self.check_start_time_stand).to_s(:time)
  end

  def end_date
    self.check_if_valid_parse_time(self.check_end_time_stand).to_s(:time)
  end

  def check_is_valid_number(param, limit)
    if param =~ /\d/
      if param.to_i <= limit
        return param
      end
    end
    false
  end

  def check_if_valid_parse_time(param)
    begin
      Time.parse(param)
    rescue
      false
    end
  end

  def check_time_stand(param)
    if param.include? ":"
      return self.check_valid_direct_hour(param)
    elsif param.include? "am"
      return self.check_valid_hour(param, "am")
    elsif param.include? "pm"
      return self.check_valid_hour(param, "pm")
    elsif check_is_valid_number(param, 23)
      return self.check_valid_direct_hour("0%s:00" % param)
    end
    false
  end

  def check_valid_hour(param, stand)
    param = param.squish
    index = param.index(stand)
    date = param[0, index + 2].gsub(" ","")
    number = date[index - 3, 2]
    if self.check_is_valid_number(number, 12)
      return "%s %s" % [number, stand]
    end
    false
  end

  def check_valid_direct_hour(param)
    param = param.squish.gsub(" ","")
    index = param.index(":")
    hours = param[index - 2, 2]
    seconds = param[index + 1, 2]
    if self.check_is_valid_number(hours, 23) and self.check_is_valid_number(seconds, 59)
      return "%s:%s" % [hours, seconds]
    end
    false
  end
end
