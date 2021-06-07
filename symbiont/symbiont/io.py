def seed_match(ontologies: [str], matcher: str, matcher_config: str, id: str, output_directory: str):
    """
    Take N {ontologies} as an input and use the {matcher}, configured using {matcher_config} to generate N2 mappings.
    The matching process always generates 3 files in {output_directory}:
    - anchor_matches.sssom.tsv (which contains the high precision, true positive matches)
    - candidate_matches.sssom.tsv (which contains all candidate matches)
    - negative_matches.sssom.tsv (which contains all known false positive, or discarded, matches).

    :param ontologies: a list of ontology file paths whose mappings are to be refined
    :param matcher: the name of the matcher to be used to run
    :param matcher_config: the config to be used
    :param id: id of the mapping
    :param output_directory: the directory where to store the matches.
    """
    pass


def seed_download(anchor_matches: str, candidate_matches: str, negative_matches: str, id: str, output_directory: str):
    """
    Take N {ontologies} as an input and use the {matcher}, configured using {matcher_config} to generate N2 mappings.
    The matching process always generates 3 files in {output_directory}:
    - anchor_matches.sssom.tsv (which contains the high precision, true positive matches)
    - candidate_matches.sssom.tsv (which contains all candidate matches)
    - negative_matches.sssom.tsv (which contains all known false positive, or discarded, matches).

    :param anchor_matches: url pointing to a set of anchor matches (sssom)
    :param candidate_matches: url pointing to a set of candidate matches (sssom)
    :param negative_matches: url pointing to a set of negative matches (sssom)
    :param id: id of the mapping (used for filenaming)
    :param output_directory: anchor_matches: str, candidate_matches: str, negative_matches: str
    """
    pass


def seed_combine(anchor_matches: [str], candidate_matches: [str], negative_matches: [str], id: str,
                 output_directory: str):
    """
    Combines sets of anchor matches, candidate matches and negative matches to single set. This will not only merge
    the SSSOM tables, but also get rid of redundant matches (low confidence once of the high confidence ones exist),
    merge anchor matches into the set of candidate_matches and and remove all negative matches from candidate_matches.

    :param anchor_matches: a set of anchor match files (sssom)
    :param candidate_matches: a set of candidate match files (sssom)
    :param negative_matches: a set of negative match files (sssom)
    :param id: id of the mapping (used for file naming)
    :param output_directory: anchor_matches: str, candidate_matches: str, negative_matches: str
    """
    pass


def refine(ontologies: [str], anchor_matches: str, candidate_matches: str, negative_matches: str, matcher: str,
           matcher_config: str, output_dir: str):
    """
    Take in a set of ontologies, corresponding anchor matches, candidate matches and negative matches and refines them using more advanced
    techniques.

    :param ontologies: a list of ontology file paths whose mappings are to be refined
    :param anchor_matches: a file with a set of anchor_matches, i.e. matches that are trusted to be correct
    :param candidate_matches: a file with a set of potential matches
    :param negative_matches: a file with a set of negative matches, i.e. matches that are known to be false
    :param matcher: the name of the matcher to be used to run
    :param matcher_config: the config to be used
    """
    pass


def reconcile(ontologies: [str], anchor_matches: str, candidate_matches: str, negative_matches: str, matcher: str,
              matcher_config: str, output_mappings: str):
    """
    Take in a set of ontologies, corresponding anchor matches, candidate matches and negative matches and reconciles
    them to a coherent set.

    :param ontologies: a list of ontology file paths whose mappings are to be refined
    :param anchor_matches: a file with a set of anchor_matches, i.e. matches that are trusted to be correct
    :param candidate_matches: a file with a set of potential matches
    :param negative_matches: a file with a set of negative matches, i.e. matches that are known to be false
    :param matcher: the name of the matcher to be used to run
    :param matcher_config: the config to be used
    :param output_mappings: file to which the reconciled mappings set is written
    """
    pass


def augment(input_ontology, external_ontology, matches, augmentation_file):
    """
    Take as an input an internal ontology, and external ontology and compute an augmentation file
    :param input_ontology: The ontology that will be augmented
    :param external_ontology: The external ontology from which we will augment
    :param matches:
    :param augmentation_file: file to which the results of the augmentation will be written
    :return:
    """
    pass


def merge(ontologies: [str], matches):
    pass
