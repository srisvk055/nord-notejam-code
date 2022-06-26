import os

db_user = os.environ.get("root")
db_password = os.environ.get("testing123")
db_url = os.environ.get("nord-project:us-central1:notejam-instance")

class Config(object):
    DEBUG = False
    TESTING = False
    SECRET_KEY = 'notejam-flask-secret-key'
    CSRF_ENABLED = True
    CSRF_SESSION_KEY = 'notejam-flask-secret-key'


class ProductionConfig(Config):
    DEBUG = True
    SQLALCHEMY_DATABASE_URI  = 'mysql://' + str(db_user) + ':' + str(db_password) + '@' + str(db_url) + '/notejam'
    #SQLALCHEMY_DATABASE_URI = os.environ.get('SQLALCHEMY_DATABASE_URI')


class DevelopmentConfig(Config):
    DEVELOPMENT = True
    DEBUG = True
    SQLALCHEMY_DATABASE_URI  = 'mysql://' + str(db_user) + ':' + str(db_password) + '@' + str(db_url) + '/notejam'
    #SQLALCHEMY_DATABASE_URI = os.environ.get('SQLALCHEMY_DATABASE_URI')
    #SQLALCHEMY_DATABASE_URI = 'sqlite:///' + os.path.join(os.getcwd(),
    #                                                      'notejam.db')


class TestingConfig(Config):
    TESTING = True
    """
    Tests will run WAY faster using in memory SQLITE database
    See: https://docs.sqlalchemy.org/en/13/dialects/sqlite.html#connect-strings
    """
    SQLALCHEMY_DATABASE_URI = 'sqlite://'