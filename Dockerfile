FROM python
COPY . /opt/app
WORKDIR /opt/app
RUN apt-get update
RUN apt-get install -y gcc python3-dev libpq-dev
RUN python -m pip install --no-cache-dir --upgrade pip
RUN python -m pip install --no-cache-dir -r requirements.txt
RUN python manage.py migrate
RUN python manage.py collectstatic --no-input
CMD ["gunicorn", "app.wsgi:application", "--reload", "--bind", "0.0.0.0:8000", "--workers", "2"]
