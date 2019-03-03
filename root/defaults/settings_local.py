CSRF_COOKIE_SECURE = False
DEBUG = False
POSTMARK_API_KEY = ''
SECRET_KEY = 'changeme'
SESSION_COOKIE_SECURE = False
STRIPE_SECRET_KEY = ''
USE_HTTPS = False
CSRF_TRUSTED_ORIGINS = ["{{SITE_ROOT}}"]

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': '/data/snipt.db',
    }
}
