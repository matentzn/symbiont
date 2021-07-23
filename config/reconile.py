#!/usr/bin/env python
# coding: utf-8

"""
This script uses a mix of IHCC services to generate mapping suggestions for data dictionaries.
The input is a ROBOT template with the usual IHCC data dictionary. This dictionary is augmented with
Suggested mappings, which are added the 'Suggested Mappings' column of the template.
author: Nico Matentzoglu for Knocean Inc., 26 August 2020
"""

from argparse import ArgumentParser

import pandas as pd

from lib import load_ihcc_config, map_term

parser = ArgumentParser()
parser.add_argument("-t", "--true-mappings", dest="true_mappings_path", help="Template file", metavar="FILE")
parser.add_argument("-m", "--mapping-candidates", dest="tsv_out_paths", help="one or more candidate mappings", metavar="FILE", action='append')
args = parser.parse_args()

# Loading config
