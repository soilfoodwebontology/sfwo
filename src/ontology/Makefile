# ----------------------------------------
# Makefile for sfwo
# Generated using ontology-development-kit
# ODK Version: v1.3.1
# ----------------------------------------
# IMPORTANT: DO NOT EDIT THIS FILE. To override default make goals, use sfwo.Makefile instead


# ----------------------------------------
# More information: https://github.com/INCATools/ontology-development-kit/


# ----------------------------------------
# Standard Constants
# ----------------------------------------
# these can be overwritten on the command line

URIBASE=                    http://purl.org
#URIBASE=                   http://purl.org/sfwo
OBO_URIBASE=  					http://purl.obolibrary.org/obo
ONT=                        sfwo
ONTBASE=                    $(URIBASE)/$(ONT)
EDIT_FORMAT=                owl
SRC =                       $(ONT)-edit.$(EDIT_FORMAT)
CATALOG=                    catalog-v001.xml
ROBOT=                      robot --catalog $(CATALOG)

OWLTOOLS=                   owltools --use-catalog
RELEASEDIR=                 ../..
REPORTDIR=                  reports
TEMPLATEDIR=                ../templates
TMPDIR=                     tmp
MIRRORDIR=                  mirror
IMPORTDIR=                  imports
SUBSETDIR=                  subsets
SCRIPTSDIR=                 ../scripts
SPARQLDIR =                 ../sparql
COMPONENTSDIR =             components
REPORT_FAIL_ON =            None
REPORT_LABEL =              -l true
REPORT_PROFILE_OPTS =       
OBO_FORMAT_OPTIONS =        
SPARQL_VALIDATION_CHECKS =  owldef-self-reference iri-range label-with-iri 
SPARQL_EXPORTS =            basic-report class-count-by-prefix edges xrefs obsoletes synonyms 
ODK_VERSION_MAKEFILE =      v1.3.1

TODAY ?=                    $(shell date +%Y-%m-%d)
OBODATE ?=                  $(shell date +'%d:%m:%Y %H:%M')
VERSION=                    $(TODAY)
ANNOTATE_ONTOLOGY_VERSION = annotate -V $(ONTBASE)/releases/$(VERSION)/$@ --annotation owl:versionInfo $(VERSION)
OTHER_SRC =                 
ONTOLOGYTERMS =             $(TMPDIR)/ontologyterms.txt

FORMATS = $(sort  owl owl)
FORMATS_INCL_TSV = $(sort $(FORMATS) tsv)
RELEASE_ARTEFACTS = $(sort $(ONT)-full $(ONT)-base $(ONT)-base $(ONT)-full)

# ----------------------------------------
# Top-level targets
# ----------------------------------------

.PHONY: .FORCE

.PHONY: all
all: all_odk

.PHONY: all_odk
all_odk: odkversion test all_assets

.PHONY: test
test: odkversion sparql_test robot_reports $(REPORTDIR)/validate_profile_owl2dl_$(ONT).owl.txt
	$(ROBOT) reason --input $(SRC) --reasoner ELK  --equivalent-classes-allowed all \
                  --exclude-tautologies structural --output test.owl && rm test.owl &&\
  echo "Success"

.PHONY: odkversion
odkversion:
	echo "ODK Makefile version: $(ODK_VERSION_MAKEFILE) (this is the version of the ODK with which this Makefile was generated, \
        not the version of the ODK you are running)" &&\
	echo "ROBOT version (ODK): " && $(ROBOT) --version

$(TMPDIR) $(REPORTDIR) $(MIRRORDIR) $(IMPORTDIR) $(COMPONENTSDIR) $(SUBSETDIR):
	mkdir -p $@

# ----------------------------------------
# Release assets
# ----------------------------------------

MAIN_PRODUCTS = $(sort $(foreach r,$(RELEASE_ARTEFACTS), $(r)) $(ONT))
MAIN_GZIPPED  = 
MAIN_FILES    = $(foreach n,$(MAIN_PRODUCTS), $(foreach f,$(FORMATS), $(n).$(f))) $(MAIN_GZIPPED)
SRCMERGED     = $(TMPDIR)/merged-$(SRC)

.PHONY: all_main
all_main: $(MAIN_FILES)

# ----------------------------------------
# Import assets
# ----------------------------------------


IMPORTS =  ro bfo ecocore po pato uberon envo fao pco ncbitaxon chebi go

