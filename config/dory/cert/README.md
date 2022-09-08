# SSL Certificate

Generate a self-signed ssl certificate for docker dory.

## Trust the Root Certificate Authority on OSX

The self-signed site certificate `default.crt` is authorized with a self-signed root certificate authority `default.pem`. Therefore you need to add the `default.pem` to your keychain for it to be correctly authorized.
  
```bash
CERT_NAME=$(cat default.root.conf | grep CN | sed 's/CN = //'); \
echo "Trusting Root Certificate for CN $CERT_NAME" && \
# Remove certificate, if it has formerly been added (suppress error messages)
sudo security delete-certificate -t -c ${CERT_NAME} /Library/Keychains/System.keychain 2>/dev/null; \
# Trust the root certificate authority
sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain default.root.pem
```

## Regenerate the root and site certificate on OSX (Only last 397 days)

Starting on September 1st (2020), SSL/TLS certificates cannot be issued for longer than 13 months (397 days) - NET::ERR_CERT_VALIDITY_TOO_LONG.

- <https://www.ssls.com/blog/apples-new-ssl-lifetime-limitation-and-what-it-means-for-you/>
- <https://www.globalsign.com/en/blog/maximum-ssltls-certificate-validity-now-one-year>

When needed, the below script can regenerate both the self-signed root certificate authority and the site certificate.

```bash
CERT_NAME=$(cat default.root.conf | grep CN | sed 's/CN = //'); \
CAPASS=$(pwgen 32 1); \
# Generate Root Certificate Authority
echo "Generating Root Certificate Authority for $CERT_NAME" && \
openssl genrsa \
  -des3 \
  -passout pass:${CAPASS} \
  -out default.root.key 2048 && \
openssl req \
  -x509 \
  -config <(cat default.root.conf) \
  -passin pass:${CAPASS} \
  -new \
  -nodes \
  -key default.root.key \
  -sha256 \
  -days 397 \
  -out default.root.pem && \
# Generate Site Certificate
echo "Generating Site Certificate for $CERT_NAME" && \
openssl genrsa \
  -out default.key 2048 && \
openssl req \
  -new \
  -config <(cat default.root.conf) \
  -key default.key \
  -out default.csr && \
openssl x509 \
  -req \
  -passin pass:${CAPASS} \
  -in default.csr \
  -CA default.root.pem \
  -CAkey default.root.key \
  -CAcreateserial \
  -out default.crt \
  -days 397 \
  -sha256 \
  -extfile <(cat default.conf) && \
# Remove temporary files
rm -rf default.csr default.srl
```
