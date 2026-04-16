FROM python:3.9-slim
RUN apt-get update && apt-get install -y libmariadb-dev gcc
RUN pip install flask mariadb
COPY . /app
WORKDIR /app
CMD ["python", "app.py"]
