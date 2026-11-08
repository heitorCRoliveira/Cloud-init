# Provisionamento de VM AWS com Terraform e Cloud-Init

Este projeto automatiza a criação de uma máquina virtual na AWS utilizando Terraform e Cloud-Init, orquestrado por uma pipeline CI/CD no GitHub Actions.

## Tecnologias Utilizadas
- **Terraform:** Para criar a infraestrutura (EC2 e Security Group).
- **Cloud-Init:** Para instalar automaticamente o Docker e o Nginx durante o boot da máquina.
- **GitHub Actions:** Para validação, planejamento e aplicação controlada do código.

## Como Executar
1. Clone o repositório.
2. Configure as secrets no GitHub: `AWS_ACCESS_KEY_ID` e `AWS_SECRET_ACCESS_KEY`.
3. A pipeline é executada automaticamente no `push` realizando a validação e o *Plan*.
4. Para realizar o *Apply* e criar os recursos, vá na aba **Actions**, selecione a pipeline "Terraform CI/CD Pipeline", clique em **Run workflow** e digite `sim` no campo de confirmação.

## Acesso aos Serviços
Após a execução do Apply, clique na etapa "Terraform Apply" no log do GitHub Actions e copie o IP público retornado no output.
- Acesse o Nginx: `http://<IP_PUBLICO>`