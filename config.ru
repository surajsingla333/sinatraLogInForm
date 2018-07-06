require_relative './config/environment'

use Rack::MethodOverride
use SignupController
use LoginController
run ApplicationController
