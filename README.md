# Servidor Apache hosteado em uma instância EC2

Este é o trabalho final da Sprint das trilhas de Linux e AWS da empresa Compass.UOL.
O objetivo desse documento é detalhar alguns dos processos para instalar um EFS em uma instância EC2, instalar o serviço do Apache, hostear um servidor e gerar um script que realiza o health check do mesmo.
  
### Comandos a serem inseridos na criação da máquina virutal EC2:

- *sudo yum update -y*
<p>Procura updates no sistema.</p>

- *sudo yum install -y amazon-efs-utils*
<p>Instala as ferramentas para trabalhar com o Elastic File System da AWS.</p>

- *sudo yum install git -y*
<p>Instala o Git para o versionamento da atividade.</p>

- *sudo yum install -y httpd*
<p>Instala o serviço do Apache.</p>

### Dentro da instância:

Ao logar na instância, primeiramente será necessário instalar o EFS, isso pode ser feito fazendo o uso do comando:
- *sudo mount -t efs [id-do-filesystem]/ /[diretorio-de-montagem]*

Porém, ao fazer a reinicialização da máquina, o processo de montagem é perdido. Para contornar isso, deveremos então adicionar uma linha de código para o arquivo **fstab**, localizado em */etc/fstab*, que é responsável pela montagem de discos durante o boot da máquina. No arquivo, será adicionada a seguinte linha:
- *[id-do-filesystem].efs.[regiao].amazonaws.com:/ /[diretorio-de-montagem] nfs4 defaults,_netdev 0 0*

### Serviço Apache
Feito isso, podemos então iniciar o serviço do Apache, e escrever o seu script de health check. Para inciá-lo, basta digitar o seguinte comando no terminal:
- *sudo service httpd start*
Desse modo, o serviço já deve estar online. Podemos verificar isso digitando o endereço de IP público da máquina em um browser qualquer para acessar o site contido nos arquivos do Apache.

### Script de health check

Com isso, chegamos à parte de escrever o código do script. Nesse documento há um exemplo de um shell script que verifica se o servidor httpd está online e, em caso positivo, cria um arquivo detalhando se ele está realmente ativo, juntamente com data e hora de sua execução. Já em caso negativo, ele cria outro arquivo, com as mesmas informações, porém, com uma mensagem diferente, informando que o servidor está offline.

### Automação do Script

Para automatizar a execução do health check, basta adicionar uma rotina no crontab, que é um serviço de sistemas Unix para a automação de tarefas no sistema.

No terminal, digite o comando abaixo:

- *crontab -e*

Nesse arquivo, basta digitar a seguinte linha:

- **/5 * * * * bash /[diretorio-do-seu-script]/[seu-script].sh*

Essa linha fará com que o script seja executado constantemente em intervalos de 5 minutos.

### Conclusão

Esse arquivo tem como objetivo documentar os processos feitos ao longo da duração do trabalho, e salvar essas informações para futuras reiterações.

### Referências

[Inicialização de um servidor Apache em um Elastic File System](https://docs.aws.amazon.com/efs/latest/ug/wt2-apache-web-server.html)

[Instalação do EFS Utils](https://docs.aws.amazon.com/efs/latest/ug/installing-amazon-efs-utils.html)

[Montagem de um EFS em uma instância EC2](https://docs.aws.amazon.com/efs/latest/ug/mounting-fs-mount-helper-ec2-linux.html)
