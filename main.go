package main

import (
	"database/sql"
	"fmt"
	"log"
	_ "net/http"

	_ "github.com/codeuniversity/smag-mvp/utils"
	_ "github.com/google/uuid"
	_ "github.com/kelseyhightower/envconfig"
	_ "github.com/lib/pq"
	_ "github.com/rs/zerolog/log"
	_ "github.com/stripe/stripe-go/v73"
)

var Version = "unknown-updated-during-build-time"
var serviceName = "reward-service-mock"

// var maxOrderStatusInPendingStateSeconds = 10

// func runMigrate(db *sql.DB) {
// 	driver, err := postgres.WithInstance(db, &postgres.Config{})
// 	util.PanicIfNotNil(err)
// 	m, err := migrate.NewWithDatabaseInstance(
// 		"file://migrations",
// 		"postgres", driver)
// 	util.PanicIfNotNil(err)
// 	err = m.Up()
// 	if err != nil && !errors.Is(err, migrate.ErrNoChange) {
// 		util.PanicIfNotNil(err)
// 	}
// 	log.Info().Msg("completed migration")
// }

//////// config
type config struct {
	Flags struct {
		OnlySuccessfullyOrders bool `split_words:"true"`
	}
	DB struct {
		RewardPayoutsURI string `required:"true" split_words:"true"`
	}
}

var Env config

// func Init() {
// 	rand.Seed(time.Now().Unix())

// 	err := envconfig.Process("", &Env)
// 	util.PanicIfNotNil(err)
// 	log.Info().Msg("failed to load env")
// }

func main() {
	// Init()
	db, err := sql.Open("postgres", "postgres://udaycruise:udaycruise@localhost:5432/reward_service?sslmode=disable")
	if err != nil {
		log.Fatalf("could not connect to database: %v", err)
	}

	if err := db.Ping(); err != nil {
		log.Fatalf("unable to reach database: %v", err)
	}
	fmt.Println("database is reachable")

}
