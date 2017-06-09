NAME = cheggwpt/php7-nginx
VERSION = 1.1.6

.PHONY: all build test tag_latest release

all: build tag_latest

build:
	docker build --no-cache -t $(NAME):$(VERSION) .

tag_latest:
	docker tag $(NAME):$(VERSION) $(NAME):latest

run:
	docker run -p 8880:80 --name php7-nginx -d --rm -t $(NAME):$(VERSION)

test:
	docker build -t php_nginx_test .
	docker run -d -p 127.0.0.1:8880:80 --name php_nginx_test php_nginx_test
	sleep 5
	curl -vsf -H 'Accept-Encoding: gzip' 'http://127.0.0.1:8880/' &> /dev/stdout
	curl -vsf 'http://127.0.0.1:8880/' &> /dev/stdout
	docker kill php_nginx_test
	docker rm php_nginx_test
	docker rmi php_nginx_test

release: tag_latest
	@if ! docker images $(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker push $(NAME)
	@echo "*** Don't forget to create a tag. git tag rel-$(VERSION) && git push origin rel-$(VERSION)"
