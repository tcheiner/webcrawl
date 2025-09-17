# Social Media Analyzer

## Project Overview
Building a web crawler and analytics tool to analyze romantsy/BookTok content from social media platforms (Reddit, TikTok) to identify trending terms, themes, and market opportunities for brand development.

## Architecture

### Current Production Architecture (Python + TypeScript)
- **Python Backend**: Complete analysis pipeline with Reddit API, NLP processing, and market insights generation
- **SvelteKit Frontend**: Full-stack TypeScript web application with API routes, PDF generation, and interactive UI
- **Data Processing**: Advanced semantic analysis with caching, visualization, and comprehensive reporting

### Planned Rust Integration (Performance Enhancement)
- **Rust Core Engine**: Future high-performance data processing optimization (currently dormant)
- **Hybrid Approach**: Incremental Rust adoption for CPU-intensive operations while maintaining Python orchestration

### Directory Structure
```
webcrawl/
├── rust-engine/           # Core Rust application
│   ├── src/
│   │   ├── main.rs       # Entry point & web server (Axum)
│   │   ├── collectors/   # Reddit/TikTok API clients
│   │   ├── processors/   # Text analysis & NLP engine
│   │   ├── storage/      # Database layer (SQLx + PostgreSQL)
│   │   └── api/          # REST endpoints for frontend
│   └── Cargo.toml
├── python-prototypes/     # Quick experimentation
│   ├── reddit_test.py    # Reddit API exploration
│   ├── nlp_experiments.py # Text processing tests
│   └── requirements.txt
├── data/                  # Raw & processed datasets
└── frontend/             # Web UI dashboard
    ├── src/
    │   ├── components/   # UI components
    │   ├── pages/        # Dashboard pages
    │   └── utils/        # Frontend utilities
    ├── package.json
    └── index.html
```

## Tech Stack

### Rust Dependencies
```toml
tokio = "1.0"           # Async runtime
axum = "0.7"            # Web framework  
reqwest = "0.11"        # HTTP client for APIs
serde = "1.0"           # JSON serialization
sqlx = "0.7"            # Database ORM
candle-core = "0.3"     # ML/NLP processing
clap = "4.0"            # CLI interface
```

### Python Stack
- `praw` - Reddit API client
- `nltk/spacy` - NLP processing
- `pandas` - Data manipulation
- `matplotlib/plotly` - Visualization

### Frontend Stack
- **Framework**: Svelte/SvelteKit (lightweight, fast)
- **Styling**: TailwindCSS + DaisyUI components
- **Charts**: Chart.js / D3.js for data visualization
- **HTTP Client**: Fetch API to Rust backend
- **Build**: Vite for fast development

## Key Components

### 1. Data Collectors
- **Reddit API Client**: Focus on r/RomanceBooks, r/BookTok, r/Fantasy
- **Rate Limiting**: Respect API limits and ToS
- **Data Models**: Posts, comments, metadata

### 2. Enhanced Text Processing Pipeline
- **Stop Words Filtering**: Remove fluff words ("the", "a", social media noise)
- **Domain-Specific Terms**: Configurable keywords for any industry
- **Advanced N-gram Analysis**: Multi-word phrases, collocations, brand-worthy terms
- **Semantic Phrase Extraction**: Pattern-based trending phrase detection
- **Sentiment Analysis**: Emotional impact scoring
- **Brand Scoring Algorithm**: Ranks terms by marketing/SEO potential

### 3. Analytics Engine
- **Word Frequency Analysis**: Most common terms by subreddit/platform
- **Relationship Graphs**: Word associations and co-occurrence
- **Trend Detection**: Rising/declining terms over time
- **Market Insights**: Product gaps, naming opportunities

### 4. Web UI Dashboard
- **Home**: Project overview and quick stats
- **Data Collection**: Configure Reddit/TikTok sources
- **Analytics**: Interactive charts and word clouds
- **Insights**: Market opportunities and brand suggestions
- **N-gram Tester**: Interactive testing interface for any domain
- **Settings**: API keys, filtering preferences

## Data Flow Architecture

### Reddit Data → Text Processing Integration

The system uses a coordinated pipeline where `reddit_client.py` and `text_processor.py` are integrated through `analyze_romantsy.py`:

```
reddit_client.py → pandas DataFrame → text_processor.py → Analysis Results
      ↓                    ↓                   ↓                  ↓
1. Collect Posts    2. Structured Data   3. Text Analysis   4. Market Insights
   - r/RomanceBooks    - title            - Extract keywords    - Word frequencies  
   - r/Fantasy         - selftext         - Remove stop words   - Sentiment analysis
   - r/BookTok         - created_datetime - Preserve romantsy   - Co-occurrences
   - Filter BookTok    - score/comments   - Multi-word phrases  - Brand opportunities
   - Add timestamps    - Save to CSV      - Generate word cloud - Visualizations
```

### Integration Points

**1. Data Collection (`reddit_client.py`)**
```python
# Collects posts into structured DataFrame
df = collector.collect_all_subreddits(posts_per_subreddit)
# Columns: title, selftext, created_datetime, score, subreddit, is_booktok_related
```

**2. Text Processing (`text_processor.py`)**
```python
# Processes the collected Reddit DataFrame
analysis_results = processor.analyze_posts_dataframe(df)
# Combines title + selftext for comprehensive text analysis
```

**3. Analysis Pipeline (`analyze_romantsy.py`)**
```python
class SearchTermAnalyzer:
    def __init__(self):
        self.collector = RedditCollector()      # Data collection
        self.processor = NLPTextProcessor()  # Text analysis
    
    def full_analysis(self):
        # Step 1: Collect Reddit data
        df = self.collector.collect_all_subreddits()
        
        # Step 2: Process text content  
        analysis_results = self.processor.analyze_posts_dataframe(df)
        
        # Step 3: Generate market insights
        insights = self.generate_market_insights(df, analysis_results)
        
        # Step 4: Create visualizations
        self.create_visualizations(df, analysis_results)
```

