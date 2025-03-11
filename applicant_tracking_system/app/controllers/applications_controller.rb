class ApplicationsController < ApplicationController
  def index
    # Get all activated jobs
    activated_jobs = Job.joins(:events).where(job_events: { type: 'Job::Event::Activated' })

    # Get applications for activated jobs
    applications = Application.where(job: activated_jobs).includes(:events, :job)

    # Map the applications to the required JSON structure
    render json: applications.map { |app|
      {
        job_title: app.job.title,
        candidate_name: app.candidate_name,
        status: app.status,
        notes_count: app.notes_count,
        last_interview_date: app.last_interview_date,
        hire_date: app.hire_date
      }
    }
  end
end