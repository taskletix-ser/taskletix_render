# Taskletix Contact Form Backend

Simple Flask backend to handle contact form submissions and store them in MySQL database.

## Files Structure
```
backend/
├── app.py              # Main Flask application
├── config.py           # Configuration settings
├── database.py         # Database connection
├── requirements.txt    # Python dependencies
├── schema.sql         # Database table creation
├── env_template.txt   # Environment variables template
├── test_pdf.py        # PDF generation test script
└── README.md         # This file
```

## EXACT STEPS TO RUN THE APP

### Step 1: Install Python Dependencies
```bash
cd backend
pip install -r requirements.txt
```

### Step 2: Create Database and Table
1. Open MySQL command line or phpMyAdmin
2. Run these SQL commands:

```sql
CREATE DATABASE taskletix_db;
USE taskletix_db;
```

3. Copy and paste the contents of `schema.sql` file into your MySQL client and run it.

### Step 3: Create Environment File
```bash
cp env_template.txt .env
```

### Step 4: Edit .env File
Open `.env` file and change these values:
```env
MYSQL_USER=root
MYSQL_PASSWORD=your_actual_mysql_password
ADMIN_PASSWORD=your_admin_password
```

### Step 5: Run the App
```bash
python app.py
```

The API will be running at: `http://localhost:5000`

## API Endpoints

### 1. Health Check
```
GET http://localhost:5000/health
```

### 2. Submit Contact Form
```
POST http://localhost:5000/api/contact
Content-Type: application/json

{
  "name": "John Doe",
  "email": "john@example.com",
  "phone": "+1234567890",
  "company": "Tech Corp",
  "project_type": "business",
  "budget_range": "3k-7k",
  "timeline": "Within 2 months",
  "project_details": "Need a modern business website..."
}
```

### 3. Admin Authentication
```
POST http://localhost:5000/api/admin/login
Content-Type: application/json

{
  "password": "your_admin_password"
}
```

### 4. View All Submissions (Admin)
```
GET http://localhost:5000/api/admin/submissions
Authorization: Bearer <token>
```

### 5. Export PDF Report (Admin)
```
GET http://localhost:5000/api/admin/export/pdf
Authorization: Bearer <token>
```

## Admin Dashboard

The admin dashboard is located at `frontend/admin-dashboard.html` and provides:

- **View Submissions**: See all contact form submissions in a table format
- **Search & Filter**: Search through submissions by name, email, project type, etc.
- **PDF Export**: Download a professional PDF report with all submissions
- **Real-time Updates**: Refresh data to see latest submissions

### Features of the PDF Report:
- **Landscape Layout**: Optimized for viewing all columns
- **Professional Styling**: Clean table format with alternating row colors
- **Complete Data**: Includes all submission fields including project details
- **Proper Formatting**: Dates, text truncation, and proper column widths
- **Header Styling**: Bold headers with background colors

## Test the API

You can test using curl:
```bash
curl -X POST http://localhost:5000/api/contact \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test User",
    "email": "test@example.com",
    "project_type": "business",
    "project_details": "Test project"
  }'
```

## Test PDF Generation

Run the test script to verify PDF generation works:
```bash
python test_pdf.py
```

## Check Database

To see if data is stored, run this SQL query:
```sql
SELECT * FROM contact_submissions ORDER BY created_at DESC;
```

That's it! The contact form submissions will be stored in the `contact_submissions` table and can be viewed/exported through the admin dashboard.
