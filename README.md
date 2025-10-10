# Lead Creator

A modern Rails 8 application with user authentication and SCSS styling.

## Tech Stack

- **Ruby**: 3.4.2
- **Rails**: 8.0.3
- **Database**: PostgreSQL
- **Authentication**: Devise
- **CSS**: SCSS with Dart Sass
- **JavaScript**: Importmap, Turbo, Stimulus
- **Deployment**: Kamal ready

## Prerequisites

- Ruby 3.4.2
- PostgreSQL
- Node.js (for some asset compilation)

## Getting Started

### 1. Clone the repository
```bash
git clone git@github.com:ackers93/lead-creator.git
cd lead-creator
```

### 2. Install dependencies
```bash
bundle install
```

### 3. Set up the database
```bash
rails db:create
rails db:migrate
```

### 4. Start the development server
```bash
bin/dev
```

This will start both the Rails server and the SCSS watcher.

The application will be available at `http://localhost:3000`

## Features

### ✅ User Authentication
- User registration and login (Devise)
- Password reset functionality
- Email confirmation (configurable)
- Remember me functionality

### ✅ Lead Management
- Full CRUD operations for leads
- Business information tracking (name, contact, location)
- Social media links (Twitter, Instagram, Facebook, TikTok)
- Interest level and status tracking
- Search and filter capabilities
- Card and table view options
- Notes for each lead

### ✅ Bulk Import (Google Places API)
- Search for businesses on Google Maps
- Import multiple leads at once
- Select specific businesses to import
- Automatically fetch business details (name, address, phone, website)
- Filter out closed businesses
- [Setup Guide](BULK_IMPORT_SETUP.md)

### ✅ Modern Styling
- SCSS with modern module system
- Organized architecture
- Responsive design
- Reusable components
- Custom color scheme and variables

### ✅ Rails 8 & Hotwire
- Turbo for SPA-like experience
- Stimulus for JavaScript interactions
- Modern form helpers
- Solid Cache for caching
- Solid Queue for background jobs
- Solid Cable for WebSockets
- Kamal for deployment

## Project Structure

```
app/
├── assets/stylesheets/     # SCSS files
│   ├── application.scss    # Main stylesheet
│   ├── _variables.scss     # Colors, spacing, typography
│   ├── _mixins.scss        # Reusable mixins
│   ├── _base.scss          # Base HTML styles
│   ├── components/         # Component styles
│   ├── layouts/            # Layout styles
│   └── pages/              # Page-specific styles
├── controllers/
├── models/
│   └── user.rb             # Devise User model
└── views/
    └── home/               # Home page views
```

## Development

### Running Tests
```bash
rails test
rails test:system
```

### Linting
```bash
bin/rubocop
bin/brakeman
```

### SCSS Development
See [SCSS_GUIDE.md](SCSS_GUIDE.md) for detailed information about styling.

## Database

This application uses PostgreSQL. The database configuration is in `config/database.yml`.

Development database: `lead_creator_development`
Test database: `lead_creator_test`

## Deployment

This application is configured for deployment with Kamal. See `config/deploy.yml` for configuration.

```bash
kamal setup
kamal deploy
```

## Environment Variables

### Required for Bulk Import Feature

To use the Google Places bulk import feature, you need to set up a Google Places API key:

```bash
export GOOGLE_PLACES_API_KEY="your_api_key_here"
```

See [BULK_IMPORT_SETUP.md](BULK_IMPORT_SETUP.md) for detailed setup instructions.

### Optional Environment Variables

Create a `.env` file for local development (not committed to git):

```env
DATABASE_URL=postgresql://localhost/lead_creator_development
RAILS_MASTER_KEY=<your-master-key>
GOOGLE_PLACES_API_KEY=<your-google-api-key>
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
