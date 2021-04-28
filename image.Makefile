GAT_URL="https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/google-api-translate-java/google-api-translate-java-0.97.jar"
TOOLS_DIR=/tools
TMP_DIR=tmp

$(TMP_DIR)/google-api-translate-java-0.97.jar:  | $(TMP_DIR)/
	wget "$(GAT_URL)" -O $@
	mvn install:install-file -Dfile=$(PWD)/$@ -DgroupId=com.googlecode -DartifactId=google-api-translate-java -Dversion=0.97 -Dpackaging=jar

$(TMP_DIR)/:
	mkdir -p $@

$(TMP_DIR)/logmap-matcher/target/logmap-matcher-$(LOGMAP_VERSION).jar: $(TMP_DIR)/google-api-translate-java-0.97.jar | $(TMP_DIR)/
	cd tmp && rm -rf logmap-matcher && git clone https://github.com/ernestojimenezruiz/logmap-matcher \
	&& cd logmap-matcher && mvn clean package

$(TOOLS_DIR)/logmap.jar: $(TMP_DIR)/logmap-matcher/target/logmap-matcher-$(LOGMAP_VERSION).jar
	cp $< $@

$(TOOLS_DIR)/aml.jar:
	wget $(AML_ZIP) -O $(TMP_DIR)/aml.zip && cd tmp && rm -rf AML_v$(AML_VERSION) && unzip aml.zip && cd .. && cp $(TMP_DIR)/AML_v$(AML_VERSION)/AgreementMakerLight.jar $@

$(TOOLS_DIR)/paxo_tool:
	mkdir -p $@/ && cd $(TMP_DIR)/ && git clone https://github.com/EBISPOT/OXO && cd .. && cp -r $(TMP_DIR)/OXO/paxo-loader/* $@/

$(TOOLS_DIR)/rdf_matcher:
	cd $(TOOLS_DIR)/ && rm -rf rdf_matcher && git clone https://github.com/cmungall/rdf_matcher

$(TOOLS_DIR)/logmap_ml:
	mkdir -p $@/ && cd $(TMP_DIR)/ && git clone https://github.com/KRR-Oxford/OntoAlign && cd .. && cp -r $(TMP_DIR)/OntoAlign/LogMap-ML/* $@/

dependencies: $(TOOLS_DIR)/logmap.jar $(TOOLS_DIR)/aml.jar $(TOOLS_DIR)/paxo_tool $(TOOLS_DIR)/rdf_matcher $(TOOLS_DIR)/logmap_ml

clean:
	rm -rf $(TMP_DIR)