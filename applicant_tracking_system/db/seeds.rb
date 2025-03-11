# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Create Jobs with title and description
# Create Jobs
# Clear existing data
Job.destroy_all
Application.destroy_all
JobEvent.destroy_all
ApplicationEvent.destroy_all

# Create Jobs
job1 = Job.create(title: "Software Engineer", description: "Develop and maintain high-quality software solutions.")
job2 = Job.create(title: "Product Manager", description: "Lead product strategy and collaborate with cross-functional teams.")
job3 = Job.create(title: "Data Scientist", description: "Analyze complex datasets and build predictive models.")
job4 = Job.create(title: "UX Designer", description: "Design user-friendly interfaces for web and mobile applications.")

# Create Job Events
Job::Event::Activated.create(job: job1)
Job::Event::Deactivated.create(job: job2)
Job::Event::Activated.create(job: job3)
Job::Event::Deactivated.create(job: job4)

# Create Applications
app1 = Application.create(job: job1, candidate_name: "John Doe")
app2 = Application.create(job: job1, candidate_name: "Jane Smith")
app3 = Application.create(job: job2, candidate_name: "Alice Johnson")
app4 = Application.create(job: job2, candidate_name: "Bob Brown")
app5 = Application.create(job: job3, candidate_name: "Charlie Davis")
app6 = Application.create(job: job3, candidate_name: "Eve Wilson")
app7 = Application.create(job: job4, candidate_name: "Frank Miller")
app8 = Application.create(job: job4, candidate_name: "Grace Lee")

# Create Application Events
# Application 1: Interviewed and Hired
Application::Event::Interview.create(application: app1, interview_date: Time.now - 5.days)
Application::Event::Hired.create(application: app1, hired_date: Time.now - 3.days)

# Application 2: Interviewed and Rejected
Application::Event::Interview.create(application: app2, interview_date: Time.now - 4.days)
Application::Event::Rejected.create(application: app2)

# Application 3: Applied (No events)
# No events created for app3, so status will be "applied"

# Application 4: Interviewed
Application::Event::Interview.create(application: app4, interview_date: Time.now - 2.days)

# Application 5: Hired
Application::Event::Hired.create(application: app5, hired_date: Time.now - 1.day)

# Application 6: Rejected
Application::Event::Rejected.create(application: app6)

# Application 7: Note Added
Application::Event::Note.create(application: app7, content: "Strong communication skills.")

# Application 8: Multiple Events (Interview -> Hired -> Rejected)
Application::Event::Interview.create(application: app8, interview_date: Time.now - 3.days)
Application::Event::Hired.create(application: app8, hired_date: Time.now - 2.days)
Application::Event::Rejected.create(application: app8)

# Add More Data for Testing
# Create more jobs and applications to cover all variations
5.times do |i|
  job = Job.create(title: "Job #{i + 5}", description: "Description for Job #{i + 5}")
  Job::Event::Activated.create(job: job) if i.even?
  Job::Event::Deactivated.create(job: job) if i.odd?

  3.times do |j|
    app = Application.create(job: job, candidate_name: "Candidate #{j + 1} for Job #{i + 5}")
    case j
    when 0
      Application::Event::Interview.create(application: app, interview_date: Time.now - (i + j).days)
    when 1
      Application::Event::Hired.create(application: app, hired_date: Time.now - (i + j).days)
    when 2
      Application::Event::Rejected.create(application: app)
    end
  end
end

puts "Seeding completed successfully!"