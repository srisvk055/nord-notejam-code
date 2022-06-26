FROM python:3.6

RUN pip install --upgrade pip

RUN mkdir -p /usr/src/app

WORKDIR  /usr/src/app

COPY app/. /usr/src/app/

RUN pip3 --no-cache-dir install -r requirements.txt


EXPOSE 5000

ENTRYPOINT ["python"]
CMD ["runserver.py"]