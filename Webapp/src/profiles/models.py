# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models

# Create your models here.


class profile(models.Model):
	username = models.CharField(max_length = 120)
	description = models.TextField(default = 'default text')

	def __unicode__(self):
		return self.username