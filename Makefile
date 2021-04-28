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

test-logmap:
	sh run.sh logmap MATCHER file:/work/tests/ecto.test.owl file:/work/tests/ecto.test.owl  out/ true

test-aml:
	sh run.sh aml -s /work/tests/ecto.test.owl -t /work/tests/ecto.test.owl  -o out/ecto.aml.xml -a

test: test-logmap test-aml

