require 'test_helper'

class JobTest < ActiveSupport::TestCase
  test 'job status is deactivated by default' do
    job = Job.create(title: 'Test Job', description: 'Test Description')
    assert_equal 'deactivated', job.status
  end

  test 'job status is activated when last event is Job::Event::Activated' do
    job = Job.create(title: 'Test Job', description: 'Test Description')
    Job::Event::Activated.create(job: job)
    assert_equal 'activated', job.status
  end

  test 'job status is deactivated when last event is Job::Event::Deactivated' do
    job = Job.create(title: 'Test Job', description: 'Test Description')
    Job::Event::Activated.create(job: job)
    Job::Event::Deactivated.create(job: job)
    assert_equal 'deactivated', job.status
  end

  test 'job status is updated based on the latest event' do
    job = Job.create(title: 'Test Job', description: 'Test Description')
    Job::Event::Activated.create(job: job)
    Job::Event::Deactivated.create(job: job)
    Job::Event::Activated.create(job: job)
    assert_equal 'activated', job.status
  end
end