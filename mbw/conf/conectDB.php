<?php
//Classe de conexão com o banco de dados

// Parâmetros para a conexão com o banco

class Conection {
	protected $servername ="localhost";
	protected $banconame = "siscvet";
	protected $user = "root";
	protected $pwd  = "";

    //Passando a conexão 
    protected $conn;
    
// Função que conecta com o banco de dados
	public function conect()
	{
		$this->conn = new PDO("mysql:host=$this->servername;dbname=$this->banconame;charset=utf8",$this->user, $this->pwd);
	}
	// Função que desconecta do banco
	public function desconect()
	{
		$this->conn = null;
	}
	// Função que executa querys SQL, conecta no banco, retorna o ultimo ID inserido, e desconecta do banco   
	public function execute($sql)
	{
		$this->conect();
		$this->conn->query($sql);
        $lastId = $this->conn->lastInsertId();
		$this->desconect();
        return $lastId;
	}
// Função que busca os dados do banco de dados
	public function recoveryDados($sql)
	{
		$this->conect();

        $return = $this->conn->query($sql)->fetchAll(PDO::FETCH_ASSOC);

		$this->desconect();
		return $return;
	}
}