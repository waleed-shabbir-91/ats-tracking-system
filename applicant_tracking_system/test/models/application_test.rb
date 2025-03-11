require 'test_helper'

class ApplicationTest < ActiveSupport::TestCase
  test 'application status is applied by default' do
    job = Job.create(title: 'Test Job', description: 'Test Description')
    application = Application.create(job: job, candidate_name: 'Test Candidate')
    assert_equal 'applied', application.status
  end

  test 'application status is interview when last event is Application::Event::Interview' do
    job = Job.create(title: 'Test Job', description: 'Test Description')
    application = Application.create(job: job, candidate_name: 'Test Candidate')
    Application::Event::Interview.create(application: application, interview_date: Time.now)
    assert_equal 'interview', application.status
  end

  test 'application status is hired when last event is Application::Event::Hired' do
    job = Job.create(title: 'Test Job', description: 'Test Description')
    application = Application.create(job: job, candidate_name: 'Test Candidate')
    Application::Event::Hired.create(application: application, hire_date: Time.now)
    assert_equal 'hired', application.status
  end

  test 'application status is rejected when last event is Application::Event::Rejected' do
    job = Job.create(title: 'Test Job', description: 'Test Description')
    application = Application.create(job: job, candidate_name: 'Test Candidate')
    Application::Event::Rejected.create(application: application)
    assert_equal 'rejected', application.status
  end

  test 'application status is updated based on the latest event' do
    job = Job.create(title: 'Test Job', description: 'Test Description')
    application = Application.create(job: job, candidate_name: 'Test Candidate')
    Application::Event::Interview.create(application: application, interview_date: Time.now)
    Application::Event::Hired.create(application: application, hire_date: Time.now)
    Application::Event::Rejected.create(application: application)
    assert_equal 'rejected', application.status
  end
end