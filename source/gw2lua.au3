#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Commander_tag_(blue).ico
#AutoIt3Wrapper_Outfile=..\exe\gw2lua.exe
#AutoIt3Wrapper_Outfile_x64=..\exe\gw2lua-64.exe
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
; *** Start added by AutoIt3Wrapper ***
#include <ButtonConstants.au3>
#include <FileConstants.au3>
; *** End added by AutoIt3Wrapper ***
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         Azhkanizkael

 Script Function:
	Use this application to log in to multiple Guild Wars 2 accounts without having to create multiple icons.
	Added security through the application as all personal data will be encrypted.

#ce ----------------------------------------------------------------------------

#include <ComboConstants.au3>
#include <Crypt.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiListBox.au3>
#include <GuiListView.au3>
#include <MsgBoxConstants.au3>
#include <StringConstants.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>
#include <File.au3>
#include <GuiConstants.au3>

Global $FileLocation = @AppDataDir & "\gw2lua\hash.gw2lua"
Global $gw2loc = (@AppDataDir & "\gw2lua\settings.gw2lua")
Global $gui_accountlist = 0
Global $iAlgorithm = $CALG_AES_256
Global $hGUI = 9999
Global $g_idCreate , $ReadAccount , $g_idAccount , $ReadPassword , $g_idPassword , $g_hKey, $accounts

gw2lua()

