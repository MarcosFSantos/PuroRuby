CERTS_FOLDER=certs/
CERT_PATH=$(CERTS_FOLDER)cert.pem
KEY_PATH=$(CERTS_FOLDER)key.pem

.PHONY: ssl_cert clean_ssl_cert

# req: Gera uma solicitação de assinatura de certificado (CSR).
# -x509: Emite um certificado de um CSR. Ao juntar com o req, faz o certificado autoassinado.
# -newkey rsa:2048: Cria uma nova chave RSA de 2048 bits.
# -keyout: Especifica o arquivo de saída para a chave privada.
# -out: Especifica o arquivo de saída para o certificado.
# -days: Define a validade do certificado em dias.
# -noenc: Não criptografa a chave privada. Evita a solicitação de senha ao iniciar o servidor.
# -subj: Define os dados da assinatura do certificado.
cert:
	@echo "Gerando certificados autoassinados..."
	mkdir $(CERTS_FOLDER)
	openssl req -x509 -newkey rsa:2048 -keyout $(KEY_PATH) -out $(CERT_PATH) -days 365 -noenc -subj "/C=BR/ST=SP/L=SaoPaulo/O=Minha Empresa/CN=localhost"
	@echo "Certificados gerados: $(CERT_PATH), $(KEY_PATH)"

clean_cert:
	@echo "Removendo certificados autoassinados..."
	rm -rf $(CERTS_FOLDER)
	@echo "Certificados removidos."