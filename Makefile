postgres:
	docker run --name postgres15 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:15-alpine
createdb:
	docker exec -it postgres15 createdb --username=root --owner=root bankApp
dropdb:
	docker exec -it postgres15 dropdb --username=root --owner=root
migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/bankApp?sslmode=disable" -verbose up
migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/bankApp?sslmode=disable" -verbose down
sqlc:
	sqlc generate
test:
	go test -v -cover ./...
.PHONY:
	postgres createdb dropdb migrateup migratedown sqlc test
