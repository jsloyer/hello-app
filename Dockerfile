FROM python:3.7-alpine
COPY hello_world.py /app
WORKDIR /app

EXPOSE 8080

CMD ["python", "/app/hello_world.py"]

