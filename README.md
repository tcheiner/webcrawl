# webcrawl
=======
# Romantsy Social Media Analyzer

A web crawler and analytics tool to analyze romantsy/BookTok content from social media platforms (Reddit, TikTok) to identify trending terms, themes, and market opportunities for brand development.

## Current Architecture (Production-Ready)

- **Python Backend**: Complete analysis pipeline with Reddit API, advanced NLP processing, and market insights generation
- **SvelteKit Frontend**: Full-stack TypeScript web application with API routes, PDF generation, and interactive UI  
- **Data Persistence**: Analysis results and settings tracking with comprehensive reporting
- **Rust Engine**: Future performance optimization (currently dormant)

## Project Setup

### 1. Basic Structure
```bash
mkdir webcrawl && cd webcrawl
mkdir python-prototypes data
```

### 2. Rust Engine
```bash
cargo init rust-engine --name romantsy-analyzer
```

### 3. Frontend (SvelteKit)
```bash
npx sv create frontend --template minimal --types ts --no-add-ons
cd frontend
npm install -D tailwindcss daisyui @tailwindcss/typography autoprefixer
npm install chart.js chartjs-adapter-date-fns date-fns
npx tailwindcss init -p
cd ..
```

### 4. Python Environment
```bash
cd python-prototypes
python -m venv venv
source venv/bin/activate  # or `venv\Scripts\activate` on Windows
pip install praw nltk spacy pandas matplotlib plotly requests
cd ..
```

### 5. Rust Dependencies
Edit `rust-engine/Cargo.toml` and add:
```toml
[dependencies]
tokio = { version = "1.0", features = ["full"] }
axum = "0.7"
reqwest = { version = "0.11", features = ["json"] }
serde = { version = "1.0", features = ["derive"] }
sqlx = { version = "0.7", features = ["runtime-tokio-rustls", "postgres"] }
clap = { version = "4.0", features = ["derive"] }
```

## Usage

### Testing Reddit Data Collection

1. **Get Reddit API credentials:**
   - Go to https://www.reddit.com/prefs/apps
   - Click "Create App" or "Create Another App"
   - Choose "script" type
   - Note your client ID and client secret

2. **Configure credentials:**
   ```bash
   cd python-prototypes
   cp .env.example .env
   # Edit .env with your Reddit API credentials
   ```

3. **Install Python dependencies:**
   ```bash
   python -m venv venv
   source venv/bin/activate  # or `venv\Scripts\activate` on Windows
   pip install -r requirements.txt
   ```

4. **Test Reddit API connection:**
   ```bash
   python reddit_client.py
   ```

5. **Run full romantsy analysis:**
   ```bash
   python analyze_searchterms.py
   ```

   This will:
   - Collect ~175 posts from 7 romance subreddits
   - Analyze text for romantsy keywords and sentiment
   - Generate market insights and brand suggestions
   - Create visualizations and word clouds
   - Save results to `../data/` directory
   - **NEW**: Save analysis settings for PDF traceability

## Data Persistence & PDF Generation

### Analysis Output Files

Each analysis run creates timestamped files in `/data/`:

```
data/
├── analysis_results_YYYYMMDD_HHMMSS.json    # Complete analysis results
├── analysis_settings_YYYYMMDD_HHMMSS.json   # Exact settings used for this run
├── reddit_analysis_YYYYMMDD_HHMMSS.csv      # Raw Reddit data
├── romantsy_analysis_YYYYMMDD_HHMMSS.png    # Analysis visualizations
├── wordcloud_YYYYMMDD_HHMMSS.png            # Word cloud visualization
└── reports/
    └── market-analysis-YYYYMMDD_HHMMSS.pdf  # Generated PDF report
```

### Settings Tracking

The `analysis_settings_*.json` file captures:
- **Target subreddits** used for data collection
- **BookTok keywords** for content identification  
- **Domain keywords** preserved during analysis
- **Stop words** filtered out
- **Analysis parameters** (posts per subreddit, time filter)
- **Search description** and analysis type

### PDF Report Generation

