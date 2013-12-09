'use strict'

### Sevices ###

angular.module('app.services')
.constant 'AppConfig',
    API_ENDPOINT: $PROCESS_ENV_API_ENDPOINT or 'http://localhost:8000/api'
    STRIPE_PUBLIC_KEY: $PROCESS_ENV_STRIPE_PUBLIC_KEY or 'pk_fh9X711IWVbkR61YZXexN5WwdpNm5'
    SEARCH_PRICE: 35.00
    CONTACT_EMAIL_ADDRESS: 'info@nextlanding.com'
    GOOGLE_ANALYTICS_ID: $PROCESS_ENV_GOOGLE_ANALYTICS_ID or 'UA-37743233-2'
    MIXPANEL_ID: $PROCESS_ENV_MIXPANEL_ID or'6151a46c88bd6d19f375f9a2fd066c78'
