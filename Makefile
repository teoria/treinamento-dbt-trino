
 
status: ## Status dos containers
	docker ps
ps: ## Status dos containers
	docker ps

install_dependencies: ## Instala dependências para o projeto 
	@make create_env
	@make pip_install
 
create_env:  
	python3 -m venv venv_dbt
 
pip_install:  
	. ./venv_dbt/bin/activate
	venv_dbt/bin/pip install dbt-core dbt-postgres dbt-trino dbt-metricflow

start: ## Inicia Postgres
	docker compose -f devops/docker-compose.yaml up -d  

stop: ## Desliga Metabase
	docker compose -f devops/docker-compose.yaml down  
debug:
	dbt debug --profiles-dir .dbt
clean:
	rm -rf venv target
 
#################################################################################
# Self Documenting Commands                                                     #
#################################################################################

.DEFAULT_GOAL := help

# Inspired by <http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html>
# sed script explained:
# /^##/:
# 	* save line in hold space
# 	* purge line
# 	* Loop:
# 		* append newline + line to hold space
# 		* go to next line
# 		* if line starts with doc comment, strip comment character off and loop
# 	* remove target prerequisites
# 	* append hold space (+ newline) to line
# 	* replace newline plus comments by `---`
# 	* print line
# Separate expressions are necessary because labels cannot be delimited by
# semicolon; see <http://stackoverflow.com/a/11799865/1968>
.PHONY: help

                                                          

help:
	@echo '**************************************************************************'
	@echo '  _         _             _       _                _ _     _    '
	@echo ' | |       | |           (_)     | |              | | |   | |   '
	@echo ' | |_ _   _| |_ ___  _ __ _  __ _| |  ______    __| | |__ | |_  '
	@echo ' | __| | | | __/ _ \| |__| |/ _` | | |______|  / _` | |_ \| __| '
	@echo ' | |_| |_| | || (_) | |  | | (_| | |          | (_| | |_) | |_  '
	@echo '  \__|\__,_|\__\___/|_|  |_|\__,_|_|           \__,_|_.__/ \__| '
 

	@echo ' ' 
	@echo '**************************************************************************'
	@echo '   '
	@echo Comandos disponíveis
	@echo '   '
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'