The PDF generator:
1. **Finds latest analysis** from `analysis_results_*.json`
2. **Loads matching settings** from `analysis_settings_*.json` 
3. **Maps data structure** (`text_analysis.word_frequencies` → trending terms)
4. **Shows exact parameters** used for that specific analysis run
5. **Displays real insights** from `market_insights.opportunities`

This ensures **perfect traceability** - each PDF shows exactly what settings produced those results.

## Testing the System

### 1. Test Frontend UI
```bash
cd frontend
npm run dev
```
Open http://localhost:5173 to see:
- ✅ Romantsy-themed dashboard with mock data
- ✅ Responsive sidebar navigation  
- ✅ Interactive charts (Chart.js)
- ✅ Market insight cards
- ✅ Stats with trend indicators

### 2. Test Python Reddit Analysis
```bash
cd python-prototypes

# Set up environment
python -m venv venv
source venv/bin/activate  # or `venv\Scripts\activate` on Windows
pip install -r requirements.txt

# Configure Reddit API (required)
cp .env.example .env
# Edit .env with your Reddit credentials from https://reddit.com/prefs/apps

# Test individual components
python reddit_client.py      # Test Reddit API connection
python text_processor.py     # Test NLP processing  
python analyze_searchterms.py   # Full analysis pipeline
```

### 3. Check Generated Data
After running analysis, check the `data/` directory:
```bash
ls ../data/
```
Expected files:
- `reddit_analysis_[timestamp].csv` - Raw collected posts
- `analysis_results_[timestamp].json` - Market insights & brand suggestions
- `romantsy_analysis_[timestamp].png` - Statistical charts
- `wordcloud_[timestamp].png` - Visual word frequency

### 4. Test Enhanced N-gram Analysis
Navigate to http://localhost:5173/ngram-test for interactive testing:

```bash
cd frontend
npm run dev
# Open http://localhost:5173/ngram-test
```

**Features:**
- 🎯 **Domain-Agnostic Testing**: Works for any industry (Marketing, Tech, Health, etc.)
- 📝 **Editable Sample Text**: No hardcoded data, fully customizable
- 🔍 **Multiple Analysis Types**: Bigrams, trigrams, trending phrases, brand-worthy terms
- ⚙️ **Configurable Settings**: Custom stop words, domain keywords, trending patterns
- 📊 **Real-time Results**: Interactive analysis with visual results

**Sample Domains:**
- Marketing/Business: customer engagement, digital marketing, analytics tools
- Technology: software development, cloud computing, API integration
- Health/Fitness: workout routines, nutrition research, fitness apps
- Content Creation: audience engagement, social media trends, monetization
- E-commerce: online shopping, customer service, payment methods

### 5. Analysis Output
The analysis will:
- 📊 Collect ~175 posts from 7 romance subreddits
- 🔍 Extract domain-specific keywords and multi-word phrases
- 📈 Generate word frequencies, n-grams, and sentiment analysis
- 💡 Identify market opportunities and brand naming suggestions
- 🏷️ Score terms by brand/marketing potential
- 📊 Create visualizations and export data

### Development
```bash
# Start frontend development server
cd frontend && npm run dev

# Start Rust backend (future)
cd rust-engine && cargo run

# Test Python components individually
cd python-prototypes && source venv/bin/activate
python reddit_client.py           # Reddit API testing
python text_processor.py          # NLP processing testing
python enhanced_ngram_analyzer.py # N-gram analysis testing
python ngram_api_handler.py        # API handler for frontend
python analyze_searchterms.py        # Complete analysis pipeline with n-grams
```

### Project Structure
```
webcrawl/
├── rust-engine/           # Core Rust application
├── frontend/             # SvelteKit web dashboard  
├── python-prototypes/    # API testing & experimentation
├── data/                # Raw & processed datasets
├── CLAUDE.md            # Architecture documentation
└── README.md           # This file
```

## Features

- **Reddit API Integration**: Analyze r/RomanceBooks, r/BookTok, r/Fantasy
- **Enhanced N-gram Analysis**: Advanced multi-word phrase extraction and trending term detection
- **Domain-Agnostic Testing**: Interactive interface for testing any industry or domain
- **Brand-Worthy Term Scoring**: Algorithmic ranking of terms by marketing potential
- **Text Processing**: NLP with stop word filtering and domain-specific terms
- **Data Visualization**: Interactive charts and word clouds
- **Market Insights**: Brand naming suggestions and trend analysis
- **Web Dashboard**: User-friendly interface for navigation and analysis

