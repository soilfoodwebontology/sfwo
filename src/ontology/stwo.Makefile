## Customize Makefile settings for stwo
##
## If you need to customize your Makefile, make
## changes here rather than in the main Makefile

imports/ecocore_import.owl: mirror/ecocore.owl imports/ecocore_terms_combined.txt
	@if [ $(IMP) = true ]; then $(ROBOT) extract -i $< -L imports/ecocore_terms_combined.txt --force true --method MIREOT \
	  remove --select "parents" --select "FOODON:*" --trim true \
		remove --term RO:0002410 --term RO:0002328 --axioms "subproperty" --preserve-structure false --trim true \
		query --update ../sparql/inject-subset-declaration.ru \
		annotate --ontology-iri $(ONTBASE)/$@ --version-iri $(ONTBASE)/releases/$(TODAY)/$@ --output $@.tmp.owl && mv $@.tmp.owl $@; fi
.PRECIOUS: imports/ecocore_import.owl

imports/ro_import.owl: mirror/ro.owl imports/ro_terms_combined.txt
	@if [ $(IMP) = true ]; then $(ROBOT) extract -i $< --term-file imports/ro_terms_combined.txt --force true --method TOP \
		filter --term "RO:0002321" --select "annotations self descendants" --axioms all --preserve-structure true --signature true \
		query --update ../sparql/inject-subset-declaration.ru \
		annotate --ontology-iri $(ONTBASE)/$@ --version-iri $(ONTBASE)/releases/$(TODAY)/$@ --output $@.tmp.owl && mv $@.tmp.owl $@; fi
.PRECIOUS: imports/ro_import.owl

imports/envo_import.owl: mirror/envo.owl imports/envo_terms_combined.txt
	@if [ $(IMP) = true ]; then $(ROBOT) extract -i $< -L imports/envo_terms_combined.txt --force true --method MIREOT \
		remove --select "parents" --select "FOODON:*" --trim true \
		remove --term PATO:0001237 --term PATO:0000001 --trim true \
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
		query --update ../sparql/inject-subset-declaration.ru \
		annotate --ontology-iri $(ONTBASE)/$@ --version-iri $(ONTBASE)/releases/$(TODAY)/$@ --output $@.tmp.owl && mv $@.tmp.owl $@; fi
.PRECIOUS: imports/uberon_import.owl

imports/fao_import.owl: mirror/fao.owl imports/fao_terms_combined.txt
	@if [ $(IMP) = true ]; then $(ROBOT) extract -i $< -L imports/fao_terms_combined.txt --force true --method MIREOT \
		remove --term FAO:0002004 --trim true \
		query --update ../sparql/inject-subset-declaration.ru \
		annotate --ontology-iri $(ONTBASE)/$@ --version-iri $(ONTBASE)/releases/$(TODAY)/$@ --output $@.tmp.owl && mv $@.tmp.owl $@; fi
.PRECIOUS: imports/fao_import.owl

imports/ncbitaxon_import.owl: mirror/ncbitaxon.owl imports/ncbitaxon_terms_combined.txt
	@if [ $(IMP) = true ]; then $(ROBOT) extract -i $< -L imports/ncbitaxon_terms_combined.txt --force true --method MIREOT \
		query --update ../sparql/inject-subset-declaration.ru \
		annotate --ontology-iri $(ONTBASE)/$@ --version-iri $(ONTBASE)/releases/$(TODAY)/$@ --output $@.tmp.owl && mv $@.tmp.owl $@; fi
.PRECIOUS: imports/ncbitaxon_import.owl

$(ONT)-full.owl: $(SRC) $(OTHER_SRC)
	$(ROBOT) merge --input $< \
		reason --reasoner ELK --equivalent-classes-allowed all \
		reduce -r ELK \
		annotate --ontology-iri $(ONTBASE)/$@ --version-iri $(ONTBASE)/releases/$(TODAY)/$@ --output $@.tmp.owl && mv $@.tmp.owl $@
