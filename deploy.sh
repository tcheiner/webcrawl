#!/bin/bash

# Romantsy Analyzer Deployment Script
# Usage: ./deploy.sh [development|production]

set -e

ENVIRONMENT=${1:-development}

echo "🚀 Deploying Romantsy Analyzer - Environment: $ENVIRONMENT"

# Check prerequisites
check_prerequisites() {
    echo "✅ Checking prerequisites..."
    
    if ! command -v node &> /dev/null; then
        echo "❌ Node.js is not installed"
        exit 1
    fi
    
    if ! command -v python3 &> /dev/null; then
        echo "❌ Python 3 is not installed"
        exit 1
    fi
    
    if ! command -v docker &> /dev/null; then
        echo "⚠️  Docker not found - Docker deployment will not be available"
    fi
    
    echo "✅ Prerequisites check completed"
}

# Setup environment
setup_environment() {
    echo "🔧 Setting up environment..."
    
    if [ ! -f .env ]; then
        cp .env.example .env
        echo "📝 Created .env file from template"
        echo "⚠️  Please edit .env with your API credentials before continuing"
        
        if [ "$ENVIRONMENT" = "production" ]; then
            echo "❌ Production deployment requires configured .env file"
            exit 1
        fi
    fi
    
    # Create necessary directories
    mkdir -p data logs
    echo "📁 Created data and logs directories"
}

# Deploy frontend
deploy_frontend() {
    echo "🎨 Deploying frontend..."
    
    cd frontend
    
    if [ ! -d node_modules ]; then
        npm install
    fi
    
    if [ "$ENVIRONMENT" = "production" ]; then
        npm run build
        echo "✅ Frontend built for production"
        
        if command -v vercel &> /dev/null; then
            echo "🚀 Deploying to Vercel..."
            vercel --prod --yes
        else
            echo "📦 Frontend built - ready for deployment to your hosting platform"
        fi
    else
        echo "🔧 Frontend ready for development (run 'npm run dev')"
    fi
    
    cd ..
}

# Deploy backend
deploy_backend() {
    echo "🐍 Deploying Python backend..."
    
    cd python-prototypes
    
    if [ ! -d venv ]; then
        python3 -m venv venv
        echo "🔧 Created Python virtual environment"
    fi
    
    source venv/bin/activate
    pip install -r requirements.txt
    echo "📦 Installed Python dependencies"
    
    # Test the setup
    python download_nltk_data.py
    echo "✅ NLTK data downloaded"
    
    if [ "$ENVIRONMENT" = "production" ]; then
        echo "🔄 Setting up production cron job..."
        echo "# Romantsy Analysis - runs daily at 6 AM"
        echo "0 6 * * * $(pwd)/venv/bin/python $(pwd)/analyze_romantsy.py >> $(pwd)/../logs/cron.log 2>&1"
        echo "⚠️  Add the above line to your crontab with 'crontab -e'"
    fi
    
    cd ..
}

# Docker deployment
deploy_docker() {
    echo "🐳 Deploying with Docker..."
    
    if ! command -v docker-compose &> /dev/null; then
        echo "❌ Docker Compose not found"
        return 1
    fi
    
    if [ "$ENVIRONMENT" = "production" ]; then
        docker-compose -f docker-compose.yml up -d --build
    else
        docker-compose up -d --build
    fi
    
    echo "✅ Docker deployment completed"
}

# Main deployment flow
main() {
    check_prerequisites
    setup_environment
    
    case "${2:-all}" in
        "frontend")
            deploy_frontend
            ;;
        "backend")
            deploy_backend
            ;;
        "docker")
            deploy_docker
            ;;
        *)
            deploy_frontend
            deploy_backend
            
            if [ "$ENVIRONMENT" = "production" ] && command -v docker &> /dev/null; then
                echo "🐳 Docker available - you can also run: ./deploy.sh $ENVIRONMENT docker"
            fi
            ;;
    esac
    
    echo ""
    echo "🎉 Deployment completed!"
    echo ""
    echo "📋 Next steps:"
    
    if [ "$ENVIRONMENT" = "development" ]; then
        echo "   1. Edit .env with your Reddit and OpenAI API keys"
        echo "   2. Start frontend: cd frontend && npm run dev"
        echo "   3. Test analysis: cd python-prototypes && python analyze_romantsy.py"
        echo "   4. Visit http://localhost:5173"
    else
        echo "   1. Verify .env contains production API keys"
        echo "   2. Set up domain and SSL certificates"
        echo "   3. Configure monitoring and backups"
        echo "   4. Test the production deployment"
    fi
    
    echo ""
    echo "📚 Documentation: See README.md and CLAUDE.md for detailed instructions"
}

# Run main function
main "$@"