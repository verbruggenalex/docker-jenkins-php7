health:
	@echo "Jenkins Master : `/usr/bin/docker inspect --format '{{ .State.Status }}' jenkins-master`"

build:
	@docker-compose build

start:
	@docker-compose --verbose up -d

stop:
	@docker-compose stop

status:
	@docker-compose ps

logs:
	@docker-compose logs

clean:	stop
	@docker-compose rm -f master

clean-data: clean
	@docker-compose rm -fv data

clean-images:
	@docker images -qf "dangling=true" |xargs docker rmi

clean-volumes:
	@docker volume ls -qf "dangling=true" |xargs docker volume rm

test: health build start status clean clean-data

