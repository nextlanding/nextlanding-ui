'use strict'

### Sevices ###

angular.module('main.services')
.constant 'MainConfig',
    API_ENDPOINT: $PROCESS_ENV_API_ENDPOINT or 'http://localhost:8000/api'
