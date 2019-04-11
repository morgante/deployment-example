FROM hashicorp/terraform
RUN curl -O https://storage.googleapis.com/terraform-validator/releases/2019-04-04/terraform-validator-linux-amd64
RUN chmod +x terraform-validator-linux-amd64
RUN mv terraform-validator-linux-amd64 /usr/bin/terraform-validator

ENTRYPOINT ["/usr/bin/terraform-validator"]

