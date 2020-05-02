# terraform-nginx

1. Com suas credentials configuradas, execute o comando abaixo para criar a chave ssh que será utilizada no projeto.

``` 
aws --region us-west-2 ec2 \
 create-key-pair \
 --key-name "nginx-lab" \
 | \
 jq -r ".KeyMaterial" > ~/.ssh/nginx-lab.pem
```
2. Execute o comando `chmod 400 ~/.ssh/nginx-lab.pem` para que a chave tenha a permissão correta.

3. Vamos criar agora o workspace do terraform, fazendo com que o estado seja guardado.

4. Execute o comando `terraform workspace new dev`

5. Execute o comando `terraform workspace select dev`

6. Execute o comando `cd vpc`

7. Execute o comando `terraform init`

8. Execute o comando `terraform plan`

9. Execute o comando `terraform apply -auto-approve`

10. Após a VPC ser criada rode o comando `cd ..`

11. Repetir os passo 7,8,9.