IMPORT_ROOTS = $(patsubst %, $(IMPORTDIR)/%_import, $(IMPORTS))
IMPORT_OWL_FILES = $(foreach n,$(IMPORT_ROOTS), $(n).owl)
IMPORT_FILES = $(IMPORT_OWL_FILES)


.PHONY: all_imports
all_imports: $(IMPORT_FILES)

# ----------------------------------------
# Subset assets
# ----------------------------------------


SUBSETS = 

SUBSET_ROOTS = $(patsubst %, $(SUBSETDIR)/%, $(SUBSETS))
SUBSET_FILES = $(foreach n,$(SUBSET_ROOTS), $(foreach f,$(FORMATS_INCL_TSV), $(n).$(f)))

.PHONY: all_subsets
all_subsets: $(SUBSET_FILES)

# ----------------------------------------
# QC Reports & Utilities
# ----------------------------------------

OBO_REPORT =  $(SRC)-obo-report
REPORTS = $(OBO_REPORT)
REPORT_FILES = $(patsubst %, $(REPORTDIR)/%.tsv, $(REPORTS))

.PHONY: robot_reports
robot_reports: $(REPORT_FILES)

.PHONY: all_reports
all_reports: custom_reports robot_reports

# ----------------------------------------
# ROBOT OWL Profile checking
# ----------------------------------------

# The conversion to functional syntax is necessary to avoid undeclared entity violations.
$(REPORTDIR)/validate_profile_owl2dl_%.txt: % | $(REPORTDIR) $(TMPDIR)
	$(ROBOT) merge -i $< convert -f ofn -o $(TMPDIR)/validate.ofn
	$(ROBOT) validate-profile --profile DL -i $(TMPDIR)/validate.ofn -o $@ || { cat $@ && exit 1; }
.PRECIOUS: $(REPORTDIR)/validate_profile_owl2dl_%.txt

validate_profile_%: $(REPORTDIR)/validate_profile_owl2dl_%.txt
	echo "$* profile validation completed."

# ----------------------------------------
# Sparql queries: Q/C
# ----------------------------------------

# these live in the ../sparql directory, and have suffix -violation.sparql
# adding the name here will make the violation check live.

SPARQL_VALIDATION_QUERIES = $(foreach V,$(SPARQL_VALIDATION_CHECKS),$(SPARQLDIR)/$(V)-violation.sparql)

sparql_test: $(SRC) catalog-v001.xml | $(REPORTDIR)
ifneq ($(SPARQL_VALIDATION_QUERIES),)
	$(ROBOT) verify  --catalog catalog-v001.xml -i $< --queries $(SPARQL_VALIDATION_QUERIES) -O $(REPORTDIR)
endif

# ----------------------------------------
# ROBOT report
# ----------------------------------------

$(REPORTDIR)/$(SRC)-obo-report.tsv: $(SRCMERGED) | $(REPORTDIR)
	$(ROBOT) report -i $< $(REPORT_LABEL) $(REPORT_PROFILE_OPTS) --fail-on $(REPORT_FAIL_ON) --base-iri $(URIBASE)/SFWO_ --base-iri $(URIBASE)/sfwo --print 5 -o $@

$(REPORTDIR)/%-obo-report.tsv: % | $(REPORTDIR)
	$(ROBOT) report -i $< $(REPORT_LABEL) $(REPORT_PROFILE_OPTS) --fail-on $(REPORT_FAIL_ON) --base-iri $(URIBASE)/SFWO_ --base-iri $(URIBASE)/sfwo --print 5 -o $@

# ----------------------------------------
# Release assets
# ----------------------------------------

ASSETS = \
  $(IMPORT_FILES) \
  $(MAIN_FILES) \
  $(REPORT_FILES) \
  $(SUBSET_FILES)

RELEASE_ASSETS = \
  $(MAIN_FILES) \
  $(SUBSET_FILES)

.PHONY: all_assets
all_assets: $(ASSETS)

.PHONY: show_assets
show_assets:
	echo $(ASSETS)
	du -sh $(ASSETS)

# ----------------------------------------
# Release Management
# ----------------------------------------

CLEANFILES=$(MAIN_FILES) $(SRCMERGED)
# This should be executed by the release manager whenever time comes to make a release.
# It will ensure that all assets/files are fresh, and will copy to release folder

