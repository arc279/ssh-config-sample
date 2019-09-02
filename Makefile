COMPOSE_PROJECT_NAME := dev

default:

clean:
	rm -rf keys

###-----------------------------------------------
.PHONY: keys
keys:
	mkdir -p keys

	mkdir -p keys/root
	cd keys/root && echo {dev,stg,rel}-{zone1,zone2,zone3} | xargs -n1 ssh-keygen -N '' -f

	cd keys && ssh-keygen -N '' -f hoge

key-add:
	ssh-add keys/hoge

###-----------------------------------------------
.PHONY: up
up:
	docker-compose -p ${COMPOSE_PROJECT_NAME} up

.PHONY: down
down:
	docker-compose -p ${COMPOSE_PROJECT_NAME} down

.PHONY: up-scale
up-scale:
	docker-compose -p ${COMPOSE_PROJECT_NAME} up \
		--scale zone1-node=3 --scale zone2-node=3 --scale zone3-node=3

###-----------------------------------------------
.PHONY: run
run: USER := hoge
run:
	@ for x in dev-{zone1,zone2,zone3}-node{1..3}; do \
		echo ---------------------------; \
		echo $$x; \
		ssh -F ssh_config ${USER}@$$x "whoami; hostname"; \
	done

###-----------------------------------------------
servers:
	@ sed -n 's/^Host\W*\(.*\)/\1/p' ssh_config | grep -v '*'
