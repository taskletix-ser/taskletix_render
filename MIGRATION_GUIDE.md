# Migration Guide - Country Code & Gmail Validation

This guide explains the new features added to the Taskletix contact form and how to migrate existing databases.

## 🆕 New Features

### 1. Country Code Selection
- Added country code dropdown with popular countries
- Phone numbers now include country code information
- Helps identify client locations for better service

### 2. Gmail Validation
- Only Gmail addresses are accepted
- Real-time validation with visual feedback
- Server-side validation for security

## 🔄 Database Migration

### For New Installations
If you're setting up the project for the first time, use the updated `db.sql` file which already includes the `country_code` column.

### For Existing Installations
If you already have a database with contact submissions, run the migration script:

1. **Open your MySQL client** (phpMyAdmin, MySQL Workbench, or command line)

2. **Run the migration script:**
   ```sql
   -- Copy and paste the contents of backend/migrate_add_country_code.sql
   ```

3. **Or run these commands manually:**
   ```sql
   USE taskletix_db;
   
   -- Add country_code column
   ALTER TABLE contact_submissions 
   ADD COLUMN IF NOT EXISTS country_code VARCHAR(10) AFTER phone;
   
   -- Update existing records with default country code (India)
   UPDATE contact_submissions 
   SET country_code = '+91' 
   WHERE country_code IS NULL OR country_code = '';
   ```

## 🧪 Testing the New Features

### 1. Test Country Code Selection
- Fill out the contact form
- Select different country codes from the dropdown
- Verify the phone number includes the country code

### 2. Test Gmail Validation
- Try entering non-Gmail addresses (should show error)
- Enter valid Gmail addresses (should show success)
- Check that only Gmail addresses are accepted

### 3. Check Admin Dashboard
- View submissions in the admin dashboard
- Verify country code column is displayed
- Check that phone numbers include country codes

## 📋 Country Codes Available

The form includes these popular country codes:
- 🇺🇸 +1 (US)
- 🇬🇧 +44 (UK) 
- 🇮🇳 +91 (India) - Default
- 🇦🇺 +61 (Australia)
- 🇨🇳 +86 (China)
- 🇯🇵 +81 (Japan)
- 🇩🇪 +49 (Germany)
- 🇫🇷 +33 (France)
- 🇮🇹 +39 (Italy)
- 🇪🇸 +34 (Spain)
- 🇷🇺 +7 (Russia)
- 🇧🇷 +55 (Brazil)
- 🇲🇽 +52 (Mexico)
- 🇦🇪 +971 (UAE)
- 🇸🇦 +966 (Saudi Arabia)
- 🇸🇬 +65 (Singapore)
- 🇲🇾 +60 (Malaysia)
- 🇹🇭 +66 (Thailand)
- 🇻🇳 +84 (Vietnam)

## 🔧 Troubleshooting

### Migration Issues
- **Column already exists**: The migration script uses `IF NOT EXISTS`, so it's safe to run multiple times
- **Permission errors**: Make sure your MySQL user has ALTER TABLE permissions

### Form Issues
- **Country code not showing**: Check that the CSS is loaded properly
- **Gmail validation not working**: Check browser console for JavaScript errors
- **Form submission fails**: Verify backend is running and database is updated

### Backend Issues
- **Database errors**: Make sure the migration script was run successfully
- **Validation errors**: Check that the Gmail regex is working correctly

## 📞 Support

For issues or questions:
- Email: taskletix@gmail.com
- Phone: +91 95730 586468
