build:
	@echo 'Building images'
	docker-compose build

test:
	@echo 'Running tests'
	docker-compose run --rm --entrypoint 'rspec spec/time_adjuster_spec.rb${lines}' exercise

.PHONY: build test websocket-test
