class Day < ApplicationRecord
  belongs_to :week

  validates_presence_of :week_day, :week, :start, :end
  validates :week_day, inclusion: { in: %w(mon, tue, wed, thu, fri, sat, sun)}

  def check_start_time_stand
    self.check_time_stand(self.start)
  end

  def check_end_time_stand
    self.check_time_stand(self.end)
  end

  def try_to_save
    puts(self.check_start_time_stand)
    puts(self.check_end_time_stand)
    puts(self.check_has_number(self.start))
    puts(self.check_has_number(self.end))
  end

  def check_has_number(param)
    if param =~ /\d/
      return param.split(/[^\d]/).join
    end
    false
  end

  def check_time_stand(param)
    if param.include?  " am"
      return "am"
    elsif param.include? " pm"
      return "pm"
    end
    false
  end
end
