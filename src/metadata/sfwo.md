---
layout: ontology_detail
id: sfwo
title: Soil Food Web Ontology
jobs:
  - id: https://travis-ci.org/nleguillarme/sfwo
    type: travis-ci
build:
  checkout: git clone https://github.com/nleguillarme/soil_food_web_ontology.git
  system: git
  path: "."
contact:
  email:
  label:
  github:
description: Soil Food Web Ontology is an ontology...
domain: stuff
homepage: https://github.com/nleguillarme/soil_food_web_ontology
products:
  - id: sfwo.owl
    name: "Soil Food Web Ontology main release in OWL format"
  - id: sfwo.obo
    name: "Soil Food Web Ontology additional release in OBO format"
  - id: sfwo.json
    name: "Soil Food Web Ontology additional release in OBOJSon format"
  - id: sfwo/sfwo-base.owl
    name: "Soil Food Web Ontology main release in OWL format"
  - id: sfwo/sfwo-base.obo
    name: "Soil Food Web Ontology additional release in OBO format"
  - id: sfwo/sfwo-base.json
    name: "Soil Food Web Ontology additional release in OBOJSon format"
dependencies:
- id: ro
- id: bfo
- id: ecocore
- id: po
- id: pato
- id: uberon
- id: envo
- id: fao
- id: ncbitaxon

tracker: https://github.com/nleguillarme/soil_food_web_ontology/issues
license:
  url: http://creativecommons.org/licenses/by/3.0/
  label: CC-BY
activity_status: active
---

Enter a detailed description of your ontology here. You can use arbitrary markdown and HTML.
You can also embed images too.