.PHONY: prepare_release
prepare_release: all_odk
	rsync -R $(RELEASE_ASSETS) $(RELEASEDIR) &&\
	rm -f $(CLEANFILES) &&\
	echo "Release files are now in $(RELEASEDIR) - now you should commit, push and make a release \
        on your git hosting site such as GitHub or GitLab"

.PHONY: prepare_initial_release
prepare_initial_release: all_assets
	rsync -R $(RELEASE_ASSETS) $(RELEASEDIR) &&\
	rm -f $(patsubst %, ./%, $(CLEANFILES)) &&\
	cd $(RELEASEDIR) && git add $(RELEASE_ASSETS)

.PHONY: prepare_release_fast
prepare_release_fast:
	$(MAKE) prepare_release IMP=false PAT=false MIR=false COMP=false

# ------------------------
# Imports: Seeding system 
# ------------------------

# seed.txt contains all referenced entities
IMPORTSEED=$(TMPDIR)/seed.txt
PRESEED=$(TMPDIR)/pre_seed.txt

$(SRCMERGED): $(SRC) $(OTHER_SRC)
	$(ROBOT) remove --input $< --select imports --trim false \
		merge  $(patsubst %, -i %, $(OTHER_SRC)) -o $@

$(PRESEED): $(SRCMERGED)
	$(ROBOT) query -f csv -i $< --query ../sparql/terms.sparql $@.tmp &&\
	cat $@.tmp | sort | uniq >  $@



ALLSEED = $(PRESEED) \


$(IMPORTSEED): $(ALLSEED) | $(TMPDIR)
	if [ $(IMP) = true ]; then cat $(ALLSEED) | sort | uniq > $@; fi

ANNOTATION_PROPERTIES=rdfs:label IAO:0000115 

# ----------------------------------------
# Import modules
# ----------------------------------------
# Most ontologies are modularly constructed using portions of other ontologies
# These live in the imports/ folder
# This pattern uses ROBOT to generate an import module

# Should be able to drop this if robot can just take a big messy list of terms as input.
$(IMPORTDIR)/%_terms_combined.txt: $(IMPORTSEED) $(IMPORTDIR)/%_terms.txt
	if [ $(IMP) = true ]; then cat $^ | grep -v ^# | sort | uniq >  $@; fi




