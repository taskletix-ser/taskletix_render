#!/bin/bash

# TASKLETIX Website Deployment Script for Hostinger VPS
# Run this script on your VPS after cloning the repository

echo "🚀 Starting TASKLETIX website deployment..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    print_error "Please run as root (use sudo)"
    exit 1
fi

# Update system
print_status "Updating system packages..."
apt update && apt upgrade -y

# Install required software
print_status "Installing required software..."

# Install Node.js 18.x
if ! command -v node &> /dev/null; then
    print_status "Installing Node.js 18.x..."
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    apt-get install -y nodejs
else
    print_status "Node.js already installed: $(node --version)"
fi

# Install Nginx
if ! command -v nginx &> /dev/null; then
    print_status "Installing Nginx..."
    apt install nginx -y
else
    print_status "Nginx already installed: $(nginx -v 2>&1)"
fi

# Install PM2
if ! command -v pm2 &> /dev/null; then
    print_status "Installing PM2..."
    npm install -g pm2
else
    print_status "PM2 already installed: $(pm2 --version)"
fi

# Install MongoDB
if ! command -v mongod &> /dev/null; then
    print_status "Installing MongoDB..."
    apt install mongodb -y
    systemctl enable mongodb
    systemctl start mongodb
else
    print_status "MongoDB already installed"
    systemctl start mongodb
fi

# Install Certbot
if ! command -v certbot &> /dev/null; then
    print_status "Installing Certbot..."
    apt install certbot python3-certbot-nginx -y
else
    print_status "Certbot already installed"
fi

# Navigate to project directory
cd /var/www/tasklitx-website

# Install backend dependencies
print_status "Installing backend dependencies..."
cd backend
npm install --production

# Create production environment file
if [ ! -f .env ]; then
    print_warning "Creating .env file from template..."
    cp env.production .env
    print_warning "Please edit .env file with your production values!"
else
    print_status ".env file already exists"
fi

# Start backend with PM2
print_status "Starting backend with PM2..."
pm2 delete taskletix-backend 2>/dev/null || true
pm2 start server.js --name "taskletix-backend"
pm2 save
pm2 startup

# Install frontend dependencies
print_status "Installing frontend dependencies..."
cd ../frontend
npm install

# Build frontend
print_status "Building frontend for production..."
npm run build

# Copy build files to Nginx directory
print_status "Copying frontend files to Nginx directory..."
cp -r dist/* /var/www/html/

# Create Nginx configuration
print_status "Creating Nginx configuration..."
cat > /etc/nginx/sites-available/tasklitx << 'EOF'
server {
    listen 80;
    server_name _;
    
    root /var/www/html;
    index index.html;
    
    # Frontend (React app)
    location / {
        try_files $uri $uri/ /index.html;
    }
    
    # Backend API
    location /api/ {
        proxy_pass http://localhost:5000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_cache_bypass $http_upgrade;
    }
    
    # Health check
    location /health {
        proxy_pass http://localhost:5000;
    }
}
EOF

# Enable site
print_status "Enabling Nginx site..."
ln -sf /etc/nginx/sites-available/tasklitx /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

# Test Nginx configuration
if nginx -t; then
    print_status "Nginx configuration is valid"
    systemctl reload nginx
else
    print_error "Nginx configuration is invalid"
    exit 1
fi

# Set up firewall (optional)
print_status "Setting up basic firewall..."
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw --force enable

# Final status
print_status "Deployment completed successfully!"
print_status "Your website should now be accessible at: http://$(curl -s ifconfig.me)"
print_status ""
print_warning "Next steps:"
print_warning "1. Update your domain DNS to point to this server"
print_warning "2. Run: certbot --nginx -d yourdomain.com"
print_warning "3. Edit backend/.env with your production values"
print_warning "4. Test your website functionality"
print_status ""
print_status "Useful commands:"
print_status "- Check backend: pm2 status"
print_status "- Check logs: pm2 logs taskletix-backend"
print_status "- Check Nginx: systemctl status nginx"
print_status "- Restart all: pm2 restart all && systemctl reload nginx"
