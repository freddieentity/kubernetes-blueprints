## Certificate Authority (CA)

#### Self-signed CA

- Generate Keys
    ```
    openssl genrsa -out ca.key 4096
    ```
- Generate CSR
    ```
    # openssl req -new -sha256 -days 10950 -key ca.key -subj "/CN=KUBERNETES-CA" -out ca.csr 
    openssl req -new -x509 -sha256 -days 10950 -key ca.key -out ca.crt
    ```
- Sign certificates
    ```
    openssl x509 -req -in ca.csr -signkey ca.key -out ca.crt
    ```
- Check if the certificate is CA
    ```
    openssl x509 -text -noout -in ca.crt |grep "CA:"
    ```


#### Import the certificate 

- Import the .crt file into the system (browser, servers,...) and allow the certificate to be trusted by the system itself.
- Encode base64 (for easy method) and put the ca.key and ca.crt into the secret in the cert-manager namespace also
    ```
    cat ca.crt | base64 -b0
    cat ca.key | base64 -b0
    ```
- The Cert Manager Cluster Issuer will use the ca.key and ca.crt to do SSL

## Generating Client Certificates

#### Admin User Certificates

- Generate Keys
    ```
    openssl genrsa -out admin.key 4096
    ```
- Generate CSR
    ```
    openssl req -new -key admin.key -subj "/CN=kube-admin" -out admin.csr
    ```
- Sign certificates
    ```
    openssl x509 -req -in admin.csr -CAcreateserial -CA ca.crt -CAkey ca.key -out admin.crt
    ```
- Certificate with admin privilages
    ```
    openssl req -new -key admin.key -subj "/CN=kube-admin/O=system:masters" -out admin.csr
    ```

## Inspect the certificate
- Get information of a certificate
    ```
    openssl x509 -noout -text -in 'ca.crt'
    ```




```
vim /etc/ssl/openssl.cnf

[ v3_ca ]
basicConstraints = critical,CA:TRUE
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always,issuer:always
```