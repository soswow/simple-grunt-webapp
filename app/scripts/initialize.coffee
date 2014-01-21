Application = require './application'
routes      = require './routes'

$ ->
  new Application {
    title: 'Devclub Yo',
    controllerSuffix: '',
    routes
  }