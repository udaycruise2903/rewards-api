.PHONY: build

VERSION = 0.0.1

test:
	go test ./...

clean:
	rm -r vendor || true
	rm -r build || true

build:
	@env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
	go build -v -ldflags "-X 'main.Version=$(VERSION)'" -v -o ./build/server main.go

commitAndTag: build
	git add .
	git commit -m "build(makefile): commitAndTag by makefile, VERSION: $(VERSION)"
	git tag $(VERSION)
	git push
	git push --tags

builddocker: clean build
	go mod vendor && \
	docker build -f ./Dockerfile . -t udaycruise2903/interview-assignment
	rm -r vendor || true

deploy: builddocker
	docker tag udaycruise2903/interview-assignment udaycruise2903/interview-assignment:sc-rewards-$(VERSION)
	docker push udaycruise2903/interview-assignment:sc-rewards-$(VERSION)

releaseBuild: deploy commitAndTag