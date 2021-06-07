################################################
#### Commands for building the Docker image ####
################################################

VERSION = "0.0.1"
IM=monarchinitiative/ontomatch

docker-build-no-cache:
	@docker build --no-cache -t $(IM):$(VERSION) . \
	&& docker tag $(IM):$(VERSION) $(IM):latest

docker-build:
	@docker build -t $(IM):$(VERSION) . \
	&& docker tag $(IM):$(VERSION) $(IM):latest
	
docker-build-use-cache-dev:
	@docker build -t $(DEV):$(VERSION) . \
	&& docker tag $(DEV):$(VERSION) $(DEV):latest

docker-clean:
	docker kill $(IM) || echo not running ;
	docker rm $(IM) || echo not made 

docker-publish-no-build:
	@docker push $(IM):$(VERSION) \
	&& docker push $(IM):latest
	
docker-publish-dev-no-build:
	@docker push $(DEV):$(VERSION) \
	&& docker push $(DEV):latest
	
docker-publish: docker-build
	@docker push $(IM):$(VERSION) \
	&& docker push $(IM):latest

TEST_O1_LOCAL=tests/test.mp.owl
TEST_O2_LOCAL=tests/test.hp.owl
TEST_O1=/work/$(TEST_O1_LOCAL)
TEST_O2=/work/$(TEST_O2_LOCAL)
OUTDIR=out

tests/test.%.owl: mirror/%.owl
	$(ROBOT) merge --input $< \
		reason --reasoner ELK --equivalent-classes-allowed asserted-only --exclude-tautologies structural \
		relax \
		remove --axioms equivalent \
		relax \
		filter --select "annotations ontology classes self" --trim true --signature true \
		reduce -r ELK \
		annotate --ontology-iri $(ONTBASE)/$@ $(ANNOTATE_ONTOLOGY_VERSION) --annotation oboInOwl:date "$(OBODATE)" --output $@.tmp.owl && mv $@.tmp.owl $@


test-logmap:
	rm -rf $(OUTDIR)/$@ && mkdir $(OUTDIR)/$@ &&\
	sh run.sh logmap $(TEST_O1) $(TEST_O2) /work/$(OUTDIR)/$@ true

test-aml:
	rm -rf $(OUTDIR)/$@ && mkdir $(OUTDIR)/$@ &&\
	sh run.sh aml $(TEST_O1) $(TEST_O2) /work/$(OUTDIR)/$@ -a

test-paxo:
	rm -rf $(OUTDIR)/$@ && mkdir $(OUTDIR)/$@ &&\
	sh run.sh paxo tests/paxo_config.ini -s

tests/merged.test.owl: $(TEST_O1_LOCAL) $(TEST_O2_LOCAL)
	robot merge -i $(TEST_O1_LOCAL) -i $(TEST_O2_LOCAL) annotate --ontology-iri "http://ontomatch.test/$@" -o $@

test-rdfmatcher: tests/merged.test.owl
	rm -rf $(OUTDIR)/$@ && mkdir $(OUTDIR)/$@ &&\
	sh run.sh rdfmatcher $< /work/$(OUTDIR)/$@ --predicate skos:exactMatch

test: test-logmap test-aml test-rdfmatcher

