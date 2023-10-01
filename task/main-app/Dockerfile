FROM python:3.11.5-slim-bullseye

ENV APP_DIR=/app
ENV PYTHONPATH="${PYTHONPATH}:${APP_DIR}"

WORKDIR ${APP_DIR}

COPY requirements.txt .

RUN pip install --no-cache-dir --upgrade -r requirements.txt \
    && rm -rf /root/.cache
COPY ./app .

CMD ["python", "main.py", "--host", "0.0.0.0", "--port", "8000"]