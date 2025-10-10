# Bulk Import Setup Guide

This guide will help you set up the Google Places API integration for bulk importing leads.

## Prerequisites

You need a Google Places API key to use the bulk import feature.

## Step 1: Get a Google Places API Key

1. Go to the [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select an existing one
3. Enable the **Places API** for your project
4. Go to **Credentials** and create an API key
5. (Recommended) Restrict your API key to only the Places API

## Step 2: Set Up Your Environment Variable

### For Development (macOS/Linux)

Add the following to your shell configuration file (e.g., `~/.zshrc`, `~/.bashrc`):

```bash
export GOOGLE_PLACES_API_KEY="your_actual_api_key_here"
```

Then reload your shell:

```bash
source ~/.zshrc  # or source ~/.bashrc
```

### For Production

Set the environment variable in your hosting platform:

- **Heroku**: `heroku config:set GOOGLE_PLACES_API_KEY=your_api_key`
- **AWS/DigitalOcean**: Add to your environment configuration
- **Docker**: Add to your `.env` file or docker-compose.yml

## Step 3: Restart Your Rails Server

After setting the environment variable, restart your Rails server:

```bash
bin/dev
```

## Using the Bulk Import Feature

1. Navigate to **Leads** page
2. Click **Bulk Import** button
3. Enter your search parameters:
   - **Business Type**: e.g., "Plumbers", "Restaurants", "Auto Repair"
   - **Location**: e.g., "Camarillo, CA", "90210", "New York"
4. Click **Search Google Maps**
5. Review the results
6. Select the businesses you want to import
7. Click **Import Selected Leads**

## Features

- **Smart Search**: Combines business type and location for accurate results
- **Detailed Information**: Automatically fetches:
  - Business name
  - Address/location
  - Phone number
  - Website
  - Business status (open, closed, etc.)
- **Selective Import**: Choose exactly which leads to add
- **Automatic Categorization**: All imported leads are:
  - Set to "Low" interest level (you can update later)
  - Set to "Interested" status
  - Tagged with import date in notes

## API Usage & Costs

- Google Places API has a free tier with quotas
- Check [Google Maps Platform Pricing](https://developers.google.com/maps/billing-and-pricing/pricing)
- The app makes:
  - 1 Text Search request per search
  - 1 Place Details request per imported lead

## Troubleshooting

### "Google Places API key is not set" Error

Make sure you've set the `GOOGLE_PLACES_API_KEY` environment variable and restarted your server.

### "API Error: REQUEST_DENIED"

Your API key may not have the Places API enabled. Check your Google Cloud Console settings.

### No Results Found

Try:
- Using a more specific location (e.g., "90210" instead of "California")
- Using simpler business type terms (e.g., "Plumber" instead of "Emergency Plumbing Services")
- Checking that the business type and location combination exists

### Rate Limiting

If you're hitting API limits, consider:
- Enabling billing in Google Cloud (increases quotas significantly)
- Being more selective with your searches
- Spacing out large imports

## Security Notes

- Never commit your API key to version control
- Restrict your API key to only the Places API
- Consider setting up billing alerts in Google Cloud
- Use separate API keys for development and production

