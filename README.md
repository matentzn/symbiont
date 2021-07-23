# SymbiOnt

A toolkit building implementing workflows to merge / augment existing ontologies. SymbiOnt builds on existing tools, such as ontology matchers, SSSOM python toolkit and Boomer.

## Basic workflow

The entire pipeline is implemented as commands in a docker image. As there are different tech stacks involved (running on different versions of python), different tools stitched together (matching tools such as RDF matcher, Agreement Maker Light; merging tools such as ROBOT, boomer) etc, the container is _huge_ (2GB compressed). The state of the workflows are totally experimental (pre-Alpha), so hiccups should be expected. At the moment, I use `symbiont` like this:

1. Add the [symbiont execution script](bin/symbiont) (basically a docker wrapper) to my path
2. Update `symbiont` (make sure you clean up old versions from time to time as well!): `docker pull monarchinitiative/symbiont
`
3. Run the tests: `make test` (relies on you having done step 1.)

## Tools embedded

Currently (v. 0.0.1)
1. RDF Matcher by Chris Mungall, see https://github.com/cmungall/rdf_matcher
2. AgreementMakerLight (AML) by LASIGE, see https://github.com/AgreementMakerLight/AML-Project
3. SSSOM toolkit, see https://github.com/mapping-commons/sssom-py
4. Ontology Development Kit (ODK), see https://github.com/INCATools/ontology-development-kit

## Work in progress

1. LogMap by Ernesto Jiménez-Ruiz, see https://github.com/ernestojimenezruiz/logmap-matcher
2. PAXO by Thomas Liener (Pistoia Alliance), see https://github.com/EBISPOT/OXO/tree/master/paxo-loader
3. Boomer by Jim Balhoff, see https://github.com/INCATools/boomer
