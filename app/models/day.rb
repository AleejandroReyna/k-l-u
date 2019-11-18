class Day < ApplicationRecord
  belongs_to :week

  validates_presence_of :week_day, :week, :start, :end
  validates :week_day, inclusion: { in: %w(mon, tue, wed, thu, fri, sat, sun)}
end
