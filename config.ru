require './config/environment'

use Rack::MethodOverride
use UsersController
use AppointmentsController
run ApplicationController
