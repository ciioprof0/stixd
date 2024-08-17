#!/usr/bin/env python
# -*- coding: utf-8 -*-
# stixd/__init__.py

"""This file is used to ensure that the stixd directory is in the Python path."""

import sys
import os

# Ensure that the stixd directory is in the Python path
current_dir = os.path.dirname(os.path.abspath(__file__))
sys.path.append(current_dir)
