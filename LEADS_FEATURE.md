# Leads Management Feature

## Overview
A comprehensive lead management system with modern Rails 8 features including Hotwire, Turbo, and Stimulus.

## Features Implemented

### ✅ Lead Model
- **Business Information**: Business name, contact name, location, website
- **Contact Details**: Email, phone
- **Social Media**: Twitter/X, Instagram, Facebook, TikTok
- **Status Tracking**: 7 status options (interested, thinking, follow_up, onboarding, accepted, denied, on_hold)
- **Interest Levels**: 4 levels (low, medium, high, very_high)
- **Notes**: Free-form text area for additional information
- **Validations**: Email format, phone format, website URL validation
- **User Association**: Each lead belongs to a user

### ✅ CRUD Operations
- **Create**: Add new leads with comprehensive form
- **Read**: View all leads in card grid layout or detailed view
- **Update**: Edit existing leads
- **Delete**: Remove leads with confirmation
- **All operations use Turbo Streams** for instant UI updates without page refreshes

### ✅ Search & Filtering
- **Search**: Real-time search by business name, contact name, or location
- **Status Filter**: Filter by lead status
- **Interest Level Filter**: Filter by interest level
- **Turbo Frames**: Filters update the list without full page reload

### ✅ Modern UI/UX
- **Card Grid Layout**: Beautiful, responsive card-based display
- **Color-Coded Badges**: Visual status and interest level indicators
- **Icons**: SVG icons for actions and information
- **Social Media Links**: Direct links to social profiles
- **Empty States**: Helpful messaging when no leads exist
- **Form Sections**: Organized, multi-section forms
- **Responsive Design**: Mobile-friendly layout

### ✅ Rails 8 Features
- **Turbo Frames**: For dynamic content updates
- **Turbo Streams**: For create, update, delete operations
- **Form Helpers**: Modern Rails 8 form_with
- **RESTful Routes**: Standard Rails resource routing
- **Hotwire Ready**: No JavaScript framework required

## Database Schema

```ruby
create_table "leads" do |t|
  t.references :user, null: false, foreign_key: true
  t.string :business_name       # Required
  t.string :contact_name
  t.string :phone
  t.string :email
  t.string :twitter
  t.string :instagram
  t.string :facebook
  t.string :tiktok
  t.string :website
  t.string :location
  t.integer :interest_level     # Required (0-3)
  t.integer :status             # Required (0-6)
  t.text :notes
  t.timestamps
end
```

## Enums

### Status Options
- `interested` (0) - Initial contact, showing interest
- `thinking` (1) - Considering the offer
- `follow_up` (2) - Needs follow-up contact
- `onboarding` (3) - In onboarding process
- `accepted` (4) - Deal closed, client accepted
- `denied` (5) - Declined or rejected
- `on_hold` (6) - Temporarily paused

### Interest Levels
- `low` (0) - Minimal interest
- `medium` (1) - Moderate interest
- `high` (2) - Strong interest
- `very_high` (3) - Urgent or very high priority

## Routes

```
GET    /leads           # List all leads
POST   /leads           # Create new lead
GET    /leads/new       # New lead form
GET    /leads/:id       # Show lead details
GET    /leads/:id/edit  # Edit lead form
PATCH  /leads/:id       # Update lead
DELETE /leads/:id       # Delete lead
```

## Usage

### Creating a Lead
1. Navigate to `/leads`
2. Click "New Lead" button
3. Fill in required fields (business name, status, interest level)
4. Add optional contact info and social media handles
5. Submit form
6. Lead appears instantly in the grid (Turbo Stream)

### Searching/Filtering
1. Use the search box to find leads by name or location
2. Select status dropdown to filter by status
3. Select interest level dropdown to filter by priority
4. Click "Filter" to apply
5. Results update instantly (Turbo Frame)

### Editing a Lead
1. Click the edit icon on any lead card
2. Modify fields as needed
3. Submit form
4. Card updates instantly (Turbo Stream)

### Deleting a Lead
1. Click the delete icon on any lead card
2. Confirm deletion
3. Card disappears instantly (Turbo Stream)

## Styling

All leads-related styles are in `app/assets/stylesheets/pages/_leads.scss`:
- Card layouts
- Badges
- Forms
- Filters
- Icons
- Responsive breakpoints

## Models

### Lead Model (`app/models/lead.rb`)
- Belongs to User
- Enums for status and interest_level
- Validations for data integrity
- Scopes for search and filtering
- Helper methods for badge classes

### User Model (`app/models/user.rb`)
- Has many Leads (dependent: :destroy)
- Devise authentication

## Controllers

### LeadsController (`app/controllers/leads_controller.rb`)
- Before action: `authenticate_user!` (all actions)
- Before action: `set_lead` (show, edit, update, destroy)
- Scoped to `current_user.leads`
- Responds to HTML and Turbo Stream formats

## Views

- `index.html.erb` - Card grid with search/filters
- `show.html.erb` - Detailed lead view
- `new.html.erb` - New lead form
- `edit.html.erb` - Edit lead form
- `_form.html.erb` - Shared form partial
- `_lead_card.html.erb` - Individual lead card
- Turbo Stream partials for create/update/destroy

## Next Steps (Optional Enhancements)

### Pagination
```bash
# Add Pagy gem
gem 'pagy'
bundle install
```

### Export to CSV
```ruby
# In controller
respond_to do |format|
  format.csv { send_data @leads.to_csv }
end
```

### Bulk Actions
- Select multiple leads
- Bulk status updates
- Bulk delete

### Activity Timeline
- Track status changes
- Log interactions
- View history

### Email Integration
- Send emails to leads
- Track opens/clicks
- Email templates

### Analytics Dashboard
- Leads by status chart
- Conversion rates
- Lead sources
- Time to close

## Testing

Start the development server:
```bash
bin/dev
```

1. Sign up for an account
2. You'll be redirected to `/leads`
3. Create your first lead
4. Test search and filtering
5. Edit and delete leads

All operations happen instantly with Turbo!

