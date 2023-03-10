<!-- [![Build Status](https://travis-ci.org/nleguillarme/sfwo.svg?branch=master)](https://travis-ci.org/nleguillarme/sfwo)
[![DOI](https://zenodo.org/badge/13996/nleguillarme/sfwo.svg)](https://zenodo.org/badge/latestdoi/13996/nleguillarme/sfwo) -->

<!-- <a><img align="right" width="300" src="https://i.ibb.co/QQtPKJM/sfwo-logo.png" alt="Soil Food Web Ontology"></a> -->

![](https://i.ibb.co/QQtPKJM/sfwo-logo.png)

The Soil Food Web Ontology (SFWO) is a OWL ontology which provides a standardised terminology and a logical formalisation of the domain of soil trophic ecology. It proposes a reference vocabulary to describe information about trophic interactions, feeding preferences (diets) and feeding processes of soil biota. By harmonizing the definitions of trophic groups, SFWO provides a common, logically-sound framework for soil-associated consumers classification across taxonomic groups and trophic levels.

The Soil Food Web Ontology aims at being a reference ontology for soil trophic ecology, and a resource for ontology-driven applications in the field, including:
- trophic trait datasets standardization
- trophic data integration and knowledge graph construction
- automated soil food web reconstruction using OWL reasoning
- trophic information extraction

### How to cite this ontology ?

Please cite the accompanying paper:

Le Guillarme, N., Hedde, M., Potapov, A., Berg, M. P., Briones, M. J., Calderon-Sanou, I., ... & Thuiller, W. (2023). The Soil Food Web Ontology: aligning trophic groups, processes, and resources to harmonise and automatise soil food web reconstructions. bioRxiv, 2023-02. https://doi.org/10.1101/2023.02.03.526812

## Browsing the Soil Food Web Ontology

Currently the optimal way to browse SFWO is to open [sfwo.owl](http://github.com/nleguillarme/soil_food_web_ontology/releases/latest/download/sfwo.owl) in Protégé or WebProtégé.

A browsable version of SFWO, including a graphical representation of the concepts hierarchy, is available online on [AgroPortal](https://agroportal.lirmm.fr/ontologies/SFWO) (please note that AgroPortal does not display the equivalentClass axioms).

An export of the ontology in a tabular format ([sfwo.csv](http://github.com/nleguillarme/soil_food_web_ontology/releases/latest/download/sfwo.csv)) is also provided with each release.

See the list of relations on OntoBee -- note that sometimes OntoBee fails to display the full hierarchy

## Contributing to the development of the Soil Food Web Ontology

The development of SFWO is a open and collaborative effort that bring together soil scientists and ontology engineers. SFWO is continuously updated, improved and enriched thanks to contributors’ suggestions for revisions. Contributors are invited to suggest and discuss changes in the ontology using the [Issue tracker](https://github.com/nleguillarme/soil_food_web_ontology/issues) of the project’s GitHub repository. Requests for changes/modifications are regularly submitted to the ontology steering committee for discussion and validation.

The steering committee is currently composed of:
- Mickaël Hedde (Eco&Sols, INRAE)
- Anton M. Potapov (German Centre for Integrative Biodiversity Research, iDiv)
- Matty P. Berg (Amsterdam Institute of Life and Environment)
- Maria J.I. Briones (University of Vigo)
- Irene Calderón-Sanou (German Centre for Integrative Biodiversity Research, iDiv)
- Florine Degrune (Eco&Sols, CIRAD)
- Karin Hohberg (Senckenberg - Leibniz Institution for Biodiversity and Earth System Research)
- Camille Martinez-Almoyna (INRAE)
- Carlos A. Martínez-Muñoz (Senckenberg - Leibniz Institution for Biodiversity and Earth System Research)
- Benjamin Pey (Laboratoire Ecologie Fonctionnelle et Environnement, LEFE)
- David J. Russell (Senckenberg - Leibniz Institution for Biodiversity and Earth System Research)
- Nicolas Le Guillarme (Laboratoire d'Écologie Alpine, LECA)

## Versions

### Stable release versions

The latest version of the ontology can always be found at:

https://github.com/nleguillarme/soil_food_web_ontology/releases

<!-- http://purl.obolibrary.org/obo/stwo.owl

(note this will not show up until the request has been approved by obofoundry.org)-->

### Editors' version

Editors of this ontology should use the edit version, [src/ontology/sfwo-edit.owl](src/ontology/sfwo-edit.owl)

## Contact

Please use this GitHub repository's [Issue tracker](https://github.com/nleguillarme/sfwo/issues) to request new terms/classes or report errors or specific concerns related to the ontology.

## Acknowledgements

This ontology repository was created using the [Ontology Development Kit](https://github.com/INCATools/ontology-development-kit)
