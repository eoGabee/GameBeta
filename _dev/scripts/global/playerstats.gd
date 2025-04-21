extends Node

var madeira:int = 100
var pedra:int

var vida:float = 100
var morto:bool = false
var velocidade:float = 50
var velocidade_correndo:float = 100
var dash_force: float = 150
var folego:float = 99999999999999999
var pode_levar_dano:bool = true

var pode_fundar_colonia:bool = true

#taxas#
var perda_folego_dash:float = 20
var perda_folego_corrida:float = 5

func dano_inimigo_para_jogador(dano):
	vida -= dano

func vidaGG():
	if vida <= 0:
		morto = true
		print("MORTO")
