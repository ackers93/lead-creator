# Testing the Bulk Import Feature

## Quick Test (Without API Key)

If you want to see the interface without setting up a Google API key, you can test the form:

1. Start your Rails server:
   ```bash
   bin/dev
   ```

2. Navigate to: http://localhost:3000/bulk_imports/new

3. You'll see the bulk import form with:
   - Business Type input
   - Location input
   - Information about how the feature works
   - Instructions for getting an API key

4. If you try to search without an API key, you'll get a clear error message explaining what's needed.

## Full Test (With API Key)

Once you've set up your Google Places API key (see [BULK_IMPORT_SETUP.md](BULK_IMPORT_SETUP.md)):

### Example Searches

1. **Local Plumbers**
   - Business Type: `Plumbers`
   - Location: `Camarillo, CA`
   
2. **Coffee Shops**
   - Business Type: `Coffee Shops`
   - Location: `90210`
   
3. **Auto Repair**
   - Business Type: `Auto Repair`
   - Location: `New York, NY`

### Expected Results

After searching, you should see:
- A grid of business cards with:
  - Business name
  - Full address
  - Business status (Open, Closed, etc.)
  - Link to view on Google Maps
- Checkboxes to select which businesses to import
- "Select All" and "Select None" buttons
- "Import Selected Leads" button

### After Import

Imported leads will:
- Appear in your Leads list
- Have "Low" interest level
- Have "Interested" status
- Include a note with the import date
- Include all available information (name, location, phone, website)

## Troubleshooting Test Scenarios

### Test 1: Missing API Key
- **Action**: Try searching without setting the API key
- **Expected**: Clear error message about missing API key

### Test 2: No Results
- **Action**: Search for something very specific like "Purple Unicorn Shops in Antarctica"
- **Expected**: "No results found" message with option to search again

### Test 3: Partial Information
- **Action**: Import a business that might not have all fields (phone, website)
- **Expected**: Lead is created with available information, empty fields are left blank

### Test 4: Duplicate Import
- **Action**: Try importing the same business twice
- **Expected**: First import succeeds, second one might fail due to duplicate business name validation (or succeeds if names are slightly different)

### Test 5: Closed Business
- **Action**: Import a business marked as "CLOSED_PERMANENTLY"
- **Expected**: Business is skipped with a notification

## Feature Flow

```
1. Click "Bulk Import" button on Leads page
   ↓
2. Fill in Business Type and Location
   ↓
3. Click "Search Google Maps"
   ↓
4. Review results (fetched from Google Places API)
   ↓
5. Select businesses to import (all selected by default)
   ↓
6. Click "Import Selected Leads"
   ↓
7. App fetches detailed info for each selected business
   ↓
8. Creates Lead records in database
   ↓
9. Redirects to Leads page with success/failure message
   ↓
10. New leads appear in your list!
```

## What Gets Imported

From each Google Places result, the app imports:
- ✅ Business Name (required)
- ✅ Full Address/Location
- ✅ Phone Number (if available)
- ✅ Website (if available)
- ✅ Business Status (used to filter out closed businesses)
- ✅ Import note with date

Not imported (set to defaults):
- Interest Level: Low (you can update after reviewing)
- Status: Interested (you can update after contacting)
- Contact Name: Empty (add when you get it)
- Social Media: Empty (add when you find them)
- Notes: Auto-generated import note (you can add more)

## Performance Notes

- Text Search: ~1-2 seconds per search
- Place Details: ~0.5-1 second per business
- Importing 10 businesses: ~5-10 seconds total
- Results are processed sequentially to avoid rate limits

## API Limits (Free Tier)

Google Places API free tier includes:
- **Text Search**: $32 per 1,000 requests (first $200/month free)
- **Place Details**: $17 per 1,000 requests (first $200/month free)

So with the free tier, you can do approximately:
- ~6,000 searches per month
- ~11,000 detail fetches per month

This is usually more than enough for small to medium usage!

