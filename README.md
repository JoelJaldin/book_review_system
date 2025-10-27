# Book Review Rating System

A web application developed with Ruby on Rails that allows managing book reviews with 1 to 5 star ratings.

## Features

- **Review Rating System**: 1 to 5 star rating system
- **Review Content**: Text content with 1000 character limit
- **Average Calculation**: Average rounded to one decimal place
- **Banned User Filtering**: Reviews from banned users don't count towards the average
- **Minimum Reviews**: At least 3 reviews required to show the average
- **Modern Frontend**: Interface developed with Stimulus, Turbo and Tailwind CSS
- **TDD Development**: Implemented following Test-Driven Development with RSpec
- **User Management**: Ban/unban users functionality
- **CRUD Operations**: Full Create, Read, Update, Delete operations for books and reviews

## Technologies Used

- **Backend**: Ruby on Rails 7.1
- **Database**: PostgreSQL
- **Testing**: RSpec, FactoryBot, Faker
- **Frontend**: Tailwind CSS (CDN), Turbo, Stimulus
- **Dependency Management**: Bundler, Importmap

## System Requirements

- **Ruby**: 3.3.5 (use rbenv or asdf)
- **PostgreSQL**: 12 or higher
- **Bundler**: Ruby gem manager

## Installation & Setup

### Prerequisites

Install the following on your system:
- Ruby 3.3.5 (recommended: rbenv)
- PostgreSQL 12+ 
- Git

### Quick Setup

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd book_review_system
   ```

2. **Install dependencies**:
   ```bash
   bundle install
   ```

3. **Setup PostgreSQL database** (edit `config/database.yml` if needed):
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. **Run tests** (verify everything works):
   ```bash
   rspec
   ```

5. **Start the server**:
   ```bash
   rails server
   # or
   bin/rails server
   ```

6. **Open in browser**: http://localhost:3000

### Database Configuration

The app uses PostgreSQL. Edit `config/database.yml` if needed:

```yaml
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: postgres  # Your PostgreSQL username
  password:          # Your PostgreSQL password (if needed)
```

## Project Structure

```
app/
├── controllers/
│   ├── books_controller.rb      # Books controller with CRUD operations
│   ├── reviews_controller.rb    # Reviews controller
│   └── users_controller.rb      # Users controller for ban functionality
├── models/
│   ├── book.rb                  # Book model with average_rating method
│   ├── review.rb                # Review model with validations
│   └── user.rb                  # User model with ban functionality
└── views/
    ├── books/                   # Book views (index, show, new, edit)
    ├── reviews/                # Review views
    └── layouts/
        └── application.html.erb  # Main layout with Tailwind CSS

spec/
├── models/                      # Model tests
├── requests/                    # Controller tests
├── factories/                   # Test factories
└── rails_helper.rb              # RSpec configuration
```

## Sample Data

The system includes seeds with sample data:
- 6 users (5 normal, 1 banned)
- 8 books from different authors  
- 11 reviews with varied ratings

Run `rails db:seed` to populate the database with sample data.


## Test-Driven Development (TDD)

This project follows **TDD methodology** using the Red-Green-Refactor cycle:

1. **Red**: Write failing test
2. **Green**: Implement minimum code to pass
3. **Refactor**: Improve while keeping tests green

### Running Tests

```bash
# Run all tests
rspec

# Run specific test files
rspec spec/models/book_spec.rb
rspec spec/models/review_spec.rb
rspec spec/requests/books_spec.rb

# Run with documentation format
rspec --format documentation

# Run specific suite
rspec spec/models
rspec spec/requests
```

### Test Coverage

- ✅ **Model Tests** (13 test cases):
  - Book model: 7 tests (associations, average_rating)
  - Review model: 6 tests (validations, associations)

- ✅ **Request Tests** (15+ test cases):
  - Books: CRUD operations with validations
  - Reviews: Create/delete with validations  
  - Users: Ban/unban functionality

- ✅ **Total**: 30+ comprehensive test cases
- ✅ **Coverage**: 100% of functional requirements
- ✅ **Factories**: FactoryBot + Faker for realistic data
