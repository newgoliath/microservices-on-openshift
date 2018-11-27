oc project $OSE_INFRA_PROJECT
oc create -f ./mysql.yaml

oc new-app --context-dir='python-email-api' \
  -e EMAIL_APPLICATION_DOMAIN=http://emailsvc:8080 \
MYSQL_USER='app_user' \
MYSQL_PASSWORD='password' \
MYSQL_DATABASE='microservices' \
MYSQL_SERVICE_HOST='MYSQL' \
  https://github.com/newgoliath/microservices-on-openshift.git \
  --name=emailsvc --image-stream='python:2.7'  -l microservice=emailsvc

oc create configmap email-props --from-literal=GMAIL_USERNAME=$FROM_GMAIL --from-literal=GMAIL_PASSWORD=$FROM_GMAIL_PASSWORD
oc set env dc/emailsvc --from=configmap/email-props 

