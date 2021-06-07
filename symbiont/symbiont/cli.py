from sssom.datamodel_util import to_mapping_set_dataframe, SSSOM_READ_FORMATS
import click
import yaml
import re
from pathlib import Path
import pandas as pd
import logging


@click.group()
@click.option('-v', '--verbose', count=True)
@click.option('-q', '--quiet')
def main(verbose, quiet):
    if verbose >= 2:
        logging.basicConfig(level=logging.DEBUG)
    elif verbose == 1:
        logging.basicConfig(level=logging.INFO)
    else:
        logging.basicConfig(level=logging.WARNING)
    if quiet:
        logging.basicConfig(level=logging.ERROR)


## Input and metadata would be files (file paths). Check if exists.
@main.command()
@click.option('-i', '--input', required=True, type=click.Path(), multiple=True)
@click.option('-I', '--input-format', required=False,
              type=click.Choice(SSSOM_READ_FORMATS, case_sensitive=False))
@click.option('-m', '--metadata', required=False, type=click.Path())
@click.option('-c', '--curie-map-mode', default='metadata_only', show_default=True, required=True,
              type=click.Choice(['metadata_only', 'sssom_default_only', 'merged'], case_sensitive=False))
@click.option('-o', '--output', type=click.Path())
def seed_mappings(input: str, input_format: str, metadata:str, curie_map_mode: str, output: str):
    """
    parse file (currently only supports conversion to RDF)
    """
    seed(input_path=input, output_path=output, input_format=input_format, metadata_path=metadata, curie_map_mode=curie_map_mode)
