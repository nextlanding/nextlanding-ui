'use strict'

### Sevices ###

angular.module('main.services')
.constant 'AppConfig',
    API_ENDPOINT: $PROCESS_ENV_API_ENDPOINT or 'http://localhost:8000/api'
    STRIPE_PUBLIC_KEY: $PROCESS_ENV_STRIPE_PUBLIC_KEY or 'pk_fh9X711IWVbkR61YZXexN5WwdpNm5'
    SEARCH_PRICE: 35
