FROM python:3.12-slim-bookworm
WORKDIR /app
COPY app.py test_app.py ./
RUN pip install --no-cache-dir flask pytest
EXPOSE 5000
CMD ["python", "app.py"]
