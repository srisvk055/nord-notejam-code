FROM python:3.6

RUN pip install --upgrade pip

RUN mkdir -p /usr/src/app

WORKDIR  /usr/src/app

COPY . /usr/src/app

RUN pip3 --no-cache-dir install -r requirements.txt

RUN python db.py

EXPOSE 5000

CMD ["python", "runserver.py"]