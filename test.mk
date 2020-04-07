include Makefile

TAGS=--tag "test-id:$(shell cat /tmp/test-uuid.txt)"

CMD_PREPARE=\
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get -qq update && \
  apt-get -qq install -y --no-install-recommends pandoc >/dev/null

CMD_NBCONVERT=\
  $(JUPYTER_SCREEN) \
  jupyter nbconvert \
  --execute \
  --no-prompt \
  --no-input \
  --to=asciidoc \
  --ExecutePreprocessor.timeout=600 \
  --output=/tmp/out \
  $(PROJECT_PATH_ENV)/$(NOTEBOOKS_DIR)/mountain_car_dqn.ipynb && \
  echo "Test succeeded: PROJECT_PATH_ENV=$(PROJECT_PATH_ENV) TRAINING_MACHINE_TYPE=$(TRAINING_MACHINE_TYPE)"


.PHONY: generate_random_uuid
generate_random_uuid:
	uuidgen > /tmp/test-uuid.txt

.PHONY: test_jupyter
test_jupyter: JUPYTER_CMD=bash -c '$(CMD_PREPARE) && $(CMD_NBCONVERT)'
test_jupyter: RUN_EXTRA=$(TAGS)
test_jupyter: jupyter

.PHONY: test_jupyter_baked
test_jupyter_baked: PROJECT_PATH_ENV=/project-local
test_jupyter_baked:
	neuro run \
		--preset $(TRAINING_MACHINE_TYPE) \
		$(TAGS) \
		$(CUSTOM_ENV_NAME) \
		bash -c '$(CMD_PREPARE) && $(CMD_NBCONVERT)'