$(IMPORTDIR)/%_import.owl: $(MIRRORDIR)/%.owl $(IMPORTDIR)/%_terms_combined.txt
	if [ $(IMP) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module.ru \
		extract -T $(IMPORTDIR)/$*_terms_combined.txt --force true --copy-ontology-annotations true --individuals include --method BOT \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/inject-synonymtype-declaration.ru --update ../sparql/postprocess-module.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi

.PRECIOUS: $(IMPORTDIR)/%_import.owl

## Module for ontology: ncbitaxon

$(IMPORTDIR)/ncbitaxon_import.owl: $(MIRRORDIR)/ncbitaxon.owl $(IMPORTDIR)/ncbitaxon_terms_combined.txt
	if [ $(IMP) = true ] && [ $(IMP_LARGE) = true ]; then $(ROBOT) extract -i $< -T $(IMPORTDIR)/ncbitaxon_terms_combined.txt --force true  --copy-ontology-annotations true --individuals include --method BOT \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/inject-synonymtype-declaration.ru --update ../sparql/postprocess-module.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi

## Module for ontology: chebi

$(IMPORTDIR)/chebi_import.owl: $(MIRRORDIR)/chebi.owl $(IMPORTDIR)/chebi_terms_combined.txt
	if [ $(IMP) = true ] && [ $(IMP_LARGE) = true ]; then $(ROBOT) extract -i $< -T $(IMPORTDIR)/chebi_terms_combined.txt --force true  --copy-ontology-annotations true --individuals include --method BOT \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/inject-synonymtype-declaration.ru --update ../sparql/postprocess-module.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi

## Module for ontology: go

$(IMPORTDIR)/go_import.owl: $(MIRRORDIR)/go.owl $(IMPORTDIR)/go_terms_combined.txt
	if [ $(IMP) = true ] && [ $(IMP_LARGE) = true ]; then $(ROBOT) extract -i $< -T $(IMPORTDIR)/go_terms_combined.txt --force true  --copy-ontology-annotations true --individuals include --method BOT \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/inject-synonymtype-declaration.ru --update ../sparql/postprocess-module.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi


.PHONY: refresh-imports
refresh-imports:
	$(MAKE) IMP=true MIR=true PAT=false IMP_LARGE=true all_imports -B

.PHONY: no-mirror-refresh-imports
no-mirror-refresh-imports:
	$(MAKE) IMP=true MIR=false PAT=false IMP_LARGE=true all_imports -B

.PHONY: refresh-imports-excluding-large
refresh-imports-excluding-large:
	$(MAKE) IMP=true MIR=true PAT=false IMP_LARGE=false all_imports -B

.PHONY: refresh-%
refresh-%:
	$(MAKE) IMP=true IMP_LARGE=true MIR=true PAT=false $(IMPORTDIR)/$*_import.owl -B

.PHONY: no-mirror-refresh-%
no-mirror-refresh-%:
	$(MAKE) IMP=true IMP_LARGE=true MIR=false PAT=false $(IMPORTDIR)/$*_import.owl -B

# ----------------------------------------
# Mirroring upstream ontologies
# ----------------------------------------

IMP=true # Global parameter to bypass import generation
MIR=true # Global parameter to bypass mirror generation
IMP_LARGE=true # Global parameter to bypass handling of large imports



## ONTOLOGY: ro
.PHONY: mirror-ro
.PRECIOUS: $(MIRRORDIR)/ro.owl
mirror-ro: | $(TMPDIR)
	if [ $(MIR) = true ] && [ $(IMP) = true ]; then curl -L $(OBO_URIBASE)/ro.owl --create-dirs -o $(MIRRORDIR)/ro.owl --retry 4 --max-time 200 &&\
		$(ROBOT) convert -i $(MIRRORDIR)/ro.owl -o $@.tmp.owl &&\
		mv $@.tmp.owl $(TMPDIR)/$@.owl; fi


## ONTOLOGY: bfo
.PHONY: mirror-bfo
.PRECIOUS: $(MIRRORDIR)/bfo.owl
mirror-bfo: | $(TMPDIR)
	if [ $(MIR) = true ] && [ $(IMP) = true ]; then curl -L $(OBO_URIBASE)/bfo.owl --create-dirs -o $(MIRRORDIR)/bfo.owl --retry 4 --max-time 200 &&\
		$(ROBOT) convert -i $(MIRRORDIR)/bfo.owl -o $@.tmp.owl &&\
		mv $@.tmp.owl $(TMPDIR)/$@.owl; fi


## ONTOLOGY: ecocore
.PHONY: mirror-ecocore
.PRECIOUS: $(MIRRORDIR)/ecocore.owl
mirror-ecocore: | $(TMPDIR)
	if [ $(MIR) = true ] && [ $(IMP) = true ]; then curl -L $(OBO_URIBASE)/ecocore.owl --create-dirs -o $(MIRRORDIR)/ecocore.owl --retry 4 --max-time 200 &&\
		$(ROBOT) convert -i $(MIRRORDIR)/ecocore.owl -o $@.tmp.owl &&\
		mv $@.tmp.owl $(TMPDIR)/$@.owl; fi


## ONTOLOGY: po
.PHONY: mirror-po
.PRECIOUS: $(MIRRORDIR)/po.owl
mirror-po: | $(TMPDIR)
	if [ $(MIR) = true ] && [ $(IMP) = true ]; then curl -L $(OBO_URIBASE)/po.owl --create-dirs -o $(MIRRORDIR)/po.owl --retry 4 --max-time 200 &&\
		$(ROBOT) convert -i $(MIRRORDIR)/po.owl -o $@.tmp.owl &&\
		mv $@.tmp.owl $(TMPDIR)/$@.owl; fi


## ONTOLOGY: pato
.PHONY: mirror-pato
.PRECIOUS: $(MIRRORDIR)/pato.owl
mirror-pato: | $(TMPDIR)
	if [ $(MIR) = true ] && [ $(IMP) = true ]; then curl -L $(OBO_URIBASE)/pato.owl --create-dirs -o $(MIRRORDIR)/pato.owl --retry 4 --max-time 200 &&\
		$(ROBOT) convert -i $(MIRRORDIR)/pato.owl -o $@.tmp.owl &&\
		mv $@.tmp.owl $(TMPDIR)/$@.owl; fi


## ONTOLOGY: uberon
.PHONY: mirror-uberon
.PRECIOUS: $(MIRRORDIR)/uberon.owl
mirror-uberon: | $(TMPDIR)
	if [ $(MIR) = true ] && [ $(IMP) = true ]; then curl -L $(OBO_URIBASE)/uberon.owl --create-dirs -o $(MIRRORDIR)/uberon.owl --retry 4 --max-time 200 &&\
		$(ROBOT) convert -i $(MIRRORDIR)/uberon.owl -o $@.tmp.owl &&\
		mv $@.tmp.owl $(TMPDIR)/$@.owl; fi


## ONTOLOGY: envo
.PHONY: mirror-envo
.PRECIOUS: $(MIRRORDIR)/envo.owl
mirror-envo: | $(TMPDIR)
	if [ $(MIR) = true ] && [ $(IMP) = true ]; then curl -L $(OBO_URIBASE)/envo.owl --create-dirs -o $(MIRRORDIR)/envo.owl --retry 4 --max-time 200 &&\
		$(ROBOT) convert -i $(MIRRORDIR)/envo.owl -o $@.tmp.owl &&\
		mv $@.tmp.owl $(TMPDIR)/$@.owl; fi


## ONTOLOGY: fao
.PHONY: mirror-fao
.PRECIOUS: $(MIRRORDIR)/fao.owl
mirror-fao: | $(TMPDIR)
	if [ $(MIR) = true ] && [ $(IMP) = true ]; then curl -L $(OBO_URIBASE)/fao.owl --create-dirs -o $(MIRRORDIR)/fao.owl --retry 4 --max-time 200 &&\
		$(ROBOT) convert -i $(MIRRORDIR)/fao.owl -o $@.tmp.owl &&\
		mv $@.tmp.owl $(TMPDIR)/$@.owl; fi


## ONTOLOGY: pco
.PHONY: mirror-pco
.PRECIOUS: $(MIRRORDIR)/pco.owl
mirror-pco: | $(TMPDIR)
	if [ $(MIR) = true ] && [ $(IMP) = true ]; then curl -L $(OBO_URIBASE)/pco.owl --create-dirs -o $(MIRRORDIR)/pco.owl --retry 4 --max-time 200 &&\
		$(ROBOT) convert -i $(MIRRORDIR)/pco.owl -o $@.tmp.owl &&\
		mv $@.tmp.owl $(TMPDIR)/$@.owl; fi


## ONTOLOGY: ncbitaxon
.PHONY: mirror-ncbitaxon
.PRECIOUS: $(MIRRORDIR)/ncbitaxon.owl
mirror-ncbitaxon: | $(TMPDIR)
	if [ $(MIR) = true ] && [ $(IMP) = true ] && [ $(IMP_LARGE) = true ]; then curl -L $(OBO_URIBASE)/ncbitaxon.owl.gz --create-dirs -o $(MIRRORDIR)/ncbitaxon.owl.gz --retry 4 --max-time 200 &&\
		$(ROBOT) convert -i $(MIRRORDIR)/ncbitaxon.owl.gz -o $@.tmp.owl &&\
		mv $@.tmp.owl $(TMPDIR)/$@.owl; fi


## ONTOLOGY: chebi
.PHONY: mirror-chebi
.PRECIOUS: $(MIRRORDIR)/chebi.owl
mirror-chebi: | $(TMPDIR)
	if [ $(MIR) = true ] && [ $(IMP) = true ] && [ $(IMP_LARGE) = true ]; then curl -L $(OBO_URIBASE)/chebi.owl.gz --create-dirs -o $(MIRRORDIR)/chebi.owl.gz --retry 4 --max-time 200 &&\
		$(ROBOT) convert -i $(MIRRORDIR)/chebi.owl.gz -o $@.tmp.owl &&\
		mv $@.tmp.owl $(TMPDIR)/$@.owl; fi


## ONTOLOGY: go
.PHONY: mirror-go
.PRECIOUS: $(MIRRORDIR)/go.owl
mirror-go: | $(TMPDIR)
	if [ $(MIR) = true ] && [ $(IMP) = true ] && [ $(IMP_LARGE) = true ]; then curl -L $(OBO_URIBASE)/go.owl --create-dirs -o $(MIRRORDIR)/go.owl --retry 4 --max-time 200 &&\
		$(ROBOT) convert -i $(MIRRORDIR)/go.owl -o $@.tmp.owl &&\
		mv $@.tmp.owl $(TMPDIR)/$@.owl; fi


$(MIRRORDIR)/%.owl: mirror-% | $(MIRRORDIR)
	if [ $(IMP) = true ] && [ $(MIR) = true ] && [ -f $(TMPDIR)/mirror-$*.owl ]; then if cmp -s $(TMPDIR)/mirror-$*.owl $@ ; then echo "Mirror identical, ignoring."; else echo "Mirrors different, updating." &&\
		cp $(TMPDIR)/mirror-$*.owl $@; fi; fi




# ----------------------------------------
# Subsets
# ----------------------------------------
$(SUBSETDIR)/%.tsv: $(SUBSETDIR)/%.owl
	$(ROBOT) query -f tsv -i $< -s ../sparql/labels.sparql $@
.PRECIOUS: $(SUBSETDIR)/%.tsv

$(SUBSETDIR)/%.owl: $(ONT).owl | $(SUBSETDIR)
	$(OWLTOOLS) $< --extract-ontology-subset --fill-gaps --subset $* -o $@.tmp.owl && mv $@.tmp.owl $@ &&\
	$(ROBOT) annotate --input $@ --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) -o $@.tmp.owl && mv $@.tmp.owl $@
