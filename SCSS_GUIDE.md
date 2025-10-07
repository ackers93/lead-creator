# SCSS Guide for Lead Creator

## Overview
Your Rails application is now set up with **Dart Sass** for SCSS compilation. The stylesheets are automatically compiled when you run the development server.

## Project Structure

```
app/assets/stylesheets/
├── application.scss          # Main stylesheet (imports all others)
├── _variables.scss           # Color, spacing, typography variables
├── _mixins.scss             # Reusable SCSS mixins
├── _base.scss               # Base HTML element styles
├── components/
│   ├── _buttons.scss        # Button styles
│   ├── _forms.scss          # Form and input styles
│   └── _alerts.scss         # Alert and flash message styles
├── layouts/
│   ├── _header.scss         # Header navigation styles
│   └── _footer.scss         # Footer styles
└── pages/
    └── _home.scss           # Home page specific styles
```

## Running the Development Server

### Option 1: Using Foreman (Recommended)
```bash
bin/dev
```
This will start both the Rails server AND the Sass watcher, which automatically recompiles your SCSS on changes.

### Option 2: Manual (Two terminals)
Terminal 1:
```bash
rails server
```

Terminal 2:
```bash
rails dartsass:watch
```

## Available CSS Classes

### Buttons
- `.btn` - Base button class
- `.btn-primary` - Blue button
- `.btn-secondary` - Gray button
- `.btn-success` - Green button
- `.btn-danger` - Red button
- `.btn-warning` - Yellow button
- `.btn-info` - Light blue button
- `.btn-sm` - Small button
- `.btn-lg` - Large button

### Forms
- `.form-group` - Form field container
- `.form-label` - Form labels
- `.form-control` - Text inputs, textareas, selects
- `.form-check` - Checkbox/radio container
- `.devise-form` - Styled Devise authentication forms

### Alerts
- `.notice` - Success notifications (green)
- `.alert` - Error notifications (red)
- `.alert-success` - Success alert
- `.alert-danger` - Danger alert
- `.alert-warning` - Warning alert
- `.alert-info` - Info alert

### Layout
- `.container` - Main content container (max-width: 1200px)
- `.header` - Header navigation
- `.footer` - Footer section

## Customization

### Colors
Edit `_variables.scss` to change the color scheme:
```scss
$primary-color: #007bff;
$secondary-color: #6c757d;
// ... more colors
```

### Spacing
Modify the spacing scale in `_variables.scss`:
```scss
$spacer: 1rem;
$spacers: (
  0: 0,
  1: ($spacer * 0.25),
  2: ($spacer * 0.5),
  // ...
);
```

### Mixins
Use the available mixins in your components:
```scss
// Center content with flexbox
@include flex-center;

// Responsive design
@include respond-to("mobile") {
  // Mobile styles
}

// Button variant
@include button-variant($custom-color);

// Box shadow
@include box-shadow(2);
```

## Adding New Styles

### 1. Add a new component
Create a new file: `app/assets/stylesheets/components/_mycomponent.scss`

Import it in `application.scss`:
```scss
@import "components/mycomponent";
```

### 2. Add a new page style
Create: `app/assets/stylesheets/pages/_mypage.scss`

Import it in `application.scss`:
```scss
@import "pages/mypage";
```

## Compiled Output
SCSS files are compiled to: `app/assets/builds/application.css`

⚠️ **Never edit the compiled CSS directly** - always edit the SCSS source files!

## Tips
1. Use variables for colors, spacing, and typography
2. Use mixins for repeated patterns
3. Keep components small and focused
4. Use BEM naming convention for complex components
5. Mobile-first responsive design with `@include respond-to()`

