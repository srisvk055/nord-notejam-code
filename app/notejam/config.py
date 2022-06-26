import os
import pymysql


class Config(object):
    DEBUG = False
    TESTING = False
    SECRET_KEY = 'notejam-flask-secret-key'
    WTF_CSRF_ENABLED = True
    CSRF_SESSION_KEY = 'notejam-flask-secret-key'
    CLOUDSQL_USER = os.environ.get("root")
    CLOUDSQL_PASSWORD = os.environ.get("testing123")
    CLOUDSQL_DATABASE = os.environ.get("notejam-db")
    CLOUDSQL_CONNECTION_NAME = os.environ.get('nord-project:us-central1:notejam-instance')

    SQLALCHEMY_DATABASE_URI =  (
    'mysql+pymysql://{nam}:{pas}@35.226.9.185/{dbn}?unix_socket=/cloudsql/{con}').format (
    nam=CLOUDSQL_USER,
    pas=CLOUDSQL_PASSWORD,
    dbn=CLOUDSQL_DATABASE,
    con=CLOUDSQL_CONNECTION_NAME,
)

class ProductionConfig(Config):
    DEBUG = False


class DevelopmentConfig(Config):
    DEVELOPMENT = True
    DEBUG = True


class TestingConfig(Config):
    TESTING = True
    WTF_CSRF_ENABLED = False
