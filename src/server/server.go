package server

import (
	"fmt"
	"github.com/gofiber/fiber/v2"
	"ics/options"
)

func Open(opt *options.Options) error {
	app := fiber.New();

	return app.Listen(fmt.Sprintf(":%d", opt.Port));
}