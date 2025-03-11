class Job::Event < ApplicationRecord
  belongs_to :job
end

class Job::Event::Activated < Job::Event; end
class Job::Event::Deactivated < Job::Event; end