### Data Processing Flow

**Input**: Raw Reddit posts (JSON from API)
**Stage 1**: Structured data collection
- Clean and normalize post data
- Add datetime formatting (YYYY-MM-DD HH:MM:SS)
- Flag BookTok-related content
- Store in pandas DataFrame

**Stage 2**: Text analysis processing  
- Combine title + selftext for analysis
- Apply configurable stop word filtering
- Preserve romantsy-specific keywords
- Extract multi-word phrases ("enemies to lovers")
- Calculate sentiment scores

**Stage 3**: Market insights generation
- Word frequency analysis by subreddit
- Co-occurrence mapping for relationship graphs
- Trend detection and sentiment analysis
- Brand naming opportunity identification

**Output**: Comprehensive analysis results
- CSV files with raw data and timestamps
- JSON files with analysis results and insights
- PNG visualizations (charts and word clouds)
- Market research recommendations

## Target Analysis Areas
- **Genre Keywords**: romantsy, BookTok, spicy reads
- **Character Archetypes**: alpha, morally gray, book boyfriend
- **Tropes**: enemies to lovers, grumpy sunshine, one bed
- **Emotional Descriptors**: swoon, angst, steamy
- **Community Language**: What resonates with readers

## Development Approach
1. **Python Prototyping**: Quick API testing and data exploration
2. **Rust Implementation**: Production-ready core engine
3. **Iterative Refinement**: Based on real data insights
4. **Frontend Integration**: Dashboard for business insights

## Enhanced Semantic Analysis Implementation Strategy

### Phase 1: Enhanced N-gram Analysis (COMPLETED ✅)
- **Enhanced Text Preprocessing Pipeline**: Domain-agnostic preprocessing with configurable stop words
- **N-gram Analysis Engine**: Bigram/trigram extraction with frequency filtering
- **Pattern-Based Phrase Detection**: Regex patterns for trending phrase identification
- **Brand-Worthy Term Scoring**: Algorithmic scoring for marketing potential
- **Frontend Testing Interface**: Interactive domain testing with sample text loading
- **API Integration**: Python backend processing with JSON API endpoints

### Phase 2: Advanced Semantic Analysis (COMPLETED ✅)

**1. Enhanced Text Preprocessing Pipeline**
- ✅ Preserve important multi-word phrases before tokenization
- ✅ Context-aware stop word removal (keep domain-specific terms)
- ✅ Lemmatization with domain-specific exceptions
- ✅ Domain-specific abbreviation handling (MMC, FMC, HEA, etc.)

**2. Named Entity Recognition**
- ✅ Custom NER with spaCy integration and fallback patterns
- ✅ Extract: character archetypes, trope names, genres
- ✅ Romance/BookTok specific entity classification
- ✅ Pattern-based entity extraction for domain terms

**3. Semantic Clustering**
- ✅ Group synonymous terms/phrases automatically using K-means
- ✅ Identify emerging vs established trends through clustering
- ✅ Map brand-worthy term families and relationships
- ✅ Content theme identification for marketing strategy

**4. Enhanced TF-IDF Analysis**
- ✅ Weight terms by domain-specificity scoring with bonuses
- ✅ Identify unique-to-community language patterns
- ✅ Enhanced "brandability" scoring algorithms
- ✅ Separate domain-specific vs general high-value terms

**5. Integrated Market Insights Generation**
- ✅ Multi-source trending term aggregation
- ✅ Enhanced brand naming suggestions from semantic analysis
- ✅ Market entity analysis (tropes, archetypes, genres)
- ✅ Content theme strategy recommendations
- ✅ Emerging trend and opportunity identification

**6. Topic Modeling Stack** (FUTURE ENHANCEMENT 🔮)
- ⏳ BERTopic for automatic trend discovery
- ⏳ LDA for broader theme analysis  
- ⏳ Track topic evolution over time periods

### Phase 3: User Journey Analysis (COMPLETED ✅)

**1. Language Sophistication Scoring**
- ✅ Newbie indicator detection: Help-seeking patterns, basic descriptors, genre confusion
- ✅ Expert indicator identification: Advanced tropes, character analysis, industry knowledge
- ✅ Community abbreviation recognition: MMC, FMC, HEA, DNF, TBR, etc.
- ✅ Engagement sophistication analysis: Simple ratings vs detailed reviews

**2. Journey Stage Classification**
- ✅ Sophistication scoring (0-1 scale): Expert vs newbie language ratio
- ✅ Three-stage classification: Newbie (0-0.3), Intermediate (0.3-0.7), Expert (0.7-1.0)
- ✅ Dynamic stage assignment based on vocabulary patterns

**3. Community Intelligence Analysis**
- ✅ Temporal evolution tracking: How sophistication changes over time
- ✅ Subreddit expertise mapping: Beginner-friendly vs expert communities
- ✅ Engagement pattern analysis: Correlation between expertise and community response
- ✅ Vocabulary evolution by stage: Unique terminology for each reader level

**4. Market Strategy Insights**
- ✅ Community composition analysis: Percentage breakdown of reader stages
- ✅ Content targeting recommendations: Beginner guides vs expert discussions
- ✅ Platform positioning strategy: Where to focus different types of content
- ✅ Expert vocabulary opportunity identification: Terms for advanced marketing

**Implementation Details:**
```python
class UserJourneyAnalyzer:
    # Newbie indicators: "help me find", "need recommendations", basic descriptors
    # Expert indicators: "enemies to lovers", "morally gray", "dual POV", "ARC"
    # Engagement patterns: Simple ratings vs detailed character analysis
    # Market insights: Community composition and content strategy recommendations
```

### Phase 4: Multi-Modal Analysis (FUTURE 🔮)
- ⏳ Image/video content analysis for visual trends
- ⏳ Cross-platform data integration (TikTok, Instagram)
- ⏳ Real-time trend monitoring and alerts

