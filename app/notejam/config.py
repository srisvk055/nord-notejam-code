import os


class Config(object):
    DEBUG = False
    TESTING = False
    SECRET_KEY = 'notejam-flask-secret-key'
    WTF_CSRF_ENABLED = True
    CSRF_SESSION_KEY = 'notejam-flask-secret-key'
    db_user = os.environ.get("root")
    db_pass = os.environ.get("testing123")
    db_name = os.environ.get("notejam-db")

    SQLALCHEMY_DATABASE_URI = 'mysql+pymysql://' + str(db_user) + ':' + str(db_pass) + '@localhost/' + str(db_name)


class ProductionConfig(Config):
    DEBUG = False


class DevelopmentConfig(Config):
    DEVELOPMENT = True
    DEBUG = True


class TestingConfig(Config):
    TESTING = True
    WTF_CSRF_ENABLED = False
