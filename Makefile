all:
	docker build --tag cadizm/dev-env .

run:
	docker-compose run --rm --workdir="/src" dev-env

push:
	docker push cadizm/dev-env

.PHONY: all run push
