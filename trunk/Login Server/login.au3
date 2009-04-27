#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Change2CUI=y
#AutoIt3Wrapper_Run_Obfuscator=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;;;;;;;;;;;;;;; ____ ISC SERVER ____ ;;;;;;;;;;;;;;;
;; AUTHOR == JIYAN AKG‹L 						;;;;
;; (C) 2009 BY JIYAN AKG‹L FOR APSP BY EVO-SOFT.;;;;
;; ALL RIGHTS RESERVED.							;;;;
;; LICENSED BY GNU v3  							;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#cs GNU General Public License v3.0
	
	ISC Server of the APSP
	Copyright (C) 2009  Jiyan Akg¸l
	
	This program is free software
	you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation
	either version 3 of the License, or (at your option) any later version.
	
	This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY
	without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
	See the GNU General Public License for more details.
	
	You should have received a copy of the GNU General Public License along with this program
	if not, see <http://www.gnu.org/licenses/>.
#ce

#include "_TCP.au3"
#include "packet.au3"
#include "misc.au3"
#include "xml.au3"
#include "DB\DB.au3"

Global $Time = 0

$sServer_Type = "LOGIN"
$asc = Chr(15)
cout("##### APSP ## J"&$asc&"FLY ######")
cout("## Server Type :: " & $sServer_Type)

_XML_Open("server.config", 1)
_XML_Set_Base("LOGIN")
$sIP = _XML_Get_Value("IP")
$iPORT = _XML_Get_Value("PORT")

cout("## Server IP   :: " & $sIP)
cout("## Server PORT :: " & $iPORT)
cout("## ")
cout("## © 2009 by Jiyan Akg¸l")
cout("## All rights reserved")
cout($asc&" Server is Starting and Registering Threads "&$asc)
;;; CONSOLE INFO END


AdlibEnable("__stoptime", 1)
$hMainSock = _TCP_Server_Create($iPORT, $sIP)
_TCP_RegisterEvent($hMainSock, $TCP_NEWCLIENT, "SendGreeting")
AdlibDisable()

;;; MAIN SOCK END
cout("[DEBUG] Server Startet on " & $sIP & ":" & $iPORT)
cout("starting server takes " & $Time & "ms")
$Time = 0


;;; CONSOLE INFO END
cout($asc&" Connecting to MySQl Databases "&$asc)
AdlibEnable("__stoptime", 1)

cout("[DB] Connecting to Characters DB")
$MysqlChar = _ConnToChar()

cout("[DB] Connecting to Server DB")
$MysqlServ = _ConnToServ()
cout("connecting to Databases takes " & $Time & "ms")

AdlibDisable()

;;; DATABASE CONNECTION END


While 1

WEnd


Func SendGreeting($Client, $iError); Sending Greeting Packet
	$iIP = _TCP_Server_ClientIP($Client)
	; PACKET<<		Sending Greeting Packet
	msg_clear()
	msg_AddByte(0x5E)
	msg_AddSize()
	msg_AddInt(0)
	msg_AddInt($Client)
	; >>PACKET
	$str = msg_ToStr()
	cout("STR = " & $str)
	_TCP_Send($Client,$str )
	_TCP_RegisterEvent($Client, $TCP_RECEIVE, "LoginCheck")
	_TCP_RegisterEvent($Client, $TCP_DISCONNECT, "DisConnected")


EndFunc   ;==>SendGreeting

Func DisConnected($Client, $iError)
	_TCP_Server_DisconnectClient($Client)
	cout("[USER] Client DisConnected :: Reason :-1")
EndFunc   ;==>DisConnected


Func DEL($hSocket, $iError)
	_TCP_Server_DisconnectClient($hSocket)
	$iIP = _TCP_Server_ClientIP($hSocket)
;~ 	cout("## "&$iIP&" diconnected")
	_DB_write("0","status","lat_ip",$iIP,$MysqlChar)
EndFunc   ;==>DEL

;~ Checking Login Datas
Func LoginCheck($Client, $data, $iError)
	Local $un, $pw, $datastamp, $username, $password
	$iIP = _TCP_Server_ClientIP($Client)
	cout("[USER]Client Connect( " & $iIP & " Sock ID:" & $Client & " )")
;~ 	cout("[PRO] Packet : " & $data)

	; PACKET<<		Decrypt Login Packet
	msg_setPac($data)
	msg_getByte(1);
	msg_getByte(12); ??
	$command = msg_getByte(4); Command
	$ds =	msg_getString();	Data Stamp / Time Stemp ( Flyff Client Version )
			msg_getByte(4); ??
	$un =	msg_getString();	Username
	$pw =	msg_getString();	PW MD5 Hash
	
;~ 	cout($command)


	Switch $command
		Case 0xFC000000
			; >>PACKET
			cout("##Username  : " & $un)
			; Schickt den UserName zur Console
			cout("##Password : " & $pw)
			; Schickt das Password zur Console
			$username = _DB_read($un,$MysqlChar,"Username")
			$password = _DB_read($pw,$MysqlChar,"Password")
			$banned =  _DB_read($un,$MysqlChar,"Banned")
			$LoggedIn = _DB_read($un,$MysqlChar,"Status")
			cout("USERNAME :: " & $username)
