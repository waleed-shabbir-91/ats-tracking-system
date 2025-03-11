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
job1 = Job.create(
  title: "Software Engineer",
  description: "Develop and maintain high-quality software solutions."
)

job2 = Job.create(
  title: "Product Manager",
  description: "Lead product strategy and collaborate with cross-functional teams."
)

# Activate Job1
Job::Event::Activated.create(job: job1)

# Create Applications
app1 = Application.create(job: job1, candidate_name: "John Doe")
app2 = Application.create(job: job1, candidate_name: "Jane Smith")

# Create Application Events
Application::Event::Interview.create(
  application: app1,
  interview_date: Time.now
)
Application::Event::Hired.create(
  application: app1,
  hire_date: Time.now
)
Application::Event::Rejected.create(application: app2)
Application::Event::Note.create(
  application: app1,
  content: "Strong technical background."
)