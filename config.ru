require './config/environment'

use Rack::MethodOverride
use UsersController
use AppointmentsController
use TodosController
run ApplicationController
