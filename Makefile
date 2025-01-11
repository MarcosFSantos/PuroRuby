CERTS_FOLDER=certs/
CERT_PATH=$(CERTS_FOLDER)cert.pem
KEY_PATH=$(CERTS_FOLDER)key.pem
CONFIG_STRING = "[ req ]\n\
default_bits       = 2048\n\
default_md         = sha256\n\
default_keyfile    = server.key\n\
prompt             = no\n\
encrypt_key        = no\n\
distinguished_name = req_distinguished_name\n\
x509_extensions    = v3_ca\n\
req_extensions     = v3_req\n\
[ req_distinguished_name ]\n\
C  = BR\n\
ST = SP \
L  = SaoPaulo\n\
O  = Minha Empresa\n\
CN = localhost\n\
[ v3_req ]\n\
basicConstraints = CA:FALSE\n\
keyUsage = critical, digitalSignature, keyEncipherment\n\
extendedKeyUsage = serverAuth\n\
subjectAltName = @alt_names\n\
[ v3_ca ]\n\
basicConstraints = critical, CA:TRUE, pathlen:0\n\
keyUsage = critical, digitalSignature, keyCertSign, cRLSign\n\
subjectAltName = @alt_names\n\
[ alt_names ]\n\
DNS.1 = localhost\n\
IP.1  = 127.0.0.1\n\
IP.2  = ::1\n\
[ ca ]\n\
default_ca = CA_default\n\
[ CA_default ]\n\
certificate = ./ca.crt\n\
private_key = ./ca.key\n\
new_certs_dir = ./newcerts\n\
database = ./index.txt\n\
serial = ./serial\n\
default_days = 365\n\
default_md = sha256\n\
policy = policy_any"

.PHONY: cert clean_cert

cert:
	@echo "Gerando certificados autoassinados..."
	mkdir $(CERTS_FOLDER)
	@echo $(CONFIG_STRING) > $(CERTS_FOLDER)openssl.conf
	openssl req -x509 -newkey rsa:2048 -keyout $(KEY_PATH) -out $(CERT_PATH) -days 365 -noenc -config $(CERTS_FOLDER)openssl.conf
	rm -f $(CERTS_FOLDER)openssl.conf
	@echo "Certificados gerados: $(CERT_PATH), $(KEY_PATH)"

clean_cert:
	@echo "Removendo certificados autoassinados..."
	rm -rf $(CERTS_FOLDER)
	@echo "Certificados removidos."