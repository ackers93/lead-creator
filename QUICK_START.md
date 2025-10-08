# Quick Start Guide

## 🚀 Getting Started with Lead Creator

### Prerequisites Check
- ✅ Ruby 3.4.2 installed
- ✅ PostgreSQL running
- ✅ Rails 8.0.3 installed

### Start the Application

```bash
# Start both Rails server and SCSS watcher
bin/dev
```

The application will be available at: **http://localhost:3000**

### First Time Setup

1. **Create an account**
   - Go to http://localhost:3000
   - Click "Sign Up"
   - Enter email and password
   - Submit form

2. **You'll automatically be redirected to your leads dashboard**

3. **Create your first lead**
   - Click "New Lead" button
   - Fill in the required fields:
     - Business Name (required)
     - Status (required)
     - Interest Level (required)
   - Add optional information:
     - Contact details (email, phone)
     - Social media handles
     - Location
     - Notes
   - Click "Create Lead"

4. **Your lead appears instantly!** (Thanks to Turbo Streams)

### Key Features to Try

#### 🔍 Search
- Type in the search box to find leads by business name, contact, or location
- Results update as you type

#### 🎯 Filtering
- Filter by Status (interested, thinking, follow_up, onboarding, accepted, denied, on_hold)
- Filter by Interest Level (low, medium, high, very_high)
- Combine filters for precise results

#### ✏️ Quick Edit
- Click the edit icon on any lead card
- Make changes
- Submit - the card updates instantly

#### 🗑️ Delete
- Click the delete icon on any lead card
- Confirm deletion
- The card disappears instantly

#### 👁️ View Details
- Click on the business name to see full details
- View all contact information
- See social media links
- Read notes

### Example Lead Data

Here's a sample lead you can create for testing:

**Business Information:**
- Business Name: Acme Corporation
- Contact Name: John Doe
- Location: San Francisco, CA
- Website: https://acme.example.com

**Contact:**
- Email: john@acme.example.com
- Phone: +1 (555) 123-4567

**Social Media:**
- Twitter: acmecorp
- Instagram: acmecorp
- Facebook: facebook.com/acmecorp

**Status:**
- Status: Interested
- Interest Level: High

**Notes:**
```
First contact made via email on [today's date].
Interested in our premium package.
Follow up next week to discuss pricing.
```

### Keyboard Shortcuts (Coming in Turbo 8)

While editing:
- `Cmd/Ctrl + Enter` - Submit form
- `Esc` - Cancel/Go back

### Development Tips

#### Viewing Logs
```bash
# In a separate terminal
tail -f log/development.log
```

#### Rails Console
```bash
# Open Rails console
rails console

# Create a lead programmatically
user = User.first
user.leads.create!(
  business_name: "Test Corp",
  status: :interested,
  interest_level: :high
)

# View all leads
Lead.count
Lead.all
```

#### Database Commands
```bash
# Reset database
rails db:reset

# Run migrations
rails db:migrate

# Seed data (if you add seeds)
rails db:seed
```

### Troubleshooting

#### "No leads found"
- Make sure you're signed in
- Create a lead using the "New Lead" button

#### Styles not loading
```bash
# Recompile SCSS
rails dartsass:build
```

#### Server won't start
```bash
# Check if port 3000 is in use
lsof -ti:3000

# Kill the process if needed
kill -9 $(lsof -ti:3000)

# Restart
bin/dev
```

#### Database errors
```bash
# Recreate database
rails db:drop db:create db:migrate
```

### Project Structure

```
app/
├── controllers/
│   ├── home_controller.rb
│   └── leads_controller.rb
├── models/
│   ├── user.rb
│   └── lead.rb
├── views/
│   ├── home/
│   ├── leads/
│   └── shared/
└── assets/
    └── stylesheets/
        ├── pages/
        │   ├── _home.scss
        │   └── _leads.scss
        └── components/
            ├── _buttons.scss
            ├── _forms.scss
            └── _alerts.scss
```

### Environment

**Development:**
- Database: lead_creator_development
- Port: 3000
- Hot reload: Enabled

**Test:**
- Database: lead_creator_test

### What's Next?

See `LEADS_FEATURE.md` for detailed documentation on:
- All available features
- Data model structure
- Customization options
- Advanced usage

### Need Help?

Check these files:
- `README.md` - Project overview
- `LEADS_FEATURE.md` - Feature documentation
- `SCSS_GUIDE.md` - Styling guide

Happy lead tracking! 📊

