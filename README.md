<h1 align="center">Projeto WorkPlace</h1>
<p align="center">
<img src="/img/tivit-logo.png" alt="TIVIT" witdh="200" height="100" style="display: block; margin: 0 auto"/>
</p>

<h2 align="center"><strong>Características:</strong></h2>
<br>

<h3><strong>0 - preparar-hd.bat</strong></h3>
<ul>
	<li>Prepara o HD para utilização das bats.</li>
	<li>Copia os scripts e programas padrões para o HD externo do técnico.</li>
</ul>
<br>

<h3><strong>1 - backup.bat</strong></h3>
<ul>
	<li>Copia as pastas do perfil do usuário. (Exceto AppData).</li>
	<li>Copia todas as pastas do C:\ (Exceto pastas do sistema, por exemplo: Windows, Program Files).</li>
	<li>Copia a pasta Notes.</li>
	<li>Salva os mapeamentos.</li>
</ul>
<br>

<h3><strong>2 - pos_migracao.bat</strong></h3>
<ul>
		<li>Instala o Google Chrome.</li>
		<li>Instala o Notes.</li>
		<li>Instala o MaxxAudio.</li>
</ul>
<br>

<h3><strong>3 - restore _arquivos_usuario.bat</strong></h3>
<ul>
	<li>Restaura os arquivos do usuário.</li>
	<li>Restaura  as pastas do C:\.</li>
	<li>Restaura os mapeamentos.</li>
	<li>Restaura a pasta Notes.</li>
</ul>
<br>


<h2 align="center"><strong>Utilização:</strong></h2>

<h3><strong>0 -  Preparando HD Externo</strong></h3>
<ul>
	<li>Fazer download do último release em: <a href="https://github.com/Gianlucas94/Projeto-Workplace/releases" title= "último release">Últimos Releases </a></li>
	<br>
	<img src="/img/download.png" alt="Download" witdh="16" height="32">
	<ol>
		<li>Extraia o arquivo .zip e execute a bat <strong>0 - preparar-hd.bat</strong> e insera a letra do seu HD Externo. (Somente a letra)</li>
		<br>
	</ol>
	<img src="/img/preprar.png" alt="Primeiro passo" witdh="400" height="300">
</ul>
<br>

<h3><strong>1 - Fazendo Backup do Usuário</strong></h3>
<ul>
	<li><strong>Você tem que estar logado no perfil do usuário para a bat conseguir pegar os mapeamentos do usuário.</strong></li>
	<li>No seu HD externo abra a pasta scripts e execute a bat <strong>1 - backup.bat</strong></li>
<br>

<img src="/img/backup-1.png" alt="Primeiro passo" witdh="400" height="300">
<br>

</ul>
<ol>
	<li>Especifique a letra do seu <strong>HD externo</strong>(Somente a letra).</li>
	<li>Especifique o nome do usuario (não utilize espaços, utilize "_" no lugar.). Exemplo: <strong>"Gianlucas_Almeida"</strong>.</li>
	<li>Especifique a chave <strong>Praxair</strong> do usuário.</li>
	<li>Quando apresentar a mensagem de finalizado pode fechar a bat e inciar a baixa da <strong>imagem Linde</strong>.</li>
</ol>
<br>

<h3><strong>2 - Instalações e configurações pós baixa de imagem.</strong></h3>
<ul>
	<li><strong>Você tem que estar logado no perfil administrador para a bat conseguir instalar os softwares e executar a bat como administrador.</strong></li>
	<li>Crie uma pasta temp no C:\.</li>
	<li>No seu HD externo copie o conteúdo da pasta scripts para a pasta temp e execute a bat <strong>2 - pos_migracao.bat</strong></li>
	<br>
	<img src="/img/pos_migracao-1.png" alt="Primeiro passo" witdh="400" height="300">
	<br>
</ul>
<ol>
	<li>Especifique a letra do seu <strong>HD externo </strong>(Somente a letra).</li>
	<li>Após a instalação do <strong>Lotus Notes</strong> pode fechar todas as bats.</li>
</ol>
<br>

<h3><strong>3 - Retorno dos arquivos e configurações do usuário.</strong></h3>
<ul>
	<li><strong>Você tem que estar logado no perfil do usuário para a bat conseguir pegar os mapeamentos do usuário.</strong>
	<li>Crie uma pasta temp no C:\.</li>
	<li>Na pasta Temp execute a bat <strong>3 - restore _arquivos_usuario.bat</strong></li>
	<br>
	<img src="/img/restore.png" alt="Primeiro passo" witdh="400" height="300">
	<br>
</ul>
<ol>
	<li>Especifique a letra do seu <strong>HD externo</strong> (Somente a letra).</li>
	<li>Especifique o nome do usuario. <strong>o mesmo que você informou na primeira bat.</strong></li>
	<li>Especifique a chave <strong>Linde</strong> do usuário.</li>
	<li>Quando apresentar a mensagem de finalizado pode fechar a bat e configurar o Outlook e pedir ao usuário que valide.</li>
</ol>
<br>
<img src=https://img.shields.io/badge/-Batch-61DAFB?logo=Windows&logoColor=white&style=for-the-badge">
