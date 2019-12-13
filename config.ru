require './config/environment'

use Rack::MethodOverride
run ApplicationController
use PlantsController
use DaysController