Func gw2lua()
	Global $gui = GUICreate("Guild Wars 2 Login Utility Application",302,146)
	Global $gui_login = GUICtrlCreateButton("Log In",201,1,100,45,BITOR($BS_MULTILINE,$BS_VCENTER))
	Global $gui_create = GUICtrlCreateButton("Create"&@CRLF&"New Account",1,45,100,50,BITOR($BS_MULTILINE,$BS_VCENTER))
	Global $gui_delete = GUICtrlCreateButton("Remove"&@CRLF&"Account",1,95,100,50,BITOR($BS_MULTILINE,$BS_VCENTER))
	Global $gui_deleteall = GUICtrlCreateButton("Remove"&@CRLF&"All Accounts",101,95,100,50,BITOR($BS_MULTILINE,$BS_VCENTER))
	Global $gui_update = GUICtrlCreateButton("Update"&@CRLF&"Guild Wars 2",101,45,100,50,BITOR($BS_MULTILINE,$BS_VCENTER))
	Global $gui_repair = GUICtrlCreateButton("Repair"&@CRLF&"Guild Wars 2",201,45,100,50,BITOR($BS_MULTILINE,$BS_VCENTER))
	Global $gui_gw2location = GUICtrlCreateButton("Guild Wars 2"&@CRLF&"Location",201,95,100,50,BITOR($BS_MULTILINE,$BS_VCENTER))
	GUICtrlCreateLabel("Account:",2,2,195,20)
	loadaccounts()
    GUISetState(@SW_SHOW, $gui)

	If FileExists($gw2loc) = 0 Then
		GUICtrlSetState($gui_login, $GUI_DISABLE)
		GUICtrlSetState($gui_update, $GUI_DISABLE)
		GUICtrlSetState($gui_repair, $GUI_DISABLE)
	ElseIf FileExists($gw2loc) = 1 Then
		GUICtrlSetState($gui_login, $GUI_ENABLE)
		GUICtrlSetState($gui_update, $GUI_ENABLE)
		GUICtrlSetState($gui_repair, $GUI_ENABLE)
		FileOpen($gw2loc)
		Global $gw2 = FileReadLine($gw2loc,1)
		FileClose($gw2loc)
	EndIf

	While 1
		$aMsg = GUIGetMsg(1)
		Switch $aMsg[1]
			case $gui
				Switch $aMsg[0]
					case $GUI_EVENT_CLOSE
						Exit
					case $gui_create
						gw2lua_new()
					case $gui_login
						$accountname = GUICtrlRead($gui_accountlist)
						$password = DecryptAccount($accountname)
						ShellExecute($gw2,' -nopatchui -email "'&$accountname&'" -password "'&$password&'"')
					case $gui_delete
						$accountname = GUICtrlRead($gui_accountlist)
						$confirmation = MsgBox($MB_YESNO,"Caution","Do you wish to remove the '" & $accountname & "' account?" & @CRLF & _
														"Note: If you have only 1 account remaining, you must select 'Remove All Acounts'")
						if $confirmation = $IDYES Then
							DeleteAccount($accountname)
						EndIf
						loadaccounts()
					case $gui_update
						ShellExecute($gw2)
					case $gui_repair
						$confirmation = MsgBox($MB_YESNO,"Caution","Do you wish to repair your guild wars 2 file?")
						if $confirmation = $IDYES Then
							ShellExecute($gw2,"-repair")
						EndIf
					case $gui_gw2location
						$sMessage = "Navigate to the guild wars 2 path and select gw2.exe or gw2-64.exe"
						Local $sFileOpenDialog = FileOpenDialog($sMessage, "C:\", "Guild Wars 2 (gw2*.exe)", $FD_FILEMUSTEXIST)
						If FileExists($FileLocation) = 0 Then
							DirCreate(@AppDataDir & "\gw2lua")
						EndIf
						Local $FileHandle = FileOpen($gw2loc)
						FileWrite($gw2loc,$sFileOpenDialog)
						FileClose($gw2loc)
						GUICtrlSetState($gui_login, $GUI_ENABLE)
						GUICtrlSetState($gui_update, $GUI_ENABLE)
						GUICtrlSetState($gui_repair, $GUI_ENABLE)
						$gw2 = $sFileOpenDialog
					case $gui_deleteall
						$confirmation = MsgBox($MB_YESNO,"Caution","Do you wish to remove all of your accounts?")
						if $confirmation = $IDYES Then
							FileOpen($FileLocation,$FO_OVERWRITE)
							FileClose($FileLocation)
						EndIf
						loadaccounts()
				EndSwitch
			case $hGUI
				Switch $aMsg[0]
					Case $GUI_EVENT_CLOSE
						GUIDelete($hGUI)
					Case $g_idCreate
						Local $ReadAccount = GUICtrlRead($g_idAccount)
						Local $ReadPassword = GUICtrlRead($g_idPassword)
						Global $g_hKey = _Crypt_DeriveKey("CALG_AES_256", $iAlgorithm)
						If GUICtrlRead($g_idAccount) = '' Then
							MsgBox("","Error!","Account name is required in order to create new account")
						ElseIf GUICtrlRead($g_idPassword) = '' Then
							MsgBox("","Error!","Password is required in order to create new account")
						ElseIf GUICtrlRead($g_idAccount) <> '' Then
							If GUICtrlRead($g_idPassword) = '' Then
								MsgBox("","Error!","Password is required in order to create new account")
							ElseIf GUICtrlRead($g_idPassword) <> '' Then
								Local $Encrypted = _Crypt_EncryptData($ReadPassword, $g_hKey, $CALG_USERKEY)
								Local $LineWrite = $ReadAccount & "|" & $Encrypted
								CreateNewAccount($LineWrite)
							EndIf
						EndIf
						GUIDelete($hGUI)
						loadaccounts()
				EndSwitch
		EndSwitch
	WEnd
EndFunc

Func loadaccounts()
	GUICtrlDelete ($gui_accountlist)
	If FileExists($FileLocation) = 1 Then
		Local $FileHandle = FileOpen($FileLocation)
		Local $line = 1
		Local $acc
		Local $accounts
		Do
			Local $readingline = FileReadLine($FileHandle,$line)
			Local $accountname = StringLeft($readingline,StringInStr($readingline,"|") - 1)
			If $readingline <> '' Then
				$acc = $accounts
				$accounts = $accountname & "|" & $acc
			EndIf
			$line += 1
		Until $readingline = ''
	EndIf
	Global $gui_accountlist = GUICtrlCreateCombo("",2,22,198,20,bitor($CBS_DROPDOWN,$WS_VSCROLL))
	GUICtrlSetData($gui_accountlist,$accounts)
EndFunc

Func gw2lua_new()
    $hGUI = GUICreate("Guild Wars 2 Login Utility Application - New Account", 320, 45)
	GUICtrlCreateLabel("Account:",5,7,100,20)
	GUICtrlCreateLabel("Password:",5,27,100,20)
    $g_idAccount = GUICtrlCreateInput("", 60, 2, 200, 20)
    $g_idPassword = GUICtrlCreateInput("", 60, 23, 200, 20, $ES_PASSWORD)
	$g_idCreate = GUICtrlCreateButton("Create",270,2,50,41)
    GUISetState(@SW_SHOW, $hGUI)
EndFunc

Func CreateNewAccount($lineitem)
	If FileExists($FileLocation) = 0 Then
		DirCreate(@AppDataDir & "\gw2lua")
	EndIf
	Local $FileHandle = FileOpen($FileLocation)
	FileWriteLine($FileLocation,$lineitem)
	FileClose($FileHandle)
EndFunc

Func DecryptAccount($account)
	Local $FileHandle = FileOpen($FileLocation)
	Local $line = 1
	Do
		Local $readingline = FileReadLine($FileHandle,$line)
		Local $splitstring = StringLeft($readingline,StringInStr($readingline,"|") - 1)
		$line += 1
	Until $account = $splitstring
	Local $EncPass = StringRight($readingline,StringInStr(StringReverse($readingline),"|") -1)
	Local $enp = _Crypt_DeriveKey("CALG_AES_256",$CALG_AES_256)
	Local $DecPass = BinaryToString(_Crypt_DecryptData($EncPass,$enp,$CALG_USERKEY))
	FileClose($FileHandle)
	Return $DecPass
EndFunc

Func DeleteAccount($account)
	Local $FileHandle = FileOpen($FileLocation)
	$linecount = UBound(FileReadToArray($FileHandle))
	$filedata = ''
	For $i = 0 to $linecount
		Local $readingline = FileReadLine($FileHandle,$i)
		If StringLeft($readingline,StringInStr($readingline,"|") -1) = $account Then
			StringReplace($readingline,0,'')
		EndIf
		$filedata = $filedata & $readingline & @CRLF
	Next
	ConsoleWrite($filedata&@CRLF)
	FileWrite($FileHandle,$filedata)
	Global $aLines
	_FileReadToArray($FileLocation, $aLines)
	For $i = 0 to $linecount
		If $aLines[$i] = "" Then
			_ArrayDelete($aLines, $i)
		EndIf
	Next
	_ArrayDelete($aLines, 0)
	_FileWriteFromArray($FileLocation, $aLines, 0)
	FileClose($FileHandle)
EndFunc
