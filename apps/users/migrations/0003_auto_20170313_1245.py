# -*- coding: utf-8 -*-
# Generated by Django 1.10.5 on 2017-03-13 12:45
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0002_user_unneeded_field_to_test_correct_migrations'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='unneeded_field_to_test_correct_migrations',
            field=models.BooleanField(default=True),
        ),
    ]
