class JobsController < ApplicationController
  def index
    jobs = Job.includes(:applications, :events)

    render json: jobs.map { |job|
      {
        title: job.title,
        status: job.status,
        hired_count: job.applications.count { |app| app.status == 'hired' },
        rejected_count: job.applications.count { |app| app.status == 'rejected' },
        ongoing_count: job.applications.count { |app| !['hired', 'rejected'].include?(app.status) }
      }
    }
  end
end