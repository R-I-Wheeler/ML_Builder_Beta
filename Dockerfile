FROM python:3.9-slim

WORKDIR /app

COPY . .

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libgomp1 \
    libmagic-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip

RUN pip install --prefer-binary osqp

RUN pip install --no-cache-dir -r ml_builder/requirements.txt

EXPOSE 8501

HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health

ENTRYPOINT ["streamlit", "run", "ml_builder/app.py", "--server.port=8501"]
