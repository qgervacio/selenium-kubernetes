-include ./resources/creds

.DEFAULT_GOAL: help

.PHONY: help clean generate deploy delete

help:
	@echo "Usage:"
	@echo "help ----- Display targets"
	@echo "clean ---- Delete YAML files"
	@echo "generate - Clean then generate YAML files"
	@echo "deploy --- Generate, deploy Selenium then clean"
	@echo "delete --- Clean then delete Selenium"

clean:
	@rm -rf *.yaml *.yml

generate:
	@make clean
	@j2 -f json resources/hub.j2 resources/cfg.json > hub.yaml
	@j2 -f json resources/chrome.j2 resources/cfg.json > chrome.yaml
	@j2 -f json resources/firefox.j2 resources/cfg.json > firefox.yaml

deploy:
	@make generate
	@oc apply -f . -n "${OCPNAM}" --server="${OCPURL}" --token="${OCPTKN}" --insecure-skip-tls-verify="true"
	@make clean

delete:
	@make clean
	-oc delete all --selector app=selenium -n "${OCPNAM}" --server="${OCPURL}" --token="${OCPTKN}" --insecure-skip-tls-verify="true"
