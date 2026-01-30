docker build -t testfrontapp:v0.0.1 .

docker run -d -p 8080:8080  -e API_URL="https://tc-ds.apps.qaocp.imss.gob.mx/"  --name mi-app-angular  testfrontapp:v0.0.1