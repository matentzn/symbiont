# Monarch Ontology Alignment Kit (MOAK)

The Monarch Ontology Alignment Kit (MOAK) is a docker image that contains a set of ontology matching tools which convert
output into a common format (SSSOM).

## Tools embedded

## Reference

_LogMap_

- Documentation: https://github.com/ernestojimenezruiz/logmap-matcher
- 

```
mkdir out
sh run.sh logmap MATCHER file:/work/tests/ecto.test.owl file:/work/tests/mre.test.owl out/ true
```

_LogMap ML_

- Documentation: https://github.com/KRR-Oxford/OntoAlign/tree/main/LogMap-ML

_AML_:

- Documentation: https://github.com/AgreementMakerLight/AML-Project/tree/v3.2 
(note: make sure this is the documentation) of the version referred to in the Dockerfile