.PRECIOUS: $(SUBSETDIR)/%.owl



# ---------------------------------------------
# Sparql queries: Table exports / Query Reports
# ---------------------------------------------

SPARQL_EXPORTS_ARGS = $(foreach V,$(SPARQL_EXPORTS),-s $(SPARQLDIR)/$(V).sparql $(REPORTDIR)/$(V).tsv)
# This combines all into one single command

.PHONY: custom_reports
custom_reports: $(SRC) | $(REPORTDIR)
ifneq ($(SPARQL_EXPORTS_ARGS),)
	$(ROBOT) query -f tsv --use-graphs true -i $< $(SPARQL_EXPORTS_ARGS)
endif

# ----------------------------------------
# Release artefacts: export formats
# ----------------------------------------


# ----------------------------------------
# Release artefacts: main release artefacts
# ----------------------------------------

$(ONT).owl: $(ONT)-full.owl
	$(ROBOT) annotate --input $< --ontology-iri $(URIBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) \
		convert -o $@.tmp.owl && mv $@.tmp.owl $@

# -----------------------------------------------------
# Release artefacts: variants (base, full, simple, etc)
# -----------------------------------------------------
SHARED_ROBOT_COMMANDS = 

$(ONTOLOGYTERMS): $(SRC) $(OTHER_SRC)
	touch $(ONTOLOGYTERMS) && \
	$(ROBOT) query --use-graphs true -f csv -i $< --query ../sparql/sfwo_terms.sparql $@

