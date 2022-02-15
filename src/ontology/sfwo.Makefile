## Customize Makefile settings for sfwo
##
## If you need to customize your Makefile, make
## changes here rather than in the main Makefile

imports/ecocore_import.owl: mirror/ecocore.owl imports/ecocore_terms_combined.txt
	@if [ $(IMP) = true ]; then $(ROBOT) extract -i $< -L imports/ecocore_terms_combined.txt --force true --method MIREOT \
	  remove --select "parents" --select "FOODON:*" --trim true \
		remove --term RO:0002410 --term RO:0002328 --axioms "subproperty" --preserve-structure false --trim true \
		remove --term-file imports/ecocore_exclude_terms.txt --select "self" --preserve-structure false \
		remove --term-file imports/chebi_exclude_terms.txt --select "self" --preserve-structure false \
		query --update ../sparql/inject-subset-declaration.ru \
		annotate --ontology-iri $(ONTBASE)/$@ --version-iri $(ONTBASE)/releases/$(TODAY)/$@ --output $@.tmp.owl && mv $@.tmp.owl $@; fi
.PRECIOUS: imports/ecocore_import.owl

imports/ro_import.owl: mirror/ro.owl imports/ro_terms_combined.txt
	@if [ $(IMP) = true ]; then $(ROBOT) extract -i $< --term-file imports/ro_terms_combined.txt --force true --method TOP \
		filter --term "RO:0002487" --term "RO:0002321" --term "RO:0003001" --term "RO:0000086" --select "annotations self descendants" --axioms all --preserve-structure true --signature true \
		query --update ../sparql/inject-subset-declaration.ru \
		annotate --ontology-iri $(ONTBASE)/$@ --version-iri $(ONTBASE)/releases/$(TODAY)/$@ --output $@.tmp.owl && mv $@.tmp.owl $@; fi
.PRECIOUS: imports/ro_import.owl

imports/envo_import.owl: mirror/envo.owl imports/envo_terms_combined.txt
	@if [ $(IMP) = true ]; then $(ROBOT) extract -i $< -L imports/envo_terms_combined.txt --force true --method MIREOT \
		remove --select "parents" --select "FOODON:*" --trim true \
		remove --term PATO:0001237 --term PATO:0000001 --trim true \
		remove --term-file imports/chebi_exclude_terms.txt --select "self" --preserve-structure false \
		query --update ../sparql/inject-subset-declaration.ru \
		annotate --ontology-iri $(ONTBASE)/$@ --version-iri $(ONTBASE)/releases/$(TODAY)/$@ --output $@.tmp.owl && mv $@.tmp.owl $@; fi
.PRECIOUS: imports/envo_import.owl

imports/po_import.owl: mirror/po.owl imports/po_terms_combined.txt
	@if [ $(IMP) = true ]; then $(ROBOT) extract -i $< -L imports/po_terms_combined.txt --force true --method MIREOT \
		remove --select "parents" --select "BFO:*" --axioms "subclass" --preserve-structure false --trim true \
		remove --term PO:0025131 --select "parents" --axioms "subclass" --signature true --trim true \
		query --update ../sparql/inject-subset-declaration.ru \
		annotate --ontology-iri $(ONTBASE)/$@ --version-iri $(ONTBASE)/releases/$(TODAY)/$@ --output $@.tmp.owl && mv $@.tmp.owl $@; fi
.PRECIOUS: imports/po_import.owl

imports/pato_import.owl: mirror/pato.owl imports/pato_terms_combined.txt
	@if [ $(IMP) = true ]; then $(ROBOT) extract -i $< -L imports/pato_terms_combined.txt --force true --method MIREOT \
		remove --term PATO:0001237 --term PATO:0000001 --trim true \
		query --update ../sparql/inject-subset-declaration.ru \
		annotate --ontology-iri $(ONTBASE)/$@ --version-iri $(ONTBASE)/releases/$(TODAY)/$@ --output $@.tmp.owl && mv $@.tmp.owl $@; fi
.PRECIOUS: imports/pato_import.owl

imports/uberon_import.owl: mirror/uberon.owl imports/uberon_terms_combined.txt
	@if [ $(IMP) = true ]; then $(ROBOT) extract -i $< -L imports/uberon_terms_combined.txt --force true --method MIREOT \
		remove --term-file imports/chebi_exclude_terms.txt --select "self" --preserve-structure true \
		query --update ../sparql/inject-subset-declaration.ru \
		annotate --ontology-iri $(ONTBASE)/$@ --version-iri $(ONTBASE)/releases/$(TODAY)/$@ --output $@.tmp.owl && mv $@.tmp.owl $@; fi
.PRECIOUS: imports/uberon_import.owl

imports/fao_import.owl: mirror/fao.owl imports/fao_terms_combined.txt
	@if [ $(IMP) = true ]; then $(ROBOT) extract -i $< -L imports/fao_terms_combined.txt --force true --method MIREOT \
		remove --term FAO:0002004 --trim true \
		query --update ../sparql/inject-subset-declaration.ru \
		annotate --ontology-iri $(ONTBASE)/$@ --version-iri $(ONTBASE)/releases/$(TODAY)/$@ --output $@.tmp.owl && mv $@.tmp.owl $@; fi
.PRECIOUS: imports/fao_import.owl

imports/chebi_import.owl: mirror/chebi.owl imports/chebi_terms_combined.txt imports/chebi_exclude_terms.txt
	@if [ $(IMP) = true ]; then $(ROBOT) extract -i $< -L imports/chebi_terms_combined.txt --intermediates minimal --force true --method MIREOT \
		remove --term-file imports/chebi_exclude_terms.txt --select self --preserve-structure true \
		query --update ../sparql/inject-subset-declaration.ru \
		annotate --ontology-iri $(ONTBASE)/$@ --version-iri $(ONTBASE)/releases/$(TODAY)/$@ --output $@.tmp.owl && mv $@.tmp.owl $@; fi
.PRECIOUS: imports/chebi_import.owl

## Overwrite ODK default for NCBITaxon
## See : https://github.com/INCATools/ontology-development-kit/blob/master/docs/DealWithLargeOntologies.md

imports/ncbitaxon_import.owl: mirror/ncbitaxon.owl imports/ncbitaxon_terms_combined.txt
	if [ $(IMP) = true ]; then $(ROBOT) extract -i $< -L imports/ncbitaxon_terms_combined.txt --force true --method MIREOT \
		remove --term-file imports/ncbitaxon_exclude_terms.txt --select "self" --preserve-structure false \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --output $@.tmp.owl && mv $@.tmp.owl $@; fi
.PRECIOUS: imports/ncbitaxon_import.owl


$(ONT)-full.owl: $(SRC) $(OTHER_SRC)
	$(ROBOT) merge --input $< \
		reason --reasoner ELK --equivalent-classes-allowed all \
		reduce -r ELK \
		annotate --ontology-iri $(ONTBASE)/$@ --version-iri $(ONTBASE)/releases/$(TODAY)/$@ --output $@.tmp.owl && mv $@.tmp.owl $@
