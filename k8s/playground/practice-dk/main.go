package main

import (
	"net/http"

	"github.com/labstack/echo/v4"
)

func main() {

	e := echo.New()

	e.GET("/", func(c echo.Context) error {
		return c.JSON(http.StatusOK, "hello from router")
	})

	e.Logger.Fatal(e.Start("0.0.0.0:3030"))

}