## Development Status

- ✅ Complete hybrid architecture (SvelteKit + Python + future Rust)
- ✅ AI-powered theme analysis with OpenAI integration
- ✅ Configurable Reddit API client with 7+ target subreddits
- ✅ Advanced NLP text processing with custom stop words/keywords
- ✅ **Enhanced N-gram Analysis System**: Multi-word phrase extraction, brand scoring, collocations
- ✅ **Interactive N-gram Testing Interface**: Domain-agnostic testing with sample text loading
- ✅ **Brand-Worthy Term Detection**: Algorithmic scoring for marketing potential
- ✅ Interactive web dashboard with comprehensive settings
- ✅ Market insights generator with brand naming suggestions
- ✅ Theme-based configuration workflow
- ✅ Full datetime support and data export capabilities
- ✅ Ready for production deployment

## Deployment Guide

### Prerequisites
- **Node.js 18+** and npm
- **Python 3.8+** with pip
- **Reddit API credentials** (get from [reddit.com/prefs/apps](https://reddit.com/prefs/apps))
- **OpenAI API key** (get from [platform.openai.com/api-keys](https://platform.openai.com/api-keys))

### Quick Deploy (Production Ready)

#### Option 1: Vercel + Server Deployment
```bash
# 1. Deploy Frontend to Vercel
cd frontend
npm install && npm run build
npx vercel --prod

# 2. Deploy Python Backend to your server
cd python-prototypes
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# 3. Configure environment
cp .env.example .env
# Edit .env with your API keys

# 4. Set up cron job for regular analysis
crontab -e
# Add: 0 6 * * * /path/to/venv/bin/python /path/to/analyze_searchterms.py
```

#### Option 2: Docker (All-in-One)
```bash
# Create production Docker setup
docker-compose up -d --build
```

#### Option 3: Cloud Functions (Serverless)
```bash
# Deploy frontend
vercel --prod

# Deploy Python analysis as scheduled cloud function
gcloud functions deploy romantsy-analysis --runtime python311 --trigger-topic daily-analysis
```

### Environment Setup

**Frontend Environment (.env):**
```bash
PUBLIC_API_BASE_URL=https://your-api-domain.com
OPENAI_API_KEY=sk-your-openai-key-here
```

**Python Backend (.env):**
```bash
REDDIT_CLIENT_ID=your_reddit_client_id
REDDIT_CLIENT_SECRET=your_reddit_client_secret
REDDIT_USER_AGENT=SearchTermAnalyzer/1.0 by YourUsername
OPENAI_API_KEY=sk-your-openai-key-here
```

### Key Features

✅ **AI-Powered Configuration**
- Single-click theme analysis (e.g., "Dark Academia Romance")
- Automatic generation of subreddits, keywords, and stop words
- OpenAI-powered market insights

✅ **Advanced Analytics**
- Sentiment analysis with romantsy-specific filtering
- Word frequency and co-occurrence analysis
- Trend detection and brand opportunities
- Interactive visualizations and word clouds

✅ **Comprehensive Data Export**
- CSV exports with full datetime information
- JSON analysis results with market insights
- PNG charts and word cloud visualizations

✅ **Flexible Configuration**
- Editable target subreddits and BookTok terms
- Customizable stop words and romantsy keywords
- Theme-based or manual configuration options

### Production Monitoring

```bash
# Check analysis logs
tail -f logs/romantsy_analysis.log

# Monitor data collection
python -c "
import pandas as pd
df = pd.read_csv('data/latest_analysis.csv')
print(f'Posts analyzed: {len(df)}')
print(f'Date range: {df.date.min()} to {df.date.max()}')
"
```

### Scaling for Production

**Data Storage:**
- Local development: CSV/JSON files
- Production: PostgreSQL + S3/GCS for bulk storage

**API Rate Limits:**
- Reddit: 60 requests/minute
- OpenAI: Varies by plan (monitor usage)

**Performance:**
- Frontend: CDN deployment (Vercel/Netlify)
- Analysis: Containerized Python with scheduling
- Future: Rust backend for high-performance processing

