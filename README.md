[![Build Status](https://travis-ci.org/nleguillarme/stwo.svg?branch=master)](https://travis-ci.org/nleguillarme/stwo)
[![DOI](https://zenodo.org/badge/13996/nleguillarme/stwo.svg)](https://zenodo.org/badge/latestdoi/13996/nleguillarme/stwo)

# The Soil Trophic Web Ontology

The Soil Trophic Web Ontology (STWO) is a domain ontology which represents and maps together knowledge about trophic interactions (consumer-resource relationships) and trophic groups (feeding habits, diets), with a focus on soil food webs. The STWO is published on GitHub as open source software and is constantly being extended. A steering committee of 20+ soil ecology experts was created to accompany the development and widespread adoption of the ontology.

The STWO is a joint effort to :
- standardize trophic group definitions
- provide a vocabulary of terms for text mining
- automate the creation of food webs from interaction data
- 
This domain ontology has a strong focus on reasoning. It provides logical definitions of trophic groups in the form of OWL equivalence axioms to support food web reconstruction using OWL reasoning.

The STWO makes use of the Basic Formal Ontology (BFO) and its principles for interoperability. It reuses existing ontologies as much as possible (see the wiki for details).

<!-- STWO leverages existing OBO ontologies as much as possible. In particular, STWO extends a "trophic subset" of [the ECOCORE ontology](https://github.com/EcologicalSemantics/ecocore) with additional classes for missing trophic groups and resources. STWO also provides logical definitions of trophic groups in the form of OWL equivalence axioms to support food web reconstruction using OWL reasoning. -->

<!-- More information can be found at http://obofoundry.org/ontology/stwo -->

## Versions

### Stable release versions

The latest version of the ontology can always be found at:

https://github.com/nleguillarme/soil_trophic_web_ontology/releases

<!-- http://purl.obolibrary.org/obo/stwo.owl

(note this will not show up until the request has been approved by obofoundry.org)-->

### Editors' version

Editors of this ontology should use the edit version, [src/ontology/stwo-edit.owl](src/ontology/stwo-edit.owl)

## Contact

Please use this GitHub repository's [Issue tracker](https://github.com/nleguillarme/stwo/issues) to request new terms/classes or report errors or specific concerns related to the ontology.

## Acknowledgements

This ontology repository was created using the [ontology starter kit](https://github.com/INCATools/ontology-starter-kit)