# base: OTHER sources of interest, such as definitions owl
$(ONT)-base.owl: $(SRC) $(OTHER_SRC)
	$(ROBOT) remove --input $< --select imports --trim false \
		merge $(patsubst %, -i %, $(OTHER_SRC)) \
		 $(SHARED_ROBOT_COMMANDS) annotate --link-annotation http://purl.org/dc/elements/1.1/type http://purl.obolibrary.org/obo/IAO_8000001 \
		--ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) \
		--output $@.tmp.owl && mv $@.tmp.owl $@

# Full: The full artefacts with imports merged, reasoned
$(ONT)-full.owl: $(SRC) $(OTHER_SRC) $(IMPORT_FILES)
	$(ROBOT) merge --input $< \
		reason --reasoner ELK --equivalent-classes-allowed asserted-only --exclude-tautologies structural \
		relax \
		reduce -r ELK \
		$(SHARED_ROBOT_COMMANDS) annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@

# ----------------------------------------
# Debugging Tools
# ----------------------------------------

explain_unsat: $(SRC) 
	$(ROBOT) explain -i $(SRC) -M unsatisfiability --unsatisfiable random:10 --explanation $(TMPDIR)/$@.md



# ----------------------------------------
# General Validation
# ----------------------------------------
TSV=
ALL_TSV_FILES=

validate-tsv: $(TSV) | $(TMPDIR)
	for FILE in $< ; do \
		tsvalid $$FILE > $(TMPDIR)/validate.txt; \
		if [ -s $(TMPDIR)/validate.txt ]; then cat $(TMPDIR)/validate.txt && exit 1; fi ; \
	done

validate-all-tsv: $(ALL_TSV_FILES)
	$(MAKE) validate-tsv TSV="$^"

