Tạo CA certificate:
openssl genrsa -out CA.key 2048
openssl req -x509 -sha256 -new -nodes -days 3650 -key CA.key -out CA.pem

Tạo SSL Certificate Signing Request:
openssl genrsa -out localhost.key 2048
openssl req -new -key localhost.key -out localhost.csr

Nội dung file localhost.ext:
authorityKeyIdentifier = keyid,issuer
basicConstraints = CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = localhost
IP.1 = 127.0.0.1

Ký SSL certificate:
openssl x509 -req -in localhost.csr -CA CA.pem -CAkey CA.key -CAcreateserial -days 365 -sha256 -extfile localhost.ext -out localhost.crt

Cấu hình nginx:
server {
  listen 80;
  server_name localhost;
  return 301 https://$host$request_uri;
}
server {
  listen 443 ssl;
  server_name localhost;
  ssl_certificate     /etc/nginx/ssl-certificate/localhost.crt;
  ssl_certificate_key /etc/nginx/ssl-certificate/localhost.key;
  location / {
    root /var/www/html;
    index index.html index.htm;
  }
}

Import CA vào trình duyệt chrome:
chrome://settings/certificates