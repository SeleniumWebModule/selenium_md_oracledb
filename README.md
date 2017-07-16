# seleniummdoracledb
Módulo para provisionamento da instalação e configuração do banco de dados

O Módulo irá instalar e configurar o oracle para que a plataforma faça um teste desacoplado em cada execução. 

O Módulo irá provisionar a instalação inicialmente na VM e posteriormente em container para diminuir gaps de performance. 

A instalação poderá ser realizada também em uma máquina física desde que o puppet esteja instalado, talvez sejam necessário adaptações. Inicialmente a instalação será realizada tendo como foco o centOS na versão 7.
