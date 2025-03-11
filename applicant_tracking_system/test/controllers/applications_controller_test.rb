require 'test_helper'

class ApplicationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Create jobs
    @activated_job = Job.create(title: 'Activated Job', description: 'Description')
    @deactivated_job = Job.create(title: 'Deactivated Job', description: 'Description')

    # Create job events
    Job::Event::Activated.create(job: @activated_job)
    Job::Event::Deactivated.create(job: @deactivated_job)

    # Create applications
    @application1 = Application.create(job: @activated_job, candidate_name: 'John Doe')
    @application2 = Application.create(job: @deactivated_job, candidate_name: 'Jane Smith')

    # Create application events
    Application::Event::Interview.create(application: @application1, interview_date: Time.now)
    Application::Event::Hired.create(application: @application1, hire_date: Time.now)
    Application::Event::Rejected.create(application: @application2)
    Application::Event::Note.create(application: @application1, content: 'Strong candidate')
  end

  test 'should return applications for activated jobs' do
    get applications_url
    assert_response :success
    # Parse the JSON response
    applications = JSON.parse(@response.body)

    # Check that only applications for activated jobs are returned
    assert_equal 1, applications.length

    # Verify the response structure
    application = applications.first
    assert_equal @activated_job.title, application['job_title']
    assert_equal @application1.candidate_name, application['candidate_name']
    assert_equal 'note', application['status']
    assert_equal 1, application['notes_count']
    assert_not_nil application['last_interview_date']
    assert_not_nil application['hire_date']
  end
end