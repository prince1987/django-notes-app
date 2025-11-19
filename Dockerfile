FROM python:3.9

WORKDIR /app/backend

COPY requirements.txt /app/backend

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install app dependencies
RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

# Copy project
COPY . /app/backend

# Expose Django port
EXPOSE 8000

# Start Django server
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]