# ----------------------------------------
# Editors Utilities
# ----------------------------------------



.PHONY: normalize_src
normalize_src: $(SRC)
	$(ROBOT) convert -i $< -f ofn -o $(TMPDIR)/normalise && mv $(TMPDIR)/normalise $<

.PHONY: validate_idranges
validate_idranges:
	amm $(SCRIPTSDIR)/validate_id_ranges.sc sfwo-idranges.owl

.PHONY: update_repo
update_repo:
	sh $(SCRIPTSDIR)/update_repo.sh
	


# Note to future generations: prepending ./ is a safety measure to ensure that 
# the environment does not malicously set `CLEANFILES` to `\`.
.PHONY: clean
clean:
	[ -n "$(MIRRORDIR)" ] && [ $(MIRRORDIR) != "." ] && [ $(MIRRORDIR) != "/" ] && [ $(MIRRORDIR) != ".." ] && [ -d ./$(MIRRORDIR) ] && rm -rf ./$(MIRRORDIR)/*
	[ -n "$(TMPDIR)" ] && [ $(TMPDIR) != "." ] && [ $(TMPDIR) != "/" ] && [ $(TMPDIR) != ".." ] && [ -d ./$(TMPDIR) ] && rm -rf ./$(TMPDIR)/*
	rm -f $(CLEANFILES)

.PHONY: help
help:
	@echo "$$data"

define data
Usage: [IMAGE=(odklite|odkfull)] [ODK_DEBUG=yes] sh run.sh make [(IMP|MIR|IMP_LARGE|PAT)=(false|true)] command

----------------------------------------
	Command reference
----------------------------------------

Core commands:
* prepare_release:	Run the entire release pipeline. Use make IMP=false prepare_release to avoid rerunning the imports
* prepare_release_fast:	Run the entire release pipeline without refreshing imports, recreating components or recompiling patterns.
* update_repo:		Update the ODK repository setup using the config file sfwo-odk.yaml
* test:			Running all validation tests
* odkversion:		Show the current version of the ODK Makefile and ROBOT.
* clean:		Delete all temporary files
* help:			Print ODK Usage information


Imports management:
* refresh-imports:			Refresh all imports and mirrors.
* refresh-components:			Refresh all components.
* no-mirror-refresh-imports:		Refresh all imports without downloading mirrors.
* refresh-imports-excluding-large:	Refresh all imports and mirrors, but skipping the ones labelled as 'is_large'.
* refresh-%:				Refresh a single import, i.e. refresh-go will refresh 'imports/go_import.owl'.
* no-mirror-refresh-%:			Refresh a single import without updating the mirror, i.e. refresh-go will refresh 'imports/go_import.owl'.
* mirror-%:				Refresh a single mirror.

Editor utilities:
* validate_idranges:	Make sure your ID ranges file is formatted correctly
* normalize_src:	Load and safe your sfwo-edit file after you to make sure its serialised correctly
* explain_unsat:	If you have unsatisfiable classes, this command will create a markdown file (tmp/explain_unsat.md) which will explain all your unsatisfiable classes
* validate-all-tsv:	Check all your tsv files for possible problems in syntax. Use ALL_TSV_FILES variable to list files
* validate-tsv:		Check a tsv file for syntactic problems with tsvalid. Use TSV variable to pass filepath, e.g. make TSV=../my.tsv validate-tsv.

Additional build commands (advanced users)
* all:			Run the entire pipeline (like prepare_release), but without copying the release files to the release directory.
* all_subsets:		Build all subsets
* custom_reports:	Generate all custom sparql reports you have configured in your sfwo-odk.yaml file.
* all_assets:		Build all assets
* show_assets:		Print a list of all assets that would be build by the release pipeline

Additional QC commands (advanced users)
* robot_reports:	Run all configured ROBOT reports
* validate_profile_%:	Run an OWL2 DL profile validation check, for example validate_profile_sfwo-edit.owl.

Examples: 
* sh run.sh make IMP=false prepare_release
* sh run.sh make update_repo
* sh run.sh make test

Tricks:
* Add -B to the end of your command to force re-running it even if nothing has changed
* Use the IMAGE parameter to the run.sh script to use a different image like odklite
* Use ODK_DEBUG=yes sh run.sh make ... to print information about timing and debugging

endef
export data

include sfwo.Makefile