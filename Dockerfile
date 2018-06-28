FROM python
ENV PYTHONUNBUFFERED 1
RUN apt-get update
RUN apt-get install -y gcc python3-dev libpq-dev
RUN mkdir /opt/app
WORKDIR /opt/app
COPY . /opt/app
RUN python -m pip install --no-cache-dir --upgrade pip
RUN python -m pip install --no-cache-dir -r requirements.txt
RUN python manage.py collectstatic --no-input
EXPOSE 8000
#CMD ["gunicorn", "app.wsgi:application", "--reload", "--bind", "0.0.0.0:8000", "--workers", "2"]
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

