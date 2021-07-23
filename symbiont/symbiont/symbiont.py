import os
from sssom.datamodel_util import MappingSetDataFrame
from sssom.parsers import from_tsv
import validators
import yaml
import logging

class OntologyConfig:
    def __init__(self, config):
        self.id = config['id']


class PipelineAction:
    def __init__(self, config):
        self.action = config['action']
        if 'input' in config:
            self.input = config['input']


class SymbiontConfig:

    def __init__(self, configfile):
        with open(configfile) as file:
            config = yaml.load(file, Loader=yaml.FullLoader)
        self.ontologies = []
        self.pipeline = []

        for o in config['ontologies']:
            self.ontologies.append(OntologyConfig(o))

        if "pipeline" in config:
            for p in config['pipeline']:
                self.pipeline.append(PipelineAction(p))

class Symbiont:

    def __init__(self, configfile, data_dir="data"):
        self.config = SymbiontConfig(configfile)
        self.mappings = MappingSetDataFrame()
        self.data_directory = data_dir
        self._run_pipeline_from_config()


    def load_mappings(self, mappings):
        if isinstance(mappings, MappingSetDataFrame):
            self.mappings = self._merge_mappings(self.mappings, mappings)
        elif isinstance(mappings, str) and (validators.url(mappings) or os.path.exists(mappings)):
            self.mappings = self._merge_mappings(self.mappings, from_tsv(mappings))
        else:
            raise ValueError(f"mappings parameter ({mappings}) must be a MappingSetDataFrame or a string (URL or a file path), "
                             f"but is a {type(mappings)}")

    def _merge_mappings(self, mapping1: MappingSetDataFrame, mapping2: MappingSetDataFrame):
        """
        Should be in SSSOM TODO
        :return: merged MappingSetDataFrame
        """
        merged = MappingSetDataFrame()
        if mapping1.df:
            if mapping2.df:
                merged.df = mapping1.df.merge(mapping2.df)
            else:
                merged.df = mapping1.df
        elif mapping2.df:
            merged.df = mapping2.df

        merged.prefixmap = mapping1.prefixmap
        k: str
        for k in mapping2.prefixmap:
            if k not in merged.prefixmap:
                merged.prefixmap[k]=mapping2.prefixmap[k]
        merged.metadata = mapping1.metadata
        for k in mapping2.metadata:
            if k not in merged.metadata:
                merged.metadata[k]=mapping2.metadata[k]
        return merged


    def match(self, ):
        pass

    def set_data_directory(self, directory):
        self.data_directory = directory

    def _run_pipeline_from_config(self):
        for action in self.config.pipeline:
            if action.action == "load_mapping":
                logging.info(f"loading mapping {action.input}")
                mappings = os.path.join(self.data_directory,action.input)
                logging.warning(mappings)
                self.load_mappings(mappings=mappings)


