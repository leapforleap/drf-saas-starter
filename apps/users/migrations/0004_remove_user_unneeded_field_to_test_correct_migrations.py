# -*- coding: utf-8 -*-
# Generated by Django 1.10.5 on 2017-03-13 12:58
from __future__ import unicode_literals

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0003_auto_20170313_1245'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='user',
            name='unneeded_field_to_test_correct_migrations',
        ),
    ]