// Copyright (C) 2020  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details, at
// https://fpgasoftware.intel.com/eula.


// Generated by Quartus Prime Version 20.1 (Build Build 720 11/11/2020)
// Created on Fri May 09 00:56:13 2025

registradorDeInstrucoes registradorDeInstrucoes_inst
(
	.clk(clk_sig) ,	// input  clk_sig
	.load(load_sig) ,	// input  load_sig
	.clr_msb(clr_msb_sig) ,	// input  clr_msb_sig
	.ei_lsb(ei_lsb_sig) ,	// input  ei_lsb_sig
	.entrada_instrucao(entrada_instrucao_sig) ,	// input [7:0] entrada_instrucao_sig
	.saida_instrucao(saida_instrucao_sig) 	// output [7:0] saida_instrucao_sig
);

