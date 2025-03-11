class Job < ApplicationRecord
  has_many :applications
  has_many :events, class_name: 'Job::Event'

  def status
    last_event = events.last
    if last_event.nil?
      'deactivated'
    else
      last_event.type.demodulize.underscore
    end
  end
end