## Current Status
- ✅ Complete project architecture with hybrid approach
- ✅ **Python Reddit API client with intelligent caching system**
- ✅ Advanced NLP text processor with theme-based customization
- ✅ **Enhanced N-gram Analyzer (Phase 1) with domain-agnostic testing interface**
- ✅ **Advanced Semantic Analyzer (Phase 2) with NER, clustering, and enhanced TF-IDF**
- ✅ **Integrated multi-phase analysis pipeline with comprehensive market insights**
- ✅ **Brand-worthy term extraction and enhanced brand suggestion algorithms**
- ✅ **Interactive frontend testing for any domain/industry**
- ✅ **User Journey Analysis - Track reader evolution from newbie to expert**
- ✅ SvelteKit frontend with AI-powered configuration
- ✅ OpenAI integration for theme analysis and suggestions
- ✅ Full datetime support for posts and comments
- ✅ Comprehensive settings management with localStorage
- ✅ Theme-based workflow for generating all configurations
- ⏳ Rust production backend (future enhancement)
- ✅ **Production-ready with Phase 1 & 2 semantic analysis complete**
- ✅ **Data persistence with settings tracking and PDF generation**

## Data Persistence & Traceability System

### Analysis Output Structure
Each analysis run creates timestamped files ensuring perfect traceability:

```
data/
├── analysis_results_YYYYMMDD_HHMMSS.json    # Complete analysis results with market insights
├── analysis_settings_YYYYMMDD_HHMMSS.json   # Exact settings used for this specific run
├── reddit_analysis_YYYYMMDD_HHMMSS.csv      # Raw Reddit data with metadata
├── romantsy_analysis_YYYYMMDD_HHMMSS.png    # Statistical visualizations
├── wordcloud_YYYYMMDD_HHMMSS.png            # Word cloud visualization
└── reports/
    └── market-analysis-YYYYMMDD_HHMMSS.pdf  # Generated PDF report
```

### Settings Tracking Implementation

The `analyze_searchterms.py` script saves comprehensive settings data:

```python
# Settings saved with each analysis run
settings_data = {
    'timestamp': timestamp,
    'target_subreddits': self.config.get('target_subreddits', []),
    'booktok_terms': self.config.get('booktok_terms', []),
    'custom_keywords': self.config.get('custom_keywords', []),
    'custom_stop_words': self.config.get('custom_stop_words', []),
    'posts_per_subreddit': self.config.get('posts_per_subreddit', 50),
    'time_filter': self.config.get('time_filter', 'week'),
    'search_description': self.config.get('search_description', ''),
    'analysis_type': 'full_semantic_analysis'
}
```

### PDF Generation with Real Data

The PDF generator (`/api/generate-pdf/server.ts`) now:

1. **Reads latest analysis results** from `analysis_results_*.json`
2. **Loads matching settings** from `analysis_settings_*.json` with same timestamp
3. **Maps data structure correctly**:
   - `text_analysis.word_frequencies` → Top 100 trending terms
   - `market_insights.opportunities` → Brand opportunities
   - Analysis settings → Configuration section showing exact parameters used
4. **Displays real insights** instead of mock data
5. **Shows exact traceability** - which settings produced which results

### Key Benefits

- **Perfect Audit Trail**: Every PDF shows exactly what settings were used
- **No Mock Data**: PDF displays actual analysis results and real trending terms
- **Settings Validation**: Can trace back any result to its exact configuration
- **Historical Analysis**: Compare different runs with different settings
- **Reproducible Results**: Re-run analysis with same settings file

This system eliminates the previous issue where PDFs showed placeholder data instead of actual analysis results, ensuring complete transparency and traceability.

## Deployment Guide

### Prerequisites
- Node.js 18+ and npm
- Python 3.8+
- Reddit API credentials
- OpenAI API key (for AI features)

### Local Development
```bash
# Frontend (SvelteKit)
cd frontend
npm install
npm run dev
# Runs on http://localhost:5173

# Python Analysis Backend
cd python-prototypes
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
pip install -r requirements.txt

# Configure API keys
cp .env.example .env
# Edit .env with Reddit and OpenAI API keys

# Run analysis
python analyze_searchterms.py
```

### Production Deployment

#### Option 1: Vercel (Frontend) + Python Scripts
```bash
# Deploy frontend to Vercel
cd frontend
npm run build
npx vercel --prod

# Run Python analysis on server/cron
python analyze_searchterms.py
```

#### Option 2: Docker Deployment
```dockerfile
# Create Dockerfile in root
FROM node:18-alpine AS frontend
WORKDIR /app/frontend
COPY frontend/package*.json ./
RUN npm ci
COPY frontend/ .
RUN npm run build

FROM python:3.11-slim AS backend
WORKDIR /app
COPY python-prototypes/requirements.txt ./
RUN pip install -r requirements.txt
COPY python-prototypes/ ./

FROM nginx:alpine
COPY --from=frontend /app/frontend/build /usr/share/nginx/html
COPY --from=backend /app /opt/romantsy
```

#### Option 3: Cloud Functions
- **Frontend**: Deploy to Netlify/Vercel
- **API Endpoints**: Deploy as serverless functions
- **Analysis**: Schedule as cloud functions (AWS Lambda, Google Cloud Functions)

### Environment Variables
```bash
# Frontend (.env)
PUBLIC_API_BASE_URL=https://your-api-domain.com

# Python Backend (.env)
REDDIT_CLIENT_ID=your_reddit_client_id
REDDIT_CLIENT_SECRET=your_reddit_client_secret  
REDDIT_USER_AGENT=SearchTermAnalyzer/1.0
OPENAI_API_KEY=sk-your-openai-key
```

### Data Storage
- **Development**: Local files in `data/` directory
- **Production**: 
  - AWS S3/Google Cloud Storage for analysis results
  - PostgreSQL/MongoDB for structured data
  - Redis for caching API responses

## Rust Integration Strategy

### Current Status: Python Production System
The project currently runs entirely on Python + TypeScript with no Rust implementation. The `rust-engine/` directory exists but contains only a basic "Hello, world!" program with dependency stubs.

