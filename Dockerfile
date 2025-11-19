FROM python:3.9

# Set working directory
WORKDIR /app/backend

# Install OS-level dependencies for MySQL + Python
RUN apt-get update \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements
COPY requirements.txt /app/backend/

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install gunicorn explicitly
RUN pip install gunicorn mysqlclient

# Copy the project
COPY . /app/backend

# Expose Django port
EXPOSE 8000

# Default command is overridden by docker-compose
CMD ["gunicorn", "notesapp.wsgi:application", "--bind", "0.0.0.0:8000"]
