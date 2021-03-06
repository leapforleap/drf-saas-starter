Get started
===========

Concepts
--------

This template is used for Saas applications.

It is supposed to work for user-tenant-applications. The client can choose to register only one tenant (and all user registrations work for this one) or to add several tenants (adminstrators / billed partners of a platform), which can add users on their own.

The Package provides a backend with RESTful API endpoints. The admin is only for system operators. It needs a Javascript frontend for users and tenants.


Users

* need to be activated by the tenant.
* can edit their profile information.
* can add comments to other users (or other objects in the system).
* can get notifications, when things happen (f.e. a comment is received).

The application is ready for business objects to be added to the system. Objects can have an activity stream (= a timeline) with actions regarding that object. The user itself has an activity stream as well (e.g. for comments).


Installation
------------

Install Docker as described in  :doc:`docker`

Clone the GitHub repository::

    $ git clone git@github.com/jensneuhaus/drf-saas-starter


Start the local setup, it creates the required .env file::

    $ python local_setup.py

Start the Docker containers::

    $ docker-compose build
    $ docker-compose up

You should be able to open http://localhost:8000 in your browser.

.. warning::
   The following is work in progress. The installation procedere (Cookiecutter & PyPi) needs to be discussed.

Run the cookiecutter setup (TODO)

drf-saas-starter is available on PyPI - to install it, just run::

    pip install -U drf-saas-starter

It will install a package ``drf-saas-starter`` and add it to ``INSTALLED_APPS``::

    INSTALLED_APPS = (
        ...
        'django_saas_starter.users',
        'django_saas_starter.tenants',
        'django_saas_starter.mails',
        'django_saas_starter.comments',
        'django_saas_starter.activity_stream',
    )

That's it!

Now you can run :doc:`docker` for development or to run it locally. For deployment you should read :doc:`heroku`.

Local development
--------------------

If you want to develop locally, you need to have an virtual environment (for Pycharm and some console tools)::

    $ virtualenv -p python3 .venv
    $ source .venv/bin/activate
    $ pip install -r requirements/local.txt