;~ 			If $datastamp = "20070712" Then
;~ 				; PACKET<<		Sending "Server verification error." Message
;~ 				msg_clear()
;~ 				msg_AddByte(0x5E);		
;~ 				msg_AddSize()
;~ 				msg_AddComand(0xFE);	
;~ 				msg_AddComand(0x88);	
;~ 				; >>PACKET
;~ 				_TCP_Send($Client, msg_ToStr());		Client bekommt Meldung: "Server verification error."
;~ 				_TCP_Server_DisconnectClient($Client);					Schlieﬂt das Socket
;~ 				cout("## Client disconnected <<-");			Schickt der Console das der User Disconnected ist
;~ 				cout("## Reason: Wrong Datastamp");				Schickt der Konsole den Grund f¸r den Disconnect
			If $username = "0" Then;					Checkt ob der UserName mit dem UserName aus der DB ¸berein stimmt
				; PACKET<<		Sending "Wrong ID" Message
				msg_clear()
				msg_AddByte(0x5E)
				msg_AddSize()
				msg_AddComand(0xFE)
				msg_AddComand(0x79)
				; >>PACKET
				_TCP_Send($Client,msg_ToStr() );		Client bekommt Meldung: "Wrong ID"
				_TCP_Server_DisconnectClient($Client);					Schlieﬂt das Socket
				cout("## Client disconnected <<-");			Schickt der Console das der User Disconnected ist
				cout("## Reason: Wrong ID");						Schickt der Konsole den Grund f¸r den Disconnect
			Else				;			Fals der Username dann ¸bereinstimmt und der eingegeben  ist dann geht es weiter
				If $LoggedIn = "1" Then;					Checkt ob der User schon eingeloggt ist
					; PACKET<<		Sending "User already logged in" Message
					msg_clear()
					msg_AddByte(0x5E)
					msg_AddSize()
					msg_AddComand(0xFE)
					msg_AddComand(0x67)
					; >>PACKET
					_TCP_Send($Client, msg_ToStr());		Client bekommt Meldung: "User already logged in"
					_TCP_Server_DisconnectClient($Client);					Schlieﬂt das Socket
					cout("## Client disconnected <<-");			Schickt der Console das der User Disconnected ist
					cout("## Reason: User already logged in");		Schickt der Konsole den Grund f¸r den Disconnect
				Else;											Fals der User dann doch nicht eingeloggt ist...
					If $banned = "1" Then;						Checkt ob der User gebannt ist
						; PACKET<<		Sending "This ID has been blocked" Message
						msg_clear()
						msg_AddByte(0x5E)
						msg_AddSize()
						msg_AddComand(0xFE)
						msg_AddComand(0x77)
						; >>PACKET
						_TCP_Send($Client, msg_ToStr());		Client bekommt Meldung: "This ID has been blocked"
						_TCP_Server_DisconnectClient($Client);					Schlieﬂt das Socket
						cout("## Client disconnected <<-");			Schickt der Console das der User Disconnected ist
						cout("## Reason: Banned User wanted to login");	Schickt der Konsole den Grund f¸r den Disconnect
					Else;											Fals der user dann doch nicht gebannt ist...
						If $password = "0" Then;					Checkt ob PassWord gleich ist
							; PACKET<<		Sending "Wrong password" Message
							cout(" PASS :"&$password)
							msg_clear()
							msg_AddByte(0x5E)
							msg_AddSize()
							msg_AddComand(0xFE)
							msg_AddComand(0x78)
							; >>PACKET
							_TCP_Send($Client, msg_ToStr());		Client bekommt Meldung: "Wrong password"
							_TCP_Server_DisconnectClient($Client);					Schlieﬂt das Socket
							cout("## Client disconnected <<-");			Schickt der Console das der User Disconnected ist
							cout("## Reason: Wrong Password");				Schickt der Konsole den Grund f¸r den Disconnect
						Else;											Fals das PassWord dann doch richtig ist...
							_DB_write("1","status","username",$username,$MysqlChar)			;Schreibt in die acc datei das der User On ist
							_DB_write($iIP,"last_ip","username",$username,$MysqlChar)
							ServerName($Client, $un);															Sendet dem User die Server Liste
							cout("## Client Connected <<-")
						EndIf
					EndIf
				EndIf
			EndIf

	EndSwitch
EndFunc   ;==>LoginCheck

;~ Sending Server List
Func ServerName($Client, $username)
	Local $Chan
	Local $Capa
	$Chan = _DB_get_Channels($MysqlServ)
	cout("channels getted")
	msg_clear();
	msg_AddByte(0x5E);											Header + Size
	msg_AddSize()
	msg_AddComand(0xfd);										Command
	msg_AddHex("8e0b2939");										???
	msg_AddHex("01");								            ??
	msg_AddString($username);                                   User Name
	msg_AddInt(1 + $Chan);                               		1 server + X channels
	$Server = _DB_get_Server_info(1, $MysqlServ)
	cout("server info getted")
	msg_AddHex("FFFFFFFF");										Server Begin
	msg_AddInt(1);												Server ID
	msg_AddString($Server[0]);									Servername
	msg_AddString($sIP);									IP
	msg_AddInt(0);												???
	msg_AddInt(0);												???
	msg_AddInt(1);												???
	msg_AddInt(0);												???
	$chan_s = _DB_get_Channels($MysqlServ,1)
	cout("channeˆs getted 2")
	For $i = 1 to $chan_s
	$Capa = _DB_get_Channel_info($i,$MysqlServ)
	cout("info for channels getted")
	msg_AddInt(1);											Server ID
	msg_AddInt($i);											Channel ID
	msg_AddString($Capa[0]);								Channelname
	msg_AddInt(0);											???
	msg_AddInt(0);											???
	msg_AddInt($Capa[1]);									Players online
	msg_AddInt(1);											???
	msg_AddInt($Capa[2]);									Channel Capacity
	Next
	$str = msg_ToStr()
	; >>PACKET
	_TCP_Send($Client, $str)
EndFunc   ;==>ServerName

