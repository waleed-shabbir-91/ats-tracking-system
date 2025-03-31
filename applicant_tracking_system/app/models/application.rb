class Application < ApplicationRecord
  belongs_to :job
  has_many :events, class_name: 'Application::Event'

  # Define the status method
  def status
    last_event = events.where.not(type: 'Application::Event::Note').last
    if last_event.nil?
      'applied'
    else
      last_event.type.demodulize.underscore
    end
  end

  # Define a method to get the last interview date
  def last_interview_date
    events.where(type: 'Application::Event::Interview').last&.interview_date
  end

  # Define a method to get the hired date
  def hire_date
    events.where(type: 'Application::Event::Hired').last&.hire_date
  end

  # Define a method to count notes
  def notes_count
    events.where(type: 'Application::Event::Note').count
  end
end