**Why Rust wasn't needed**: Python prototypes became so complete and production-ready that the Rust engine was never required. Current Python system handles all operations at acceptable performance levels for current scale.

### Optimal Rust Integration Approaches

When performance optimization is needed, here are the recommended integration strategies:

#### **Phase 1: Low-Risk Polars Integration (Immediate 10x speedup)**
```python
# Replace pandas operations with Rust-powered Polars
import polars as pl

class NLPTextProcessor:
    def analyze_posts_dataframe(self, df_pandas):
        # Convert to Polars for fast processing
        df = pl.from_pandas(df_pandas)
        
        # 10-30x faster aggregations
        word_counts = df.with_columns([
            pl.col("combined_text").str.split(" ").alias("words")
        ]).explode("words").group_by("words").count()
        
        return word_counts.to_pandas()  # Convert back if needed
```

**Benefits**: Drop-in replacement for pandas, 5-30x performance improvement, minimal code changes
**Effort**: Low (1-2 days implementation)
**Risk**: Very low (mature library, good pandas compatibility)

#### **Phase 2: PyO3 Native Extensions (50-100x speedup for specific operations)**
```rust
// Fast keyword extraction in Rust
use pyo3::prelude::*;
use std::collections::HashMap;

#[pyfunction]
fn extract_trending_terms(texts: Vec<&str>, stop_words: Vec<&str>) -> PyResult<Vec<(String, u32)>> {
    let stop_set: std::collections::HashSet<&str> = stop_words.into_iter().collect();
    let mut word_counts = HashMap::new();
    
    for text in texts {
        for word in text.split_whitespace() {
            let clean_word = word.to_lowercase();
            if !stop_set.contains(clean_word.as_str()) {
                *word_counts.entry(clean_word).or_insert(0) += 1;
            }
        }
    }
    
    let mut sorted: Vec<_> = word_counts.into_iter().collect();
    sorted.sort_by(|a, b| b.1.cmp(&a.1));
    Ok(sorted)
}

#[pymodule]
fn nlp_accelerator(_py: Python, m: &PyModule) -> PyResult<()> {
    m.add_function(wrap_pyfunction!(extract_trending_terms, m)?)?;
    Ok(())
}
```

```python
# Python usage - seamless integration
import nlp_accelerator
trending = nlp_accelerator.extract_trending_terms(texts, stop_words)
```

**Benefits**: 50-100x speedup for CPU-intensive operations, native Python module integration
**Effort**: Medium (1-2 weeks for key functions)
**Risk**: Medium (compilation complexity, deployment considerations)

#### **Phase 3: Rust Microservice (Maximum performance + fault isolation)**
```rust
// High-performance analysis service
use axum::{Json, Router, routing::post};
use serde::{Deserialize, Serialize};

#[derive(Deserialize)]
struct BatchAnalysisRequest {
    posts: Vec<RedditPost>,
    config: AnalysisConfig,
}

#[derive(Serialize)]
struct AnalysisResults {
    trending_terms: Vec<(String, u32)>,
    sentiment_scores: Vec<f64>,
    market_insights: MarketInsights,
    processing_time_ms: u64,
}

async fn analyze_batch(Json(req): Json<BatchAnalysisRequest>) -> Json<AnalysisResults> {
    let start = std::time::Instant::now();
    
    // Parallel processing with rayon
    let results = analyze_posts_parallel(&req.posts, &req.config).await;
    
    Json(AnalysisResults {
        trending_terms: results.trending_terms,
        sentiment_scores: results.sentiment_scores,
        market_insights: results.market_insights,
        processing_time_ms: start.elapsed().as_millis() as u64,
    })
}

#[tokio::main]
async fn main() {
    let app = Router::new()
        .route("/analyze/batch", post(analyze_batch))
        .route("/health", get(|| async { "OK" }));
    
    axum::serve(tokio::net::TcpListener::bind("127.0.0.1:3001").await.unwrap(), app)
        .await.unwrap();
}
```

```python
# Python orchestration calls Rust service
import requests

def analyze_with_rust_service(posts, config):
    response = requests.post("http://localhost:3001/analyze/batch", json={
        "posts": posts,
        "config": config
    })
    return response.json()
```

**Benefits**: Maximum performance (100x+ speedup), fault isolation, independent scaling
**Effort**: High (2-4 weeks full implementation)
**Risk**: Medium-High (service management, network reliability, deployment complexity)

### Performance Comparison Matrix

| Operation | Python+pandas | Python+Polars | PyO3+Rust | Rust Service |
|-----------|---------------|---------------|-----------|--------------|
| CSV Processing | 1x (baseline) | 10x faster | 20x faster | 25x faster |
| Text Analysis | 1x (baseline) | 3x faster | 50x faster | 60x faster |
| Keyword Extraction | 1x (baseline) | 5x faster | 100x faster | 120x faster |
| N-gram Analysis | 1x (baseline) | 8x faster | 80x faster | 100x faster |
| Market Insights | 1x (baseline) | 2x faster | 10x faster | 15x faster |
| **Development Time** | 1x (baseline) | 1.2x longer | 3x longer | 5x longer |
| **Deployment Complexity** | 1x (baseline) | 1x same | 3x more complex | 4x more complex |
| **Memory Usage** | 1x (baseline) | 0.5x less | 0.3x less | 0.4x less |

### Integration Recommendation

**Current State**: Python system is production-ready and handles current scale effectively

**Recommended Approach**:
1. **Monitor performance** - Only optimize when bottlenecks are identified
2. **Start with Polars** - Easy 10x DataFrame speedup with minimal risk
3. **Add PyO3 selectively** - Target the most CPU-intensive functions (keyword extraction, sentiment analysis)
4. **Keep Python orchestration** - Maintain current architecture advantages
5. **Consider Rust service** - Only for real-time requirements or massive scale (100k+ posts/hour)

**Key Principle**: Optimize incrementally based on actual performance needs rather than premature optimization.

## Commands

