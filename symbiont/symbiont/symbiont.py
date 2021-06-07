from sssom.datamodel_util import MappingSetDataFrame
from sssom.parsers import from_tsv
import validators


class Symbiont:
    def __init__(self):
        self.anchor_mappings = MappingSetDataFrame()
        self.candidate_mappings = MappingSetDataFrame()
        self.negative_mappings = MappingSetDataFrame()

    def load_anchor_mappings(self, mappings):
        if isinstance(mappings, MappingSetDataFrame):
            self.anchor_mappings.combine(mappings)
        elif isinstance(mappings, str):
            if validators.url(mappings):
                m = from_tsv()
        else:
            raise
        pass

    def load_candidate_mappings(self, mappings):
        pass

    def load_negative_mappings(self, mappings):
        pass


