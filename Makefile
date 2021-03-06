.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

test: ## Run tests
	@echo "\033[92mTesting...\033[0m"
	@docker-compose run --rm django py.test

isort: ## Sorts the imports
	isort -rc .

clean: ## Deletes unneded files (*.pyc, *.DS_Store, etc.)
	find . -name "*.pyc" -exec rm -f {} \;
	find . -name "*.DS_Store" -exec rm -f {} \;

pep8: ## PEP8 Check with Flake8
	flake8 --statistics --exit-zero

build: isort clean pep8 test  ## Prepares built (isort, clean, PEP8 check, testing)
	@echo "\033[1;91mPrepares a changed codebase...\033[0m"

deploy: ## Deploy to Heroku
	@echo "\x1b[31;01mNot implemented yet!\033[0m"

install: ## Local installation for developers
	@echo "Please start local_setup.py for now."

docker-build: ## Builds the Docker container
	@docker-compose build

docker-start: ## Start the Docker container
	@docker-compose up -d

docker-stop: ## Stop the Docker container
	@docker-compose stop

docker-status: ## See the status of the Docker Container
	@docker-compose ps

docker-restart:	docker-stop docker-start	## Restart the Docker container

pip-compile: ## Creates new pip requirement files, add  --generate-hashes
	@echo "\033[92mCreating new requirement-files from *.in-Files...\033[0m"
	pip-compile --output-file requirements/base.txt requirements/base.in
	pip-compile --output-file requirements/circleci.txt requirements/circleci.in
	pip-compile --output-file requirements/local.txt requirements/local.in
	pip-compile --output-file requirements/production.txt requirements/production.in
	pip-compile --output-file requirements/documentation.txt requirements/documentation.in
	@echo "\nYou can use 'make pip-update' to update the requirements and 'make pip-install to install the requirments locally"

pip-update: ## Updates the pip requirements, add  --generate-hashes
	@echo "\033[92mUpdating all pip requirements...\033[0m"
	pip-compile -U --output-file requirements/base.txt requirements/base.in
	pip-compile -U --output-file requirements/circleci.txt requirements/circleci.in
	pip-compile -U --output-file requirements/local.txt requirements/local.in
	pip-compile -U --output-file requirements/production.txt requirements/production.in
	pip-compile -U --output-file requirements/documentation.txt requirements/documentation.in

pip-install: ## Install the local requirement files
	@echo "Please start local_setup.py for now."
	pip install -r requirements/local.txt

django-shell: # Opens the Django shell
	docker-compose run django python manage.py shell_plus

django-bash: # Opens the Django bash
	docker-compose run django bash

colors:
	@echo "\033[92mGreen!\033[0m"
	@echo "\x1b[33;01mYellow!\033[0m"
	@echo "\x1b[31;01mRed!\033[0m"

#release: ## Release the given version
#ifndef version
#	$(error Please supply a version)
#endif
#	@echo Releasing version $(version)
#ifeq (,$(findstring $(version),$(shell git log --oneline -1)))
#	$(error Last commit does not match version)
#endif
#	git tag $(version)
#	git push
#	git push --tags
#	python setup.py sdist bdist_wheel upload

