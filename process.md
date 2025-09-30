# 🚀 Taskletix Website - Complete Setup Guide

A comprehensive guide to set up and run the Taskletix web agency website with contact form functionality, featuring a Flask backend API and a modern HTML/CSS/JavaScript frontend.

## 📋 Table of Contents

- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Detailed Setup](#detailed-setup)
- [Database Setup](#database-setup)
- [Environment Configuration](#environment-configuration)
- [Running the Application](#running-the-application)
- [Testing the Features](#testing-the-features)
- [Troubleshooting](#troubleshooting)
- [Deployment](#deployment)

## 🔧 Prerequisites

Before you begin, ensure you have the following installed on your system:

### Required Software
- **Python 3.8+** - [Download Python](https://www.python.org/downloads/)
- **Node.js 16+** - [Download Node.js](https://nodejs.org/)
- **MySQL 8.0+** - [Download MySQL](https://dev.mysql.com/downloads/mysql/) or use XAMPP
- **Git** - [Download Git](https://git-scm.com/downloads)

### Optional (Recommended)
- **XAMPP** - For easy MySQL management - [Download XAMPP](https://www.apachefriends.org/)
- **VS Code** - For code editing - [Download VS Code](https://code.visualstudio.com/)

## ⚡ Quick Start

If you want to get up and running quickly, follow these steps:

```bash
# 1. Clone the repository
git clone <your-repository-url>
cd tasklitx-demo-website

# 2. Set up the backend
cd backend
pip install -r requirements.txt

# 3. Set up the frontend
cd ../frontend
npm install

# 4. Create environment file
cd ../backend
cp env_template.txt .env
# Edit .env with your MySQL credentials

# 5. Set up database
# Run the SQL commands in backend/db.sql

# 6. Start the servers
# Terminal 1 - Backend
cd backend
python app.py

# Terminal 2 - Frontend
cd frontend
npm run dev
```

## 📁 Detailed Setup

### Step 1: Clone the Repository

```bash
# Clone the repository
git clone <your-repository-url>
cd tasklitx-demo-website

# Verify the project structure
ls -la
```

You should see:
```
tasklitx-demo-website/
├── backend/
├── frontend/
├── README.md
├── process.md
└── MIGRATION_GUIDE.md
```

### Step 2: Backend Setup

```bash
# Navigate to backend directory
cd backend

# Install Python dependencies
pip install -r requirements.txt

# Verify installation
python --version
pip list
```

**Required Python Packages:**
- Flask
- Flask-CORS
- python-dotenv
- mysql-connector-python
- reportlab (for PDF export)

### Step 3: Frontend Setup

```bash
# Navigate to frontend directory
cd ../frontend

# Install Node.js dependencies
npm install

# Verify installation
node --version
npm --version
```

## 🗄️ Database Setup

### Option A: Using XAMPP (Recommended for beginners)

1. **Install XAMPP**
   - Download and install XAMPP from [apachefriends.org](https://www.apachefriends.org/)
   - Start Apache and MySQL services

2. **Access phpMyAdmin**
   - Open browser and go to: `http://localhost/phpmyadmin`
   - Create a new database: `taskletix_db`

3. **Import Database Schema**
   - Click on the `taskletix_db` database
   - Go to "Import" tab
   - Choose file: `backend/db.sql`
   - Click "Go" to import

### Option B: Using MySQL Command Line

```bash
# Connect to MySQL
mysql -u root -p

# Run the database setup commands
source backend/db.sql;
```

### Option C: Using MySQL Workbench

1. Open MySQL Workbench
2. Connect to your MySQL server
3. Create a new database: `taskletix_db`
4. Open and execute the `backend/db.sql` file

## ⚙️ Environment Configuration

### Step 1: Create Environment File

```bash
# Navigate to backend directory
cd backend

# Copy the template file
cp env_template.txt .env
```

### Step 2: Configure Environment Variables

Edit the `.env` file with your MySQL credentials:

```env
# Database Configuration
MYSQL_HOST=localhost
MYSQL_USER=root
MYSQL_PASSWORD=your_mysql_password
MYSQL_DATABASE=taskletix_db

# Admin Configuration
ADMIN_PASSWORD=your_admin_password

# Server Configuration
PORT=5000
DEBUG=True
```

**Important Notes:**
- Replace `your_mysql_password` with your actual MySQL password
- Replace `your_admin_password` with a secure admin password
- Keep the `.env` file secure and never commit it to Git

## 🚀 Running the Application

### Step 1: Start the Backend Server

```bash
# Navigate to backend directory
cd backend

# Start the Flask server
python app.py
```

**Expected Output:**
```
 * Serving Flask app 'app'
 * Debug mode: on
 * Running on http://0.0.0.0:5000
```

### Step 2: Start the Frontend Server

Open a new terminal window:

```bash
# Navigate to frontend directory
cd frontend

# Start the development server
npm run dev
```

**Expected Output:**
```
Local:   http://localhost:3000/
Network: http://192.168.x.x:3000/
```

### Step 3: Access the Application

- **Main Website**: http://localhost:3000
- **Admin Login**: http://localhost:3000/admin-login.html
- **Admin Dashboard**: http://localhost:3000/admin-dashboard.html
- **Backend API**: http://localhost:5000

## 🧪 Testing the Features

### 1. Test the Contact Form

1. Go to http://localhost:3000
2. Scroll to the "Let's Connect" section
3. Fill out the form with:
   - **Name**: Your name
   - **Email**: A valid Gmail address (e.g., test@gmail.com)
   - **Phone**: Select country code and enter phone number
   - **Project Type**: Select any option
   - **Project Details**: Enter some text
4. Click "Send Project Details"
5. Check for success message

### 2. Test Gmail Validation

1. Try entering non-Gmail addresses (should show error)
2. Enter valid Gmail addresses (should show success)
3. Verify only Gmail addresses are accepted

### 3. Test Country Code Selection

1. Select different country codes from the dropdown
2. Verify the phone number includes the country code
3. Submit the form and check the admin dashboard

### 4. Test Admin Dashboard

1. Go to http://localhost:3000/admin-login.html
2. Login with your admin password
3. View submitted contact forms
4. Check that country codes are displayed
5. Test the PDF export feature

## 🔍 Troubleshooting

### Common Issues and Solutions

#### 1. Database Connection Issues

**Error**: `mysql.connector.errors.InterfaceError: 2003: Can't connect to MySQL server`

**Solutions**:
```bash
# Check if MySQL is running
# For XAMPP: Start MySQL service
# For standalone MySQL: sudo systemctl start mysql

# Verify connection details in .env file
# Test connection manually
mysql -u root -p
```

#### 2. Port Already in Use

**Error**: `Address already in use`

**Solutions**:
```bash
# Find process using port 5000
lsof -i :5000

# Kill the process
kill -9 <PID>

# Or change port in .env file
PORT=5001
```

#### 3. Python Dependencies Issues

**Error**: `ModuleNotFoundError: No module named 'flask'`

**Solutions**:
```bash
# Reinstall dependencies
pip install -r requirements.txt

# Or install individually
pip install flask flask-cors python-dotenv mysql-connector-python
```

#### 4. Node.js Dependencies Issues

**Error**: `Cannot find module 'express'`

**Solutions**:
```bash
# Reinstall dependencies
npm install

# Clear npm cache
npm cache clean --force
npm install
```

#### 5. CORS Issues

**Error**: `Access to fetch at 'http://localhost:5000/api/contact' from origin 'http://localhost:3000' has been blocked by CORS policy`

**Solutions**:
- Ensure backend is running on port 5000
- Check that CORS is properly configured in `backend/app.py`
- Verify the frontend is making requests to the correct URL

### Debug Mode

Enable debug mode for more detailed error messages:

```bash
# In backend/.env
DEBUG=True

# Or set environment variable
export FLASK_DEBUG=1
```

## 🌐 Deployment

### Local Network Access

To access the application from other devices on your network:

```bash
# Backend (already configured)
python app.py  # Runs on 0.0.0.0:5000

# Frontend (modify package.json)
# Change "dev": "vite" to "dev": "vite --host 0.0.0.0"
```

### Production Deployment

For production deployment, consider:

1. **Backend**: Deploy to services like:
   - Heroku
   - DigitalOcean
   - AWS EC2
   - Railway

2. **Frontend**: Deploy to services like:
   - Netlify
   - Vercel
   - GitHub Pages
   - AWS S3

3. **Database**: Use managed MySQL services:
   - AWS RDS
   - Google Cloud SQL
   - PlanetScale
   - Railway

## 📁 Project Structure

```
tasklitx-demo-website/
├── backend/
│   ├── app.py              # Flask API server
│   ├── config.py           # Configuration
│   ├── db.py               # Database connection
│   ├── db.sql              # Database schema
│   ├── requirements.txt    # Python dependencies
│   ├── env_template.txt    # Environment template
│   └── test_pdf.py         # PDF generation test
├── frontend/
│   ├── index.html          # Main website
│   ├── admin-login.html    # Admin login page
│   ├── admin-dashboard.html # Admin dashboard
│   ├── taskletix.css       # Styles
│   ├── taskletix.js        # JavaScript
│   ├── admin.css           # Admin styles
│   ├── admin.js            # Admin JavaScript
│   ├── package.json        # Node.js configuration
│   └── images/             # Website images
├── README.md               # Main documentation
├── process.md              # This setup guide
└── MIGRATION_GUIDE.md      # Database migration guide
```

## 🔧 Configuration Files

### Backend Configuration

**`backend/requirements.txt`**:
```
Flask==2.3.3
Flask-CORS==4.0.0
python-dotenv==1.0.0
mysql-connector-python==8.1.0
reportlab==4.0.4
```

**`backend/.env`** (create this):
```env
MYSQL_HOST=localhost
MYSQL_USER=root
MYSQL_PASSWORD=your_password
MYSQL_DATABASE=taskletix_db
ADMIN_PASSWORD=admin123
PORT=5000
DEBUG=True
```

### Frontend Configuration

**`frontend/package.json`**:
```json
{
  "name": "taskletix-frontend",
  "version": "1.0.0",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview"
  },
  "devDependencies": {
    "vite": "^4.4.9"
  }
}
```

## 📞 Support

If you encounter any issues:

1. **Check the troubleshooting section above**
2. **Verify all prerequisites are installed**
3. **Ensure database is properly configured**
4. **Check environment variables are correct**

### Contact Information

- **Email**: taskletix@gmail.com
- **Phone**: +91 95730 586468

## 🎉 Success!

Once you've completed all the steps above, you should have:

✅ **Working website** at http://localhost:3000  
✅ **Contact form** with country code selection  
✅ **Gmail validation** for email addresses  
✅ **Admin dashboard** for viewing submissions  
✅ **PDF export** functionality  
✅ **Database** storing all submissions  

The application is now ready for development, testing, or deployment!

---

**Happy Coding! 🚀**
