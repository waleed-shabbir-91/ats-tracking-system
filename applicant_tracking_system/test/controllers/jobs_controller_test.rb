require 'test_helper'

class JobsControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Create jobs
    @activated_job = Job.create(title: 'Activated Job', description: 'Description')
    @deactivated_job = Job.create(title: 'Deactivated Job', description: 'Description')

    # Create job events
    Job::Event::Activated.create(job: @activated_job)
    Job::Event::Deactivated.create(job: @deactivated_job)

    # Create applications
    @application1 = Application.create(job: @activated_job, candidate_name: 'John Doe')
    @application2 = Application.create(job: @activated_job, candidate_name: 'Jane Smith')
    @application3 = Application.create(job: @deactivated_job, candidate_name: 'Alice Brown')

    # Create application events
    Application::Event::Hired.create(application: @application1, hire_date: Time.now)
    Application::Event::Rejected.create(application: @application2)
    Application::Event::Interview.create(application: @application3, interview_date: Time.now)
  end

  test 'should return all jobs with correct counts' do
    get jobs_url
    assert_response :success

    # Parse the JSON response
    jobs = JSON.parse(@response.body)

    # Check that all jobs are returned
    assert_equal 2, jobs.length

    # Verify the response structure for the activated job
    activated_job_response = jobs.find { |job| job['title'] == @activated_job.title }
    assert_equal 'activated', activated_job_response['status']
    assert_equal 1, activated_job_response['hired_count']
    assert_equal 1, activated_job_response['rejected_count']
    assert_equal 0, activated_job_response['ongoing_count']

    # Verify the response structure for the deactivated job
    deactivated_job_response = jobs.find { |job| job['title'] == @deactivated_job.title }
    assert_equal 'deactivated', deactivated_job_response['status']
    assert_equal 0, deactivated_job_response['hired_count']
    assert_equal 0, deactivated_job_response['rejected_count']
    assert_equal 1, deactivated_job_response['ongoing_count']
  end
end