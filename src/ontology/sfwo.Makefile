## Customize Makefile settings for sfwo
##
## If you need to customize your Makefile, make
## changes here rather than in the main Makefile

$(IMPORTDIR)/ro_import.owl: $(MIRRORDIR)/ro.owl $(IMPORTDIR)/ro_terms_combined.txt
	if [ $(IMP) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module.ru \
			extract -T $(IMPORTDIR)/ro_terms_combined.txt --force true --copy-ontology-annotations true --individuals include --method BOT \
			remove --term "RO:0002464" --term "GO:0003674" --select "self descendants domains ranges" --axioms all --preserve-structure true --signature true \
			query --update ../sparql/inject-subset-declaration.ru --update ../sparql/postprocess-module.ru \
			annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi
			
$(IMPORTDIR)/envo_import.owl: $(MIRRORDIR)/envo.owl $(IMPORTDIR)/envo_terms_combined.txt
	if [ $(IMP) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module.ru \
			extract -L $(IMPORTDIR)/envo_terms.txt --imports exclude --force true --copy-ontology-annotations true --individuals include --method MIREOT \
			remove --term "ENVO:01000814" --select "self" --axioms all --preserve-structure true --signature true \
			remove --select "object-properties data-properties" --axioms all --preserve-structure true --signature true \
			query --update ../sparql/inject-subset-declaration.ru --update ../sparql/postprocess-module.ru \
			annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi
			
$(IMPORTDIR)/po_import.owl: $(MIRRORDIR)/po.owl $(IMPORTDIR)/po_terms_combined.txt
	if [ $(IMP) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module.ru \
			extract -L $(IMPORTDIR)/po_terms_combined.txt --imports exclude  --force true --copy-ontology-annotations true --individuals include --method MIREOT \
			remove --select "object-properties data-properties" --axioms all --preserve-structure true --signature true \
			query --update ../sparql/inject-subset-declaration.ru --update ../sparql/postprocess-module.ru \
			annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi
			
$(IMPORTDIR)/ecocore_import.owl: $(MIRRORDIR)/ecocore.owl $(IMPORTDIR)/ecocore_terms.txt $(IMPORTDIR)/ecocore_terms_exclude.txt
	if [ $(IMP) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module.ru \
		extract -L $(IMPORTDIR)/ecocore_terms.txt --branch-from-terms $(IMPORTDIR)/ecocore_terms.txt --force true --copy-ontology-annotations true --individuals include --method MIREOT \
		remove --term-file $(IMPORTDIR)/ecocore_terms_exclude.txt --select "self descendants" --axioms all --preserve-structure true --signature true \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/postprocess-module.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi
		
$(IMPORTDIR)/pato_import.owl: $(MIRRORDIR)/pato.owl $(IMPORTDIR)/pato_terms_combined.txt
	if [ $(IMP) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module.ru \
		extract -L $(IMPORTDIR)/pato_terms.txt --force true --copy-ontology-annotations true --individuals include --method MIREOT \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/postprocess-module.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi

$(IMPORTDIR)/pco_import.owl: $(MIRRORDIR)/pco.owl $(IMPORTDIR)/pco_terms_combined.txt
	if [ $(IMP) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module.ru \
		extract -T $(IMPORTDIR)/pco_terms.txt --force true --copy-ontology-annotations true --individuals include --method BOT \
		remove --term "IAO:0000030" --term "GO:0003674" --term "RO:0002464" --select "self descendants " --axioms all --preserve-structure true --signature true \
		remove --select "individuals" --axioms all --preserve-structure true --signature true \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/postprocess-module.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi

$(IMPORTDIR)/uberon_import.owl: $(MIRRORDIR)/uberon.owl $(IMPORTDIR)/uberon_terms_combined.txt
	if [ $(IMP) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module.ru \
		extract -L $(IMPORTDIR)/uberon_terms.txt --force true --copy-ontology-annotations true --individuals include --method MIREOT \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/postprocess-module.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi

$(IMPORTDIR)/chebi_import.owl: $(MIRRORDIR)/chebi.owl $(IMPORTDIR)/chebi_terms_combined.txt
	if [ $(IMP) = true ]; then $(ROBOT) query -i $< --update ../sparql/preprocess-module.ru \
		extract -L imports/chebi_terms_combined.txt --force true --copy-ontology-annotations true --individuals include --method MIREOT \
		query --update ../sparql/inject-subset-declaration.ru --update ../sparql/postprocess-module.ru \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi