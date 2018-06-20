FROM python
COPY . /opt/app
WORKDIR /opt/app
RUN pip install -r requirements.txt
RUN django-admin startproject app .
ENV PORT=8000
ENTRYPOINT python manage.py runserver 0.0.0.0:$PORT
EXPOSE $PORT
