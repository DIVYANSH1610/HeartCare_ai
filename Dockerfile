# ----------------------------
# Base Image
# ----------------------------
FROM python:3.10-slim

# ----------------------------
# Set working directory
# ----------------------------
WORKDIR /app

# ----------------------------
# Install system dependencies
# ----------------------------
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# ----------------------------
# Copy requirements first (for caching)
# ----------------------------
COPY requirements.txt .

# ----------------------------
# Install Python dependencies
# ----------------------------
RUN pip install --no-cache-dir -r requirements.txt

# ----------------------------
# Copy application files
# ----------------------------
COPY . .

# ----------------------------
# Expose Streamlit port
# ----------------------------
EXPOSE 8501

# ----------------------------
# Streamlit configuration (optional but recommended)
# ----------------------------
ENV STREAMLIT_SERVER_PORT=8501
ENV STREAMLIT_SERVER_ADDRESS=0.0.0.0
ENV STREAMLIT_BROWSER_GATHER_USAGE_STATS=false

# ----------------------------
# Run Streamlit app
# ----------------------------
CMD ["streamlit", "run", "main.py"]