### Frontend Development
- `npm run dev` - Start frontend development server (http://localhost:5173)
- `npm run build` - Build frontend for production
- `npm run preview` - Preview production build locally

### Python Analysis
- `python analyze_romantsy.py` - Run complete analysis pipeline with Phase 1 & 2 semantic analysis
  - **NEW**: Automatically saves `analysis_settings_*.json` and `analysis_results_*.json` for PDF traceability
  - Generates timestamped data files ensuring perfect audit trail
- `python reddit_client.py` - Test Reddit API connection with intelligent caching
- `python text_processor.py` - Test NLP processing
- `python enhanced_ngram_analyzer.py` - Test Phase 1 n-gram analysis standalone
- `python advanced_semantic_analyzer.py` - Test Phase 2 advanced semantic analysis standalone
- `python ngram_api_handler.py` - API handler for frontend n-gram testing
- `python test_caching.py` - Test intelligent caching system

### N-gram Testing Interface
- Navigate to `/ngram-test` in the frontend
- Load sample texts for different domains (Marketing, Tech, Health, etc.)
- Configure domain keywords and stop words
- Run analysis to extract trending phrases, bigrams, trigrams, and brand-worthy terms

## System Limitations & Blind Spots

### Data Collection Biases

**1. Platform Limitations**
- **Reddit-Only**: Missing TikTok, Instagram, Twitter, Goodreads data
- **English-Only**: No international romance communities
- **Subreddit Selection Bias**: Only 7 pre-selected subreddits
- **Temporal Bias**: Only captures recent posts (week/month timeframes)

**2. Sampling Issues**
- **Top Posts Bias**: Uses `subreddit.top()` - misses rising/new content
- **Volume Limitations**: 50-500 posts per subreddit (tiny sample)
- **Time Zone Bias**: Analysis timing affects which posts are captured
- **Weekend vs Weekday**: Different user behavior patterns not accounted for

**3. User Demographics Missing**
- **Age Groups**: No distinction between Gen Z, Millennial, Gen X preferences
- **Geographic Location**: US vs UK vs international terminology differences
- **Reading Experience**: New readers vs seasoned romance fans
- **Economic Status**: Indie vs traditional publishing preferences

### Text Processing Flaws

**4. Language Analysis Gaps**
- **Context Loss**: Multi-word phrases may lose meaning when tokenized
- **Sarcasm/Irony**: Sentiment analysis fails on sarcastic BookTok posts
- **Abbreviations**: "MMC" (male main character), "FMC", "HEA" not fully captured
- **Emoji Analysis**: Missing emotional context from 📚❤️🔥 usage patterns
- **Slang Evolution**: BookTok language changes faster than keyword lists

**5. Content Type Biases**
- **Text vs Visual**: Missing BookTok video captions, visual trends
- **Long vs Short Posts**: Reddit comments vs TikTok-style brevity
- **Formal vs Casual**: Academic book discussions vs casual recommendations
- **Review vs Discussion**: Different language patterns not distinguished

### Market Research Blind Spots

**6. Commercial Context Missing**
- **Price Sensitivity**: No data on free vs paid book preferences
- **Publishing Format**: Ebook vs audiobook vs physical book trends
- **Author Demographics**: Indie vs trad-published author reception
- **Release Timing**: Seasonal trends, new release hype patterns

**7. Competitive Intelligence Gaps**
- **Existing Brand Performance**: No analysis of current successful brands
- **Market Saturation**: Don't know if niches are over/under-served
- **Cross-Platform Trends**: TikTok trends may not match Reddit discussions
- **Influencer Impact**: Missing key BookTok creator preferences

**8. Behavioral Analysis Missing**
- **Purchase Intent**: Discussions don't equal buying behavior
- **Re-read Patterns**: One-time vs repeat engagement
- **Series vs Standalone**: Different marketing approaches needed
- **Trigger Warnings**: Important for romance marketing but inconsistently captured

### Technical & Methodological Issues

**9. Data Quality Problems**
- **Deleted Content**: [removed] and [deleted] posts create gaps
- **Sock Puppets**: Fake accounts gaming discussions
- **Astroturfing**: Publishers promoting their own books artificially
- **Seasonal Variations**: Holiday reading patterns not considered

**10. Recommendation Algorithm Bias**
- **Reddit Algorithm**: Hot/top posts influenced by Reddit's recommendation engine
- **Echo Chambers**: Same users dominating multiple subreddits
- **Moderation Bias**: Removed content may represent important trends
- **Self-Selection**: Only captures users who publicly discuss books

### Accuracy Impact Assessment

**High Impact Flaws:**
1. **Platform limitation** - Missing 70%+ of BookTok content
2. **Sample size** - Too small for statistical significance
3. **Temporal bias** - Trends change weekly in BookTok

**Medium Impact Flaws:**
4. **Demographics** - Age/location affects terminology usage
5. **Commercial context** - Purchase behavior vs discussion behavior
6. **Content type bias** - Visual content drives BookTok trends

**Mitigation Strategies:**
- **Multi-platform integration**: Add TikTok Research API, Instagram hashtag analysis
- **Longitudinal studies**: Collect data over 3-6 month periods
- **User segmentation**: Analyze by subreddit demographics
- **Commercial data**: Integrate with book sales APIs (Goodreads, Amazon)
- **Visual analysis**: OCR on BookTok videos, image trend analysis
- **Validation studies**: Compare predictions with actual market performance

## Advanced Analytics Roadmap

### Phase 3: Community Intelligence (TODO 🔮)

**Cross-Platform Trend Prediction** (Future Enhancement)
- **Reddit → TikTok Pipeline**: Track early Reddit buzz that becomes viral TikTok trends
- **Language Migration Patterns**: How terminology spreads across platforms
- **Timing Analysis**: Lead time between Reddit discussion and mainstream adoption
- **Platform-Specific Adaptation**: How content changes when moving between platforms

**Implementation Strategy:**
```python
class CrossPlatformPredictor:
    def identify_viral_potential(self, reddit_posts):
        # Analyze engagement velocity, comment sentiment, cross-posting patterns
        # Score posts for TikTok viral probability
        pass
        
    def track_language_evolution(self, historical_data):
        # Monitor how new terms spread from niche → mainstream
        # Predict terminology adoption timelines
        pass
```

**Data Sources to Add:**
- TikTok Research API for hashtag tracking
- Instagram hashtag analysis
- Goodreads review sentiment correlation
- Amazon book sales data integration
- Author social media engagement metrics

## Notes for Claude Code
- This is a market research tool for romance/fantasy book industry
- Focus on ethical API usage and respect platform ToS
- Performance matters for large-scale text processing
- **Critical**: Validate findings against actual market data and sales metrics
- Document significant architectural changes here

  ---
  Phase 1: Setup Services (30 minutes)

  Step 1: Create Supabase Project

    1. Go to https://supabase.com → "Start your project"
    2. Create new project:
    - Name: market-analyzer
    - Password: Generate strong password
    - Region: Choose closest to you
    3. Wait 2-3 minutes for provisioning
    4. Get your credentials (save these):
       SUPABASE_URL=https://your-project.supabase.co
       SUPABASE_ANON_KEY=eyJ0eXAiOiJKV1QiLCJhbGci...
       SUPABASE_SERVICE_KEY=eyJ0eXAiOiJKV1QiLCJhbGci...

  Step 2: Create Railway Account

    1. Go to https://railway.app → Sign up with GitHub
    2. Connect your GitHub account
    3. You get $5 free credit to start

  ---
  Phase 2: Database Setup (45 minutes)

  Step 3: Create Database Schema

  In Supabase dashboard → SQL Editor → New query:

  -- Main analysis runs
  CREATE TABLE analyses (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  settings JSONB NOT NULL,
  metadata JSONB,
  status TEXT DEFAULT 'running',
  error_message TEXT
  );

  -- Word frequencies
  CREATE TABLE keywords (
  analysis_id UUID REFERENCES analyses(id) ON DELETE CASCADE,
  word TEXT NOT NULL,
  frequency INTEGER NOT NULL,
  tf_idf_score FLOAT,
  category TEXT DEFAULT 'general',
  PRIMARY KEY (analysis_id, word)
  );

  -- Reddit posts
  CREATE TABLE reddit_posts (
  id TEXT NOT NULL,
  analysis_id UUID REFERENCES analyses(id) ON DELETE CASCADE,
  subreddit TEXT NOT NULL,
  title TEXT NOT NULL,
  content TEXT,
  created_at TIMESTAMPTZ NOT NULL,
  score INTEGER DEFAULT 0,
  num_comments INTEGER DEFAULT 0,
  is_booktok_related BOOLEAN DEFAULT false,
  PRIMARY KEY (analysis_id, id)
  );

  -- Seasonality data
  CREATE TABLE seasonality_stats (
  analysis_id UUID REFERENCES analyses(id) ON DELETE CASCADE,
  season TEXT NOT NULL,
  post_count INTEGER NOT NULL,
  avg_engagement FLOAT DEFAULT 0,
  themes JSONB DEFAULT '{}',
  PRIMARY KEY (analysis_id, season)
  );

  -- File storage references
  CREATE TABLE analysis_files (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  analysis_id UUID REFERENCES analyses(id) ON DELETE CASCADE,
  file_type TEXT NOT NULL, -- 'wordcloud', 'pdf', 'chart'
  file_name TEXT NOT NULL,
  file_url TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
  );

  -- Indexes for performance
  CREATE INDEX idx_analyses_created_at ON analyses(created_at DESC);
  CREATE INDEX idx_keywords_frequency ON keywords(frequency DESC);
  CREATE INDEX idx_reddit_posts_subreddit ON reddit_posts(subreddit);
  CREATE INDEX idx_reddit_posts_created_at ON reddit_posts(created_at DESC);

  Click "Run" to execute.

  Step 4: Setup File Storage

    1. In Supabase → Storage → "Create Bucket"
    2. Bucket name: analysis-files
    3. Public: Yes (so files can be accessed via URL)
    4. Create these folders in the bucket:
    - wordclouds/
    - pdfs/
    - charts/

  ---
  Phase 3: Backend Setup (1-2 hours)

  Step 5: Create FastAPI Backend

  Create new directory structure:
  webcrawl/
  ├── backend/           # New FastAPI service
  │   ├── main.py
  │   ├── requirements.txt
  │   ├── database.py
  │   ├── models.py
  │   └── analysis/      # Your existing Python files
  │       ├── analyze_searchterms.py
  │       ├── reddit_client.py
  │       └── ... (copy all existing .py files)
  └── frontend/          # Existing SvelteKit app

  backend/requirements.txt:
  fastapi==0.104.1
  uvicorn[standard]==0.24.0
  supabase==1.2.0
  python-dotenv==1.0.0
  redis==5.0.1
  pandas==2.1.3
  matplotlib==3.8.2
  seaborn==0.13.0
  nltk==3.8.1
  praw==7.7.1
  scikit-learn==1.3.2
  wordcloud==1.9.2

  backend/main.py:
  from fastapi import FastAPI, BackgroundTasks, HTTPException
  from fastapi.middleware.cors import CORSMiddleware
  import os
  from dotenv import load_dotenv
  import uuid
  import json
  from supabase import create_client, Client
  from typing import Dict, Any
  import sys

  # Add analysis directory to path
  sys.path.append('./analysis')
  from analyze_searchterms import SearchTermAnalyzer

  load_dotenv()

  app = FastAPI(title="Market Analyzer API")

  # CORS for frontend
  app.add_middleware(
  CORSMiddleware,
  allow_origins=["http://localhost:5173", "https://your-frontend.vercel.app"],
  allow_credentials=True,
  allow_methods=["*"],
  allow_headers=["*"],
  )

  # Supabase client
  supabase: Client = create_client(
  os.getenv("SUPABASE_URL"),
  os.getenv("SUPABASE_SERVICE_KEY")
  )

  @app.get("/")
  async def root():
  return {"message": "Market Analyzer API is running"}

  @app.get("/health")
  async def health_check():
  return {"status": "healthy", "service": "market-analyzer-api"}

  @app.post("/api/analysis/start")
  async def start_analysis(config: Dict[Any, Any], background_tasks: BackgroundTasks):
  """Start a new analysis job"""
  try:
  # Create analysis record
  analysis_data = {
  "settings": config,
  "status": "queued"
  }

          result = supabase.table("analyses").insert(analysis_data).execute()
          analysis_id = result.data[0]["id"]

          # Start background job
          background_tasks.add_task(run_analysis_job, analysis_id, config)

          return {
              "analysis_id": analysis_id,
              "status": "queued",
              "message": "Analysis started. Use the analysis_id to check progress."
          }

      except Exception as e:
          raise HTTPException(status_code=500, detail=f"Failed to start analysis: {str(e)}")

  @app.get("/api/analysis/{analysis_id}/status")
  async def get_analysis_status(analysis_id: str):
  """Check analysis progress"""
  try:
  result = supabase.table("analyses").select("*").eq("id", analysis_id).execute()

          if not result.data:
              raise HTTPException(status_code=404, detail="Analysis not found")

          analysis = result.data[0]
          return {
              "analysis_id": analysis_id,
              "status": analysis["status"],
              "created_at": analysis["created_at"],
              "error_message": analysis.get("error_message")
          }

      except Exception as e:
          raise HTTPException(status_code=500, detail=str(e))

  @app.get("/api/analysis/{analysis_id}/results")
  async def get_analysis_results(analysis_id: str):
  """Get completed analysis results"""
  try:
  # Check if analysis exists and is complete
  analysis_result = supabase.table("analyses").select("*").eq("id", analysis_id).execute()

          if not analysis_result.data:
              raise HTTPException(status_code=404, detail="Analysis not found")

          analysis = analysis_result.data[0]

          if analysis["status"] != "completed":
              return {"status": analysis["status"], "message": "Analysis not yet complete"}

          # Get all related data
          keywords_result = supabase.table("keywords").select("*").eq("analysis_id", analysis_id).order("frequency", desc=True).execute()
          seasonality_result = supabase.table("seasonality_stats").select("*").eq("analysis_id", analysis_id).execute()
          files_result = supabase.table("analysis_files").select("*").eq("analysis_id", analysis_id).execute()

          return {
              "analysis": analysis,
              "keywords": keywords_result.data,
              "seasonality": seasonality_result.data,
              "files": files_result.data
          }

      except Exception as e:
          raise HTTPException(status_code=500, detail=str(e))

  async def run_analysis_job(analysis_id: str, config: Dict[Any, Any]):
  """Background job to run the analysis"""
  try:
  # Update status to running
  supabase.table("analyses").update({"status": "running"}).eq("id", analysis_id).execute()

          # Run your existing analysis (mostly unchanged)
          analyzer = SearchTermAnalyzer(config)

          # Step 1: Collect data
          df = analyzer.collector.collect_all_subreddits(
              posts_per_sub=config.get('posts_per_subreddit', 50),
              time_filter=config.get('time_filter', 'week')
          )

          # Save raw posts to database
          posts_data = []
          for _, row in df.iterrows():
              posts_data.append({
                  "id": row["id"],
                  "analysis_id": analysis_id,
                  "subreddit": row["subreddit"],
                  "title": row["title"],
                  "content": row.get("selftext", ""),
                  "created_at": row["created_datetime"].isoformat(),
                  "score": row["score"],
                  "num_comments": row.get("num_comments", 0),
                  "is_booktok_related": row.get("is_booktok_related", False)
              })

          # Insert posts in batches (Supabase has limits)
          batch_size = 1000
          for i in range(0, len(posts_data), batch_size):
              batch = posts_data[i:i + batch_size]
              supabase.table("reddit_posts").insert(batch).execute()

          # Step 2: Process text and get results
          results = analyzer.processor.analyze_posts_dataframe(df)

          # Save keywords to database
          if hasattr(results, 'word_frequencies') and results.word_frequencies:
              keywords_data = []
              for word, freq in results.word_frequencies[:1000]:  # Top 1000 words
                  keywords_data.append({
                      "analysis_id": analysis_id,
                      "word": word,
                      "frequency": int(freq),
                      "category": "general"  # You can enhance this later
                  })

              # Insert keywords in batches
              for i in range(0, len(keywords_data), batch_size):
                  batch = keywords_data[i:i + batch_size]
                  supabase.table("keywords").insert(batch).execute()

          # Step 3: Save analysis metadata
          metadata = {
              "total_posts": len(df),
              "subreddits_analyzed": df["subreddit"].unique().tolist(),
              "date_range": {
                  "earliest": df["created_datetime"].min().isoformat(),
                  "latest": df["created_datetime"].max().isoformat()
              }
          }

          # Mark as completed
          supabase.table("analyses").update({
              "status": "completed",
              "metadata": metadata
          }).eq("id", analysis_id).execute()

      except Exception as e:
          # Mark as failed
          supabase.table("analyses").update({
              "status": "failed",
              "error_message": str(e)
          }).eq("id", analysis_id).execute()
          print(f"Analysis failed: {e}")

  if __name__ == "__main__":
  import uvicorn
  uvicorn.run(app, host="0.0.0.0", port=8000)

  Step 6: Copy Your Analysis Files

  Copy all your existing Python files to backend/analysis/:
  cp python-prototypes/*.py backend/analysis/

  Update imports in copied files to work with the new structure.

  ---
  Phase 4: Deploy Backend (30 minutes)

  Step 7: Deploy to Railway

    1. Push backend to GitHub:
       cd backend
       git init
       git add .
       git commit -m "Initial backend setup"
       git remote add origin https://github.com/yourusername/market-analyzer-backend
       git push -u origin main
    2. Deploy on Railway:
    - Go to railway.app → "New Project" → "Deploy from GitHub repo"
    - Select your backend repo
    - Railway auto-detects Python and installs requirements.txt
    3. Set Environment Variables in Railway:
       SUPABASE_URL=https://your-project.supabase.co
       SUPABASE_SERVICE_KEY=eyJ0eXAiOiJKV1QiLCJhbGciOi...
       REDDIT_CLIENT_ID=your_reddit_client_id
       REDDIT_CLIENT_SECRET=your_reddit_client_secret
       REDDIT_USER_AGENT=MarketAnalyzer/1.0
    4. Get your Railway URL: https://your-backend-production-xxxx.up.railway.app

  ---
  Phase 5: Update Frontend (45 minutes)

  Step 8: Modify SvelteKit to Use New Backend

  Update your SvelteKit app to call the new API:

  frontend/src/routes/api/analysis/start/+server.ts:
  import { json } from '@sveltejs/kit';
  import { env } from '$env/dynamic/private';

  const BACKEND_URL = env.BACKEND_URL || 'http://localhost:8000';

  export async function POST({ request }) {
  try {
  const config = await request.json();

          const response = await fetch(`${BACKEND_URL}/api/analysis/start`, {
              method: 'POST',
              headers: {
                  'Content-Type': 'application/json',
              },
              body: JSON.stringify(config)
          });

          if (!response.ok) {
              throw new Error(`Backend error: ${response.statusText}`);
          }

          const result = await response.json();
          return json(result);

      } catch (error) {
          console.error('Error starting analysis:', error);
          return json({ error: 'Failed to start analysis' }, { status: 500 });
      }
  }

  frontend/src/routes/analysis/[analysisId]/+page.svelte:
  <script>
      import { onMount } from 'svelte';
      import { page } from '$app/stores';

      let status = 'loading';
      let analysis = null;
      let error = null;

      const analysisId = $page.params.analysisId;

      async function checkStatus() {
          try {
              const response = await fetch(`/api/analysis/${analysisId}/status`);
              const data = await response.json();

              status = data.status;

              if (status === 'completed') {
                  // Load full results
                  const resultsResponse = await fetch(`/api/analysis/${analysisId}/results`);
                  analysis = await resultsResponse.json();
              } else if (status === 'failed') {
                  error = data.error_message;
              }
          } catch (e) {
              error = e.message;
          }
      }

      onMount(() => {
          checkStatus();

          // Poll every 5 seconds if still running
          const interval = setInterval(() => {
              if (status === 'running' || status === 'queued') {
                  checkStatus();
              } else {
                  clearInterval(interval);
              }
          }, 5000);

          return () => clearInterval(interval);
      });
  </script>

  <div class="p-6">
      <h1 class="text-2xl font-bold mb-4">Analysis {analysisId.slice(0, 8)}...</h1>

      {#if status === 'loading'}
          <div>Loading analysis status...</div>
      {:else if status === 'queued'}
          <div class="alert alert-info">
              <span>Analysis is queued and will start shortly...</span>
          </div>
      {:else if status === 'running'}
          <div class="alert alert-warning">
              <span>Analysis is running... This may take 10-15 minutes.</span>
          </div>
          <div class="loading loading-spinner loading-lg"></div>
      {:else if status === 'completed' && analysis}
          <div class="alert alert-success mb-4">
              <span>Analysis completed successfully!</span>
          </div>

          <!-- Display results -->
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div class="card bg-base-100 shadow-xl">
                  <div class="card-body">
                      <h2 class="card-title">Top Keywords</h2>
                      <div class="overflow-x-auto">
                          <table class="table table-compact">
                              <thead>
                                  <tr><th>Word</th><th>Frequency</th></tr>
                              </thead>
                              <tbody>
                                  {#each analysis.keywords.slice(0, 20) as keyword}
                                      <tr>
                                          <td>{keyword.word}</td>
                                          <td>{keyword.frequency}</td>
                                      </tr>
                                  {/each}
                              </tbody>
                          </table>
                      </div>
                  </div>
              </div>

              <div class="card bg-base-100 shadow-xl">
                  <div class="card-body">
                      <h2 class="card-title">Analysis Summary</h2>
                      <div class="stats stats-vertical">
                          <div class="stat">
                              <div class="stat-title">Total Posts</div>
                              <div class="stat-value text-lg">{analysis.analysis.metadata?.total_posts || 0}</div>
                          </div>
                          <div class="stat">
                              <div class="stat-title">Keywords Found</div>
                              <div class="stat-value text-lg">{analysis.keywords?.length || 0}</div>
                          </div>
                      </div>
                  </div>
              </div>
          </div>

          <!-- Add more result sections as needed -->
      {:else if status === 'failed'}
          <div class="alert alert-error">
              <span>Analysis failed: {error}</span>
          </div>
      {/if}
  </div>

  ---
  Phase 6: Deploy Frontend (15 minutes)

  Step 9: Deploy to Vercel

    1. Set environment variable:
       BACKEND_URL=https://your-backend-production-xxxx.up.railway.app
    2. Deploy:
    - Push frontend changes to GitHub
    - Connect repo to Vercel
    - Set environment variable in Vercel dashboard
    - Deploy

  ---
  Testing & Verification

  Step 10: Test the Full Flow

    1. Visit your frontend: https://your-app.vercel.app
    2. Start an analysis with your existing settings
    3. Check the analysis page: /analysis/{analysis-id}
    4. Wait 10-15 minutes for completion
    5. Verify data in Supabase dashboard

  Expected costs after deployment:
    - Railway: $5-15/month (depending on usage)
    - Supabase: Free tier (should be plenty for 3 users)
    - Vercel: Free tier
    - Total: $5-15/month

  Next steps after this is working:
    - Add Redis for better job management
    - Implement file uploads (wordclouds, PDFs)
    - Add user authentication
    - Optimize performance

  Would you like me to help you with any specific step, or shall we start with Phase 1?