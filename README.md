# Applicant Tracking System (ATS)

This is a simple Applicant Tracking System (ATS) built with Ruby on Rails.

## Features

- **Job Management**:
  - Create jobs with a `title` and `description`.
  - Track job status (`activated` or `deactivated`) based on events.

- **Application Management**:
  - Candidates can apply to jobs.
  - Track application status (`applied`, `interview`, `hired`, or `rejected`) based on events.
  - Add notes to applications.

- **Event Sourcing**:
  - Jobs and applications use event sourcing to track their status.
  - Events include:
    - For Jobs: `Activated`, `Deactivated`.
    - For Applications: `Interview`, `Hired`, `Rejected`, `Note`.

## Setup Instructions

### Prerequisites

- Ruby 3.2.0
- Rails 8.0.1
- SQLite3 (for this application)
- Docker Desktop (optional)

### Installation

1. **Clone the repository**:
   ```bash
   git clone git@github.com:waleed-shabbir-91/ats-tracking-system.git
   cd applicant-tracking-system
   ```
2. **Install dependencies**:
   ```bash
   bundle install
   ```
3. **Setup the database**:
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```
4. **Run the application**:
   ```bash
   rails server
   ```
### Docker setup (easier)
Once the repository has been clone and you are in the core directory
1. **Build the image**:
   ```bash
   docker-compose build
   ```
2. **Start the application**:
   ```bash
   docker-compose up
   ```
   This will also create the database, run the migrations and seed the data under db/seeds.rb. You can then visit the following endpoints to view the data
   
#### Now you can access the application at localhost:3000
   
## API Endpoints
For this application I have kept it very lightweight using the controllers in Rails. For production I would opt for grape with api versioning.
### Jobs
- **Get all jobs**:
```bash
GET /jobs
```
- **Response**:
```bash
[
  {
    "title": "Software Engineer",
    "description": "Develop and maintain high-quality software solutions.",
    "status": "activated",
    "hired_count": 1,
    "rejected_count": 1,
    "ongoing_count": 0
  }
]
```
### Applications
- **Get all activated jobs**:
```bash
GET /applications
```
- **Response**:
```bash
[
  {
    "title": "Software Engineer",
    "candidate_name": "John Doe",
    "status": "hired",
    "notes_count": 1,
    "last_interview_date": "2023-10-15T12:00:00Z",
    "hired_date": "2023-10-16T12:00:00Z"
  }
]
```

## Run tests
I have added simple mintests for the model and controllers in order to keep this lightweight and usable. For production deployments I may opt for RSpec.
In order to run the tests
```bash
rails test
```
