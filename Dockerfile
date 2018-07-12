FROM python:3.7.0-alpine3.7
#ENV PYTHONUNBUFFERED 1
RUN set -ex && \
  apk update && apk add --no-cache \
  #apk update && apk add --no-cache --virtual=.build-dependencies \
  gcc \
  musl-dev \
  postgresql-dev \
  python3-dev
  #python3-dev && \
  #apk del --purge .build-dependencies
WORKDIR /opt/app
COPY . /opt/app
RUN python -m pip install --no-cache --upgrade pip
RUN python -m pip install --no-cache -r requirements.txt
RUN python manage.py collectstatic --no-input
EXPOSE 8000
#CMD ["gunicorn", "app.wsgi:application", "--reload", "--bind", "0.0.0.0:8000", "--workers", "2"]
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

