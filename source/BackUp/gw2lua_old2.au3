#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Commander_tag_(blue).ico
#AutoIt3Wrapper_Outfile=..\exe\gw2lua.exe
#AutoIt3Wrapper_Outfile_x64=..\exe\gw2lua-64.exe
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Run_Tidy=y
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
Global $sGUI = 9999
Global $g_idCreate, $ReadAccount, $g_idAccount, $ReadPassword, $g_idPassword, $g_hKey, $accounts, $g_gw2path
Global $g_id32, $g_idassetsrv, $g_idauthsrv, $g_idautologin, $g_idbmp, $g_idclientport80, $g_idclientport443, $g_idcopydat, $g_iddat, $g_iddiag, $g_iddx9single, $g_idforwardrenderer, $g_idfps, $g_idimage, $g_idmaploadinfo, $g_idmce, $g_idnopatchui, $g_idnomusic, $g_idnoui, $g_idnosound, $g_idprefreset, $g_idshareArchive, $g_iduispanallmonitors, $g_iduninstall, $g_iduseOldFov, $g_idverify, $g_idwindowed, $g_idumbra
Global $filedata, $g_idlocation, $g_idauthsrvinput, $g_idassetsrvinput, $g_iddatinput, $g_idfpsinput
Global $gw2_parameters = '', $stuff
Global $Check_32, $Check_asset, $Check_assetinput, $Check_authsrv, $Check_authsrvinput, $Check_autologin, $Check_bmp, $Check_clientport443, $Check_clientport80, $Check_copydat, $Check_dat, $Check_datinput, $Check_diag, $Check_dx9single, $Check_fprwardrenderer, $Check_fps, $Check_fpsinput, $Check_image, $Check_maploadinfo, $Check_mce, $Check_nomusic, $Check_nopatchui, $Check_nosound, $Check_noui, $Check_prefreset, $Check_sharearchive, $Check_uispanallmonitors, $Check_umbra, $Check_uninstall, $Check_useoldfov, $Check_verify, $Check_windowed

gw2lua()

Func gw2lua()
	Global $gui = GUICreate("GW2 Login Utility App", 302, 146)
	Global $gui_login = GUICtrlCreateButton("Log In", 201, 1, 100, 45, BitOR($BS_MULTILINE, $BS_VCENTER))
	Global $gui_create = GUICtrlCreateButton("Create" & @CRLF & "New Account", 1, 45, 100, 50, BitOR($BS_MULTILINE, $BS_VCENTER))
	Global $gui_delete = GUICtrlCreateButton("Remove" & @CRLF & "Account", 1, 95, 100, 50, BitOR($BS_MULTILINE, $BS_VCENTER))
	Global $gui_deleteall = GUICtrlCreateButton("Remove" & @CRLF & "All Accounts", 101, 95, 100, 50, BitOR($BS_MULTILINE, $BS_VCENTER))
	Global $gui_update = GUICtrlCreateButton("Update" & @CRLF & "Guild Wars 2", 101, 45, 100, 50, BitOR($BS_MULTILINE, $BS_VCENTER))
	Global $gui_repair = GUICtrlCreateButton("Repair" & @CRLF & "Guild Wars 2", 201, 45, 100, 50, BitOR($BS_MULTILINE, $BS_VCENTER))
	Global $gui_gw2location = GUICtrlCreateButton("Launcher" & @CRLF & "Settings", 201, 95, 100, 50, BitOR($BS_MULTILINE, $BS_VCENTER))
	GUICtrlCreateLabel("Account:", 2, 2, 50, 20)
	Global $gui_multiclient = GUICtrlCreateCheckbox("Multiclient(WIP)", 55, 0, 90, 20)
	loadaccounts()
	GUISetState(@SW_SHOW, $gui)

	If FileExists($gw2loc) = 0 Then
		DirCreate(@AppDataDir & "\gw2lua")
		FileOpen($gw2loc)
		FileWrite($gw2loc, "gw2location|C:\Program Files (x86)\Guild Wars 2\Gw2-64.exe" & @CRLF & _
							"32|0" & @CRLF & _
							"assetsrv|0|" & @CRLF & _
							"authsrv|0|" & @CRLF & _
							"autologin|0" & @CRLF & _
							"bmp|0" & @CRLF & _
							"clientport80|0" & @CRLF & _
							"clientport443|0" & @CRLF & _
							"copydat|0" & @CRLF & _
							"dat|0|" & @CRLF & _
							"diag|0" & @CRLF & _
							"dx9single|0" & @CRLF & _
							"fprwardrenderer|0" & @CRLF & _
							"fps|0|" & @CRLF & _
							"image|0" & @CRLF & _
							"maploadinfo|0" & @CRLF & _
							"mce|0" & @CRLF & _
							"nopatchui|1" & @CRLF & _
							"nomusic|0" & @CRLF & _
							"noui|0" & @CRLF & _
							"nosound|0" & @CRLF & _
							"prefreset|0" & @CRLF & _
							"sharearchive|0" & @CRLF & _
							"uispanallmonitors|0" & @CRLF & _
							"uninstall|0" & @CRLF & _
							"useoldfov|0" & @CRLF & _
							"verify|0" & @CRLF & _
							"windowed|0" & @CRLF & _
							"umbra|0")
		FileClose($gw2loc)
	ElseIf FileExists($gw2loc) = 1 Then
		GUICtrlSetState($gui_login, $GUI_ENABLE)
		GUICtrlSetState($gui_update, $GUI_ENABLE)
		GUICtrlSetState($gui_repair, $GUI_ENABLE)
		FileOpen($gw2loc)
		Global $gw2 = StringRight(FileReadLine($gw2loc, 1), StringInStr(StringReverse(FileReadLine($gw2loc, 1)), "|") - 1)
		FileClose($gw2loc)
		$FileHandle = FileOpen($gw2loc)
		$fileinfo = FileReadToArray($FileHandle)
		If UBound($fileinfo) <= 20 Then
			FileClose($gw2loc)
			FileOpen($gw2loc,$FO_OVERWRITE)
			FileWrite($gw2loc, "gw2location|" & $gw2 & @CRLF & _
								"32|0" & @CRLF & _
								"assetsrv|0|" & @CRLF & _
								"authsrv|0|" & @CRLF & _
								"autologin|0" & @CRLF & _
								"bmp|0" & @CRLF & _
								"clientport80|0" & @CRLF & _
								"clientport443|0" & @CRLF & _
								"copydat|0" & @CRLF & _
								"dat|0|" & @CRLF & _
								"diag|0" & @CRLF & _
								"dx9single|0" & @CRLF & _
								"fprwardrenderer|0" & @CRLF & _
								"fps|0|" & @CRLF & _
								"image|0" & @CRLF & _
								"maploadinfo|0" & @CRLF & _
								"mce|0" & @CRLF & _
								"nopatchui|1" & @CRLF & _
								"nomusic|0" & @CRLF & _
								"noui|0" & @CRLF & _
								"nosound|0" & @CRLF & _
								"prefreset|0" & @CRLF & _
								"sharearchive|0" & @CRLF & _
								"uispanallmonitors|0" & @CRLF & _
								"uninstall|0" & @CRLF & _
								"useoldfov|0" & @CRLF & _
								"verify|0" & @CRLF & _
								"windowed|0" & @CRLF & _
								"umbra|0")
		EndIf
		FileClose($gw2loc)
	EndIf

	ReadSettings()

	While 1
		$aMsg = GUIGetMsg(1)
		Switch $aMsg[1]
			Case $gui
				Switch $aMsg[0]
					Case $GUI_EVENT_CLOSE
						Exit
					Case $gui_create
						gw2lua_new()
					Case $gui_multiclient
						Local $state = GUICtrlRead($gui_multiclient)
						If $state = 1 Then
							UpdateSettings("sharearchive", 1)
						ElseIf $state = 4 Then
							UpdateSettings("sharearchive", 0)
						EndIf
						ReadSettings()
					Case $gui_login
						$accountname = GUICtrlRead($gui_accountlist)
						$password = DecryptAccount($accountname)
						ShellExecute($gw2, ' -email "' & $accountname & '" -password "' & $password & '"' & $gw2_parameters)
					Case $gui_delete
						$accountname = GUICtrlRead($gui_accountlist)
						$confirmation = MsgBox($MB_YESNO, "Caution", "Do you wish to remove the '" & $accountname & "' account?")
						If $confirmation = $IDYES Then
							DeleteAccount($accountname)
						EndIf
						loadaccounts()
					Case $gui_update
						ShellExecute($gw2)
					Case $gui_repair
						$confirmation = MsgBox($MB_YESNO, "Caution", "Do you wish to repair your guild wars 2 file?")
						If $confirmation = $IDYES Then
							ShellExecute($gw2, "-repair")
						EndIf
					Case $gui_gw2location
						gw2lua_settings()
					Case $gui_deleteall
						$confirmation = MsgBox($MB_YESNO, "Caution", "Do you wish to remove all of your accounts?")
						If $confirmation = $IDYES Then
							FileOpen($FileLocation, $FO_OVERWRITE)
							FileClose($FileLocation)
						EndIf
						loadaccounts()
				EndSwitch
			Case $hGUI
				Switch $aMsg[0]
					Case $GUI_EVENT_CLOSE
						GUIDelete($hGUI)
					Case $g_idCreate
						Local $ReadAccount = GUICtrlRead($g_idAccount)
						Local $ReadPassword = GUICtrlRead($g_idPassword)
						Global $g_hKey = _Crypt_DeriveKey("CALG_AES_256", $iAlgorithm)
						If GUICtrlRead($g_idAccount) = '' Then
							MsgBox("", "Error!", "Account name is required in order to create new account")
						ElseIf GUICtrlRead($g_idPassword) = '' Then
							MsgBox("", "Error!", "Password is required in order to create new account")
						ElseIf GUICtrlRead($g_idAccount) <> '' Then
							If GUICtrlRead($g_idPassword) = '' Then
								MsgBox("", "Error!", "Password is required in order to create new account")
							ElseIf GUICtrlRead($g_idPassword) <> '' Then
								Local $Encrypted = _Crypt_EncryptData($ReadPassword, $g_hKey, $CALG_USERKEY)
								Local $LineWrite = $ReadAccount & "|" & $Encrypted
								CreateNewAccount($LineWrite)
							EndIf
						EndIf
						GUIDelete($hGUI)
						loadaccounts()
				EndSwitch
			Case $sGUI
				Switch $aMsg[0]
					Case $GUI_EVENT_CLOSE
						Local $state = GUICtrlRead($g_idassetsrv)
						If $state = 1 Then
							UpdateSettings("assetsrv", 1, 1, GUICtrlRead($g_idassetsrvinput))
						ElseIf $state = 4 Then
							UpdateSettings("assetsrv", 0, 0, '')
						EndIf
						Local $state = GUICtrlRead($g_idauthsrv)
						If $state = 1 Then
							UpdateSettings("authsrv", 1, 1, GUICtrlRead($g_idauthsrvinput))
						ElseIf $state = 4 Then
							UpdateSettings("authsrv", 0, 0, '')
						EndIf
						Local $state = GUICtrlRead($g_iddat)
						If $state = 1 Then
							UpdateSettings("dat", 1, 1, GUICtrlRead($g_iddatinput))
						ElseIf $state = 4 Then
							UpdateSettings("dat", 0, 0, '')
						EndIf
						Local $state = GUICtrlRead($g_idfps)
						If $state = 1 Then
							UpdateSettings("fps", 1, 1, GUICtrlRead($g_idfpsinput))
						ElseIf $state = 4 Then
							UpdateSettings("fps", 0, 0, '')
						EndIf
						ReadSettings()
						GUIDelete($sGUI)
					Case $g_gw2path
						$filedata = ''
						$sMessage = "Navigate to the guild wars 2 path and select gw2.exe or gw2-64.exe"
						Local $sFileOpenDialog = FileOpenDialog($sMessage, "C:\", "Guild Wars 2 (gw2*.exe)", $FD_FILEMUSTEXIST)
						If FileExists($FileLocation) = 0 Then
							DirCreate(@AppDataDir & "\gw2lua")
						EndIf
						Local $FileHandle = FileOpen($gw2loc)
						Local $fileinfo = FileReadToArray($FileHandle)
						For $i = 1 To UBound($fileinfo) + 1
							Local $readingline = FileReadLine($FileHandle, $i)
							If StringLeft($readingline, StringInStr($readingline, "|") - 1) = "gw2location" Then
								$line = 'gw2location|' & $sFileOpenDialog & @CRLF
							Else
								If $i = UBound($fileinfo) + 1 Then
									$line = $readingline
								ElseIf $i < UBound($fileinfo) + 1 Then
									$line = $readingline & @CRLF
								EndIf
							EndIf
							$filedata &= $line
							ConsoleWrite($line)
						Next
						FileClose($gw2loc)
						Local $FileHandle = FileOpen($gw2loc, $FO_OVERWRITE)
						FileWrite($FileHandle, $filedata)
						FileClose($gw2loc)
						GUICtrlSetState($gui_login, $GUI_ENABLE)
						GUICtrlSetState($gui_update, $GUI_ENABLE)
						GUICtrlSetState($gui_repair, $GUI_ENABLE)
						Global $gw2 = $sFileOpenDialog
						GUICtrlSetData($g_idlocation, $gw2)
						ReadSettings()
					Case $g_id32 ;1 = Checked, 4 = Unchecked
						Local $state = GUICtrlRead($g_id32)
						If $state = 1 Then
							UpdateSettings("32", 1)
						ElseIf $state = 4 Then
							UpdateSettings("32", 0)
						EndIf
						ReadSettings()
					Case $g_idassetsrv ;1 = Checked, 4 = Unchecked
						Local $state = GUICtrlRead($g_idassetsrv)
						If $state = 1 Then
							UpdateSettings("assetsrv", 1, 1, GUICtrlRead($g_idassetsrvinput))
						ElseIf $state = 4 Then
							UpdateSettings("assetsrv", 0, 0, '')
						EndIf
						ReadSettings()
					Case $g_idauthsrv ;1 = Checked, 4 = Unchecked
						Local $state = GUICtrlRead($g_idauthsrv)
						If $state = 1 Then
							UpdateSettings("authsrv", 1, 1, GUICtrlRead($g_idauthsrvinput))
						ElseIf $state = 4 Then
							UpdateSettings("authsrv", 0, 0, '')
						EndIf
						ReadSettings()
					Case $g_idautologin ;1 = Checked, 4 = Unchecked
						Local $state = GUICtrlRead($g_idautologin)
						If $state = 1 Then
							UpdateSettings("autologin", 1)
						ElseIf $state = 4 Then
							UpdateSettings("autologin", 0)
						EndIf
						ReadSettings()
					Case $g_idbmp ;1 = Checked, 4 = Unchecked
						Local $state = GUICtrlRead($g_idbmp)
						If $state = 1 Then
							UpdateSettings("bmp", 1)
						ElseIf $state = 4 Then
							UpdateSettings("bmp", 0)
						EndIf
						ReadSettings()
					Case $g_idclientport80 ;1 = Checked, 4 = Unchecked
						Local $state = GUICtrlRead($g_idclientport80)
						If $state = 1 Then
							UpdateSettings("clientport80", 1)
							UpdateSettings("clientport443", 0)
						ElseIf $state = 4 Then
							UpdateSettings("clientport80", 0)
						EndIf
						ReadSettings()
					Case $g_idclientport443 ;1 = Checked, 4 = Unchecked
						Local $state = GUICtrlRead($g_idclientport443)
						If $state = 1 Then
							UpdateSettings("clientport443", 1)
							UpdateSettings("clientport80", 0)
						ElseIf $state = 4 Then
							UpdateSettings("clientport443", 0)
						EndIf
					Case $g_idcopydat ;1 = Checked, 4 = Unchecked
						ReadSettings()
						Local $state = GUICtrlRead($g_idcopydat)
						If $state = 1 Then
							UpdateSettings("copydat", 1)
						ElseIf $state = 4 Then
							UpdateSettings("copydat", 0)
						EndIf
						ReadSettings()
					Case $g_iddat ;1 = Checked, 4 = Unchecked
						Local $state = GUICtrlRead($g_iddat)
						If $state = 1 Then
							UpdateSettings("dat", 1, 1, GUICtrlRead($g_iddatinput))
						ElseIf $state = 4 Then
							UpdateSettings("dat", 0, 0, '')
						EndIf
						ReadSettings()
					Case $g_iddiag ;1 = Checked, 4 = Unchecked
						Local $state = GUICtrlRead($g_iddiag)
						If $state = 1 Then
							UpdateSettings("diag", 1)
						ElseIf $state = 4 Then
							UpdateSettings("diag", 0)
						EndIf
						ReadSettings()
					Case $g_iddx9single ;1 = Checked, 4 = Unchecked
						Local $state = GUICtrlRead($g_iddx9single)
						If $state = 1 Then
							UpdateSettings("dx9single", 1)
						ElseIf $state = 4 Then
							UpdateSettings("dx9single", 0)
						EndIf
						ReadSettings()
					Case $g_idforwardrenderer ;1 = Checked, 4 = Unchecked
						Local $state = GUICtrlRead($g_idforwardrenderer)
						If $state = 1 Then
							UpdateSettings("fprwardrenderer", 1)
						ElseIf $state = 4 Then
							UpdateSettings("fprwardrenderer", 0)
						EndIf
						ReadSettings()
					Case $g_idfps ;1 = Checked, 4 = Unchecked
						Local $state = GUICtrlRead($g_idfps)
						If $state = 1 Then
							UpdateSettings("fps", 1, 1, GUICtrlRead($g_idfpsinput))
						ElseIf $state = 4 Then
							UpdateSettings("fps", 0, 0, '')
						EndIf
						ReadSettings()
					Case $g_idimage ;1 = Checked, 4 = Unchecked
						Local $state = GUICtrlRead($g_idimage)
						If $state = 1 Then
							UpdateSettings("image", 1)
						ElseIf $state = 4 Then
							UpdateSettings("image", 0)
						EndIf
						ReadSettings()
					Case $g_idmaploadinfo ;1 = Checked, 4 = Unchecked
						Local $state = GUICtrlRead($g_idmaploadinfo)
						If $state = 1 Then
							UpdateSettings("maploadinfo", 1)
						ElseIf $state = 4 Then
							UpdateSettings("maploadinfo", 0)
						EndIf
						ReadSettings()
					Case $g_idmce ;1 = Checked, 4 = Unchecked
						Local $state = GUICtrlRead($g_idmce)
						If $state = 1 Then
							UpdateSettings("mce", 1)
						ElseIf $state = 4 Then
							UpdateSettings("mce", 0)
						EndIf
						ReadSettings()
					Case $g_idnopatchui ;1 = Checked, 4 = Unchecked
						Local $state = GUICtrlRead($g_idnopatchui)
						If $state = 1 Then
							UpdateSettings("nopatchui", 1)
						ElseIf $state = 4 Then
							UpdateSettings("nopatchui", 1)
						EndIf
						ReadSettings()
					Case $g_idnomusic ;1 = Checked, 4 = Unchecked
						Local $state = GUICtrlRead($g_idnomusic)
						If $state = 1 Then
							UpdateSettings("nomusic", 1)
						ElseIf $state = 4 Then
							UpdateSettings("nomusic", 0)
						EndIf
						ReadSettings()
					Case $g_idnoui ;1 = Checked, 4 = Unchecked
						Local $state = GUICtrlRead($g_idnoui)
						If $state = 1 Then
							UpdateSettings("noui", 1)
						ElseIf $state = 4 Then
							UpdateSettings("noui", 0)
						EndIf
						ReadSettings()
					Case $g_idnosound ;1 = Checked, 4 = Unchecked
						Local $state = GUICtrlRead($g_idnosound)
						If $state = 1 Then
							UpdateSettings("nosound", 1)
						ElseIf $state = 4 Then
							UpdateSettings("nosound", 0)
						EndIf
						ReadSettings()
					Case $g_idprefreset ;1 = Checked, 4 = Unchecked
						Local $state = GUICtrlRead($g_idprefreset)
						If $state = 1 Then
							UpdateSettings("prefreset", 1)
						ElseIf $state = 4 Then
							UpdateSettings("prefreset", 0)
						EndIf
						ReadSettings()
					Case $g_idshareArchive ;1 = Checked, 4 = Unchecked
						Local $state = GUICtrlRead($g_idshareArchive)
						If $state = 1 Then
							UpdateSettings("sharearchive", 1)
						ElseIf $state = 4 Then
							UpdateSettings("sharearchive", 0)
							If GUICtrlRead($gui_multiclient) = 1 Then
								UpdateSettings("sharearchive", 1)
							EndIf
						EndIf
						ReadSettings()
					Case $g_iduispanallmonitors ;1 = Checked, 4 = Unchecked
						Local $state = GUICtrlRead($g_iduispanallmonitors)
						If $state = 1 Then
							UpdateSettings("uispanallmonitors", 1)
						ElseIf $state = 4 Then
							UpdateSettings("uispanallmonitors", 0)
						EndIf
						ReadSettings()
					Case $g_iduninstall ;1 = Checked, 4 = Unchecked
						Local $state = GUICtrlRead($g_iduninstall)
						If $state = 1 Then
							UpdateSettings("uninstall", 1)
						ElseIf $state = 4 Then
							UpdateSettings("uninstall", 0)
						EndIf
						ReadSettings()
					Case $g_iduseOldFov ;1 = Checked, 4 = Unchecked
						Local $state = GUICtrlRead($g_iduseOldFov)
						If $state = 1 Then
							UpdateSettings("useoldfov", 1)
						ElseIf $state = 4 Then
							UpdateSettings("useoldfov", 0)
						EndIf
						ReadSettings()
					Case $g_idverify ;1 = Checked, 4 = Unchecked
						Local $state = GUICtrlRead($g_idverify)
						If $state = 1 Then
							UpdateSettings("verify", 1)
						ElseIf $state = 4 Then
							UpdateSettings("verify", 0)
						EndIf
						ReadSettings()
					Case $g_idwindowed ;1 = Checked, 4 = Unchecked
						Local $state = GUICtrlRead($g_idwindowed)
						If $state = 1 Then
							UpdateSettings("windowed", 1)
						ElseIf $state = 4 Then
							UpdateSettings("windowed", 0)
						EndIf
						ReadSettings()
					Case $g_idumbra ;1 = Checked, 4 = Unchecked
						Local $state = GUICtrlRead($g_idumbra)
						If $state = 1 Then
							UpdateSettings("umbra", 1)
						ElseIf $state = 4 Then
							UpdateSettings("umbra", 0)
						EndIf
						ReadSettings()
				EndSwitch
		EndSwitch
	WEnd
EndFunc   ;==>gw2lua

Func loadaccounts()
	GUICtrlDelete($gui_accountlist)
	If FileExists($FileLocation) = 1 Then
		Local $FileHandle = FileOpen($FileLocation)
		Local $line = 1
		Local $acc
		Local $accounts
		Do
			Local $readingline = FileReadLine($FileHandle, $line)
			Local $accountname = StringLeft($readingline, StringInStr($readingline, "|") - 1)
			If $readingline <> '' Then
				$acc = $accounts
				$accounts = $accountname & "|" & $acc
			EndIf
			$line += 1
		Until $readingline = ''
	EndIf
	Global $gui_accountlist = GUICtrlCreateCombo("", 2, 22, 198, 20, BitOR($CBS_DROPDOWN, $WS_VSCROLL))
	GUICtrlSetData($gui_accountlist, $accounts)
EndFunc   ;==>loadaccounts

Func gw2lua_new()
	$hGUI = GUICreate("GW2 Login Utility App - New Account", 320, 45)
	GUICtrlCreateLabel("Account:", 5, 7, 100, 20)
	GUICtrlCreateLabel("Password:", 5, 27, 100, 20)
	$g_idAccount = GUICtrlCreateInput("", 60, 2, 200, 20)
	$g_idPassword = GUICtrlCreateInput("", 60, 23, 200, 20, $ES_PASSWORD)
	$g_idCreate = GUICtrlCreateButton("Create", 270, 2, 50, 41)
	GUISetState(@SW_SHOW, $hGUI)
EndFunc   ;==>gw2lua_new

Func gw2lua_settings()
	ReadSettings()
	$sGUI = GUICreate("GW2 Login Utility App - Settings", 360, 587)
	GUICtrlCreateLabel("GW2 Location:", 5, 10, 100, 20)
	$g_idlocation = GUICtrlCreateInput($gw2, 105, 8, 200, 20)
	$g_gw2path = GUICtrlCreateButton("Find", 310, 7, 50, 20)
	$g_id32 = GUICtrlCreateCheckbox("-32", 5, 27, 100, 20)
	$g_idassetsrv = GUICtrlCreateCheckbox("-assetsrv", 5, 47, 100, 20)
	$g_idassetsrvinput = GUICtrlCreateInput("", 105, 48, 200, 20)
	$g_idauthsrv = GUICtrlCreateCheckbox("-authsrv", 5, 67, 100, 20)
	$g_idauthsrvinput = GUICtrlCreateInput("", 105, 68, 200, 20)
	$g_idautologin = GUICtrlCreateCheckbox("-autologin", 5, 87, 100, 20)
	$g_idbmp = GUICtrlCreateCheckbox("-bmp", 5, 107, 100, 20)
	$g_idclientport80 = GUICtrlCreateCheckbox("-clientport 80", 5, 127, 100, 20)
	$g_idclientport443 = GUICtrlCreateCheckbox("-clientport 443", 5, 147, 100, 20)
	$g_idcopydat = GUICtrlCreateCheckbox("-copydat", 5, 167, 100, 20)
	$g_iddat = GUICtrlCreateCheckbox("-dat", 5, 187, 100, 20)
	$g_iddatinput = GUICtrlCreateInput("", 105, 188, 200, 20)
	$g_iddiag = GUICtrlCreateCheckbox("-diag", 5, 207, 100, 20)
	$g_iddx9single = GUICtrlCreateCheckbox("-dx9single", 5, 227, 100, 20)
	$g_idforwardrenderer = GUICtrlCreateCheckbox("-forwardrenderer", 5, 247, 100, 20)
	$g_idfps = GUICtrlCreateCheckbox("-fps ", 5, 267, 100, 20)
	$g_idfpsinput = GUICtrlCreateInput("", 105, 268, 200, 20)
	$g_idimage = GUICtrlCreateCheckbox("-image", 5, 287, 100, 20)
	$g_idmaploadinfo = GUICtrlCreateCheckbox("-maploadinfo", 5, 307, 100, 20)
	$g_idmce = GUICtrlCreateCheckbox("-mce", 5, 327, 100, 20)
	$g_idnopatchui = GUICtrlCreateCheckbox("-nopatchui (required)", 5, 347, 200, 20)
	$g_idnomusic = GUICtrlCreateCheckbox("-nomusic", 5, 367, 100, 20)
	$g_idnoui = GUICtrlCreateCheckbox("-noui", 5, 387, 100, 20)
	$g_idnosound = GUICtrlCreateCheckbox("-nosound", 5, 407, 100, 20)
	$g_idprefreset = GUICtrlCreateCheckbox("-prefreset", 5, 427, 100, 20)
	$g_idshareArchive = GUICtrlCreateCheckbox("-sharearchive (Required for MultiClient)", 5, 447, 300, 20)
	$g_iduispanallmonitors = GUICtrlCreateCheckbox("-uispanallmonitors", 5, 467, 100, 20)
	$g_iduninstall = GUICtrlCreateCheckbox("-uninstall", 5, 487, 100, 20)
	$g_iduseOldFov = GUICtrlCreateCheckbox("-useoldfov", 5, 507, 100, 20)
	$g_idverify = GUICtrlCreateCheckbox("-verify", 5, 527, 100, 20)
	$g_idwindowed = GUICtrlCreateCheckbox("-windowed", 5, 547, 100, 20)
	$g_idumbra = GUICtrlCreateCheckbox("-umbra gpu", 5, 567, 100, 20)
	GUICtrlSetState($g_id32, $Check_32)
	GUICtrlSetState($g_idassetsrv, $Check_asset)
	GUICtrlSetData($g_idassetsrvinput, $Check_assetinput)
	GUICtrlSetState($g_idauthsrv, $Check_authsrv)
	GUICtrlSetData($g_idauthsrvinput, $Check_authsrvinput)
	GUICtrlSetState($g_idautologin, $Check_autologin)
	GUICtrlSetState($g_idbmp, $Check_bmp)
	GUICtrlSetState($g_idclientport80, $Check_clientport80)
	GUICtrlSetState($g_idclientport443, $Check_clientport443)
	GUICtrlSetState($g_idcopydat, $Check_copydat)
	GUICtrlSetState($g_iddat, $Check_dat)
	GUICtrlSetState($g_iddatinput, $Check_datinput)
	GUICtrlSetState($g_iddiag, $Check_diag)
	GUICtrlSetState($g_iddx9single, $Check_dx9single)
	GUICtrlSetState($g_idforwardrenderer, $Check_fprwardrenderer)
	GUICtrlSetState($g_idfps, $Check_fps)
	GUICtrlSetData($g_idfpsinput, $Check_fpsinput)
	GUICtrlSetState($g_idimage, $Check_image)
	GUICtrlSetState($g_idmce, $Check_mce)
	GUICtrlSetState($g_idmaploadinfo, $Check_maploadinfo)
	GUICtrlSetState($g_idnopatchui, $Check_nopatchui)
	GUICtrlSetState($g_idnoui, $Check_noui)
	GUICtrlSetState($g_idnomusic, $Check_nomusic)
	GUICtrlSetState($g_idnosound, $Check_nosound)
	GUICtrlSetState($g_idprefreset, $Check_prefreset)
	GUICtrlSetState($g_idshareArchive, $Check_sharearchive)
	GUICtrlSetState($g_iduispanallmonitors, $Check_uispanallmonitors)
	GUICtrlSetState($g_iduninstall, $Check_uninstall)
	GUICtrlSetState($g_iduseOldFov, $Check_useoldfov)
	GUICtrlSetState($g_idverify, $Check_verify)
	GUICtrlSetState($g_idwindowed, $Check_windowed)
	GUICtrlSetState($g_idumbra, $Check_umbra)
	GUISetState(@SW_SHOW, $sGUI)
	ReadSettings()
EndFunc   ;==>gw2lua_settings

Func CreateNewAccount($lineitem)
	If FileExists($FileLocation) = 0 Then
		DirCreate(@AppDataDir & "\gw2lua")
	EndIf
	Local $FileHandle = FileOpen($FileLocation)
	FileWriteLine($FileLocation, $lineitem)
	FileClose($FileHandle)
EndFunc   ;==>CreateNewAccount

Func DecryptAccount($account)
	Local $FileHandle = FileOpen($FileLocation)
	Local $line = 1
	Do
		Local $readingline = FileReadLine($FileHandle, $line)
		Local $splitstring = StringLeft($readingline, StringInStr($readingline, "|") - 1)
		$line += 1
	Until $account = $splitstring
	Local $EncPass = StringRight($readingline, StringInStr(StringReverse($readingline), "|") - 1)
	Local $enp = _Crypt_DeriveKey("CALG_AES_256", $CALG_AES_256)
	Local $DecPass = BinaryToString(_Crypt_DecryptData($EncPass, $enp, $CALG_USERKEY))
	FileClose($FileHandle)
	Return $DecPass
EndFunc   ;==>DecryptAccount

Func DeleteAccount($account)
	$filedata = ''
	$FileHandle = FileOpen($FileLocation)
	$fileinfo = FileReadToArray($FileHandle)
	For $i = 1 To UBound($fileinfo) + 1
		$readingline = FileReadLine($FileHandle, $i)
		If StringLeft($readingline, StringInStr($readingline, "|") - 1) = $account Then
			$line = ''
		Else
			If $i = UBound($fileinfo) + 1 Then
				$line = $readingline
			ElseIf $i < UBound($fileinfo) + 1 Then
				$line = $readingline & @CRLF
			EndIf
		EndIf
		$filedata &= $line
	Next
	FileClose($FileHandle)
	$FileHandle = FileOpen($FileLocation, $FO_OVERWRITE)
	FileWrite($FileHandle, $filedata)
	FileClose($FileLocation)
EndFunc   ;==>DeleteAccount

Func UpdateSettings($setting, $value, $extra = '', $extravalue = '')
	$filedata = ''
	$FileHandle = FileOpen($gw2loc)
	$fileinfo = FileReadToArray($FileHandle)
	For $i = 1 To UBound($fileinfo) + 1
		$readingline = FileReadLine($FileHandle, $i)
		If StringLeft($readingline, StringInStr($readingline, "|") - 1) = $setting Then
			$line = $setting & '|' & $value & @CRLF
			If $extra <> '' Then
				$line = $setting & '|' & $value & "|" & $extravalue & @CRLF
			EndIf
		Else
			If $i = UBound($fileinfo) + 1 Then
				$line = $readingline
			ElseIf $i < UBound($fileinfo) + 1 Then
				$line = $readingline & @CRLF
			EndIf
		EndIf
		$filedata &= $line
	Next
	FileClose($FileHandle)
	$FileHandle = FileOpen($gw2loc, $FO_OVERWRITE)
	FileWrite($FileHandle, $filedata)
	FileClose($gw2loc)
EndFunc   ;==>UpdateSettings

Func ReadSettings()
	$gw2_parameters = ''
	$FileHandle = FileOpen($gw2loc)
	$fileinfo = FileReadToArray($FileHandle)
	For $i = 1 To UBound($fileinfo) + 1
		$stuff = ''
		$readingline = FileReadLine($FileHandle, $i)
		$lenright = StringLen(StringRight($readingline, StringInStr(StringReverse($readingline), "|")))
		$lenleft = StringLen($readingline) - $lenright
		$strleft = StringLeft($readingline, $lenleft)
		If $readingline = '32|1' Then
			$stuff = ' -32'
			Global $Check_32 = 1
		ElseIf $strleft = 'assetsrv|1' Then
			$stuff = ' -assetsrv' & ' "' & StringRight($readingline, StringInStr(StringReverse($readingline), "|") - 1) & '"'
			Global $Check_asset = 1
			Global $Check_assetinput = StringRight($readingline, StringInStr(StringReverse($readingline), "|") - 1)
		ElseIf $strleft = 'authsrv|1' Then
			$stuff = ' -authsrv' & ' "' & StringRight($readingline, StringInStr(StringReverse($readingline), "|") - 1) & '"'
			Global $Check_authsrv = 1
			Global $Check_authsrvinput = StringRight($readingline, StringInStr(StringReverse($readingline), "|") - 1)
		ElseIf $readingline = 'autologin|1' Then
			$stuff = ' -autologin'
			Global $Check_autologin = 1
		ElseIf $readingline = 'bmp|1' Then
			$stuff = ' -bmp'
			Global $Check_bmp = 1
		ElseIf $readingline = 'clientport80|1' Then
			$stuff = ' -clientport80'
			Global $Check_clientport80 = 1
			Global $Check_clientport443 = 0
		ElseIf $readingline = 'clientport443|1' Then
			$stuff = ' -clientport443'
			Global $Check_clientport443 = 1
			Global $Check_clientport80 = 0
		ElseIf $readingline = 'copydat|1' Then
			$stuff = ' -copydat'
			Global $Check_copydat = 1
		ElseIf $strleft = 'dat|1' Then
			$stuff = ' -dat' & ' "' & StringRight($readingline, StringInStr(StringReverse($readingline), "|") - 1) & '"'
			Global $Check_dat = 1
			Global $Check_datinput = StringRight($readingline, StringInStr(StringReverse($readingline), "|") - 1)
		ElseIf $readingline = 'diag|1' Then
			$stuff = ' -diag'
			Global $Check_diag = 1
		ElseIf $readingline = 'dx9single|1' Then
			$stuff = ' -dx9single'
			Global $Check_dx9single = 1
		ElseIf $readingline = 'fprwardrenderer|1' Then
			$stuff = ' -fprwardrenderer'
			Global $Check_fprwardrenderer = 1
		ElseIf $strleft = 'fps|1' Then
			$stuff = ' -fps' & ' "' & StringRight($readingline, StringInStr(StringReverse($readingline), "|") - 1) & '"'
			Global $Check_fps = 1
			Global $Check_fpsinput = StringRight($readingline, StringInStr(StringReverse($readingline), "|") - 1)
		ElseIf $readingline = 'image|1' Then
			$stuff = ' -image'
			Global $Check_image = 1
		ElseIf $readingline = 'maploadinfo|1' Then
			$stuff = ' -maploadinfo'
			Global $Check_maploadinfo = 1
		ElseIf $readingline = 'mce|1' Then
			$stuff = ' -mce'
			Global $Check_mce = 1
		ElseIf $readingline = 'nopatchui|1' Then
			$stuff = ' -nopatchui'
			Global $Check_nopatchui = 1
		ElseIf $readingline = 'nopatchui|0' Then
			$stuff = ' -nopatchui'
			Global $Check_nopatchui = 1
		ElseIf $readingline = 'nomusic|1' Then
			$stuff = ' -nomusic'
			Global $Check_nomusic = 1
		ElseIf $readingline = 'noui|1' Then
			$stuff = ' -noui'
			Global $Check_noui = 1
		ElseIf $readingline = 'nosound|1' Then
			$stuff = ' -nosound'
			Global $Check_nosound = 1
		ElseIf $readingline = 'prefreset|1' Then
			$stuff = ' -prefreset'
			Global $Check_prefreset = 1
		ElseIf $readingline = 'sharearchive|1' Then
			$stuff = ' -sharearchive'
			Global $Check_sharearchive = 1
		ElseIf $readingline = 'uispanallmonitors|1' Then
			$stuff = ' -uispanallmonitors'
			Global $Check_uispanallmonitors = 1
		ElseIf $readingline = 'uninstall|1' Then
			$stuff = ' -uninstall'
			Global $Check_uninstall = 1
		ElseIf $readingline = 'useoldfov|1' Then
			$stuff = ' -useoldfov'
			Global $Check_useoldfov = 1
		ElseIf $readingline = 'verify|1' Then
			$stuff = ' -verify'
			Global $Check_verify = 1
		ElseIf $readingline = 'windowed|1' Then
			$stuff = ' -windowed'
			Global $Check_windowed = 1
		ElseIf $readingline = 'umbra|1' Then
			$stuff = ' -umbra'
			Global $Check_umbra = 1
		EndIf
		If $readingline = '32|0' Then
			$stuff = ''
			Global $Check_32 = 4
		ElseIf $strleft = 'assetsrv|0' Then
			$stuff = ''
			Global $Check_asset = 4
			Global $Check_assetinput = ''
		ElseIf $strleft = 'authsrv|0' Then
			$stuff = ''
			Global $Check_authsrv = 4
			Global $Check_authsrvinput = ''
		ElseIf $readingline = 'autologin|0' Then
			$stuff = ''
			Global $Check_autologin = 4
		ElseIf $readingline = 'bmp|0' Then
			$stuff = ''
			Global $Check_bmp = 4
		ElseIf $readingline = 'clientport80|0' Then
			$stuff = ''
			Global $Check_clientport80 = 4
		ElseIf $readingline = 'clientport443|0' Then
			$stuff = ' -clientport443'
			Global $Check_clientport443 = 4
		ElseIf $readingline = 'copydat|0' Then
			$stuff = ' -copydat'
			Global $Check_copydat = 4
		ElseIf $strleft = 'dat|0' Then
			$stuff = ''
			Global $Check_dat = 4
			Global $Check_datinput = ''
		ElseIf $readingline = 'diag|0' Then
			$stuff = ''
			Global $Check_diag = 4
		ElseIf $readingline = 'dx9single|0' Then
			$stuff = ''
			Global $Check_dx9single = 4
		ElseIf $readingline = 'fprwardrenderer|0' Then
			$stuff = ''
			Global $Check_fprwardrenderer = 4
		ElseIf $strleft = 'fps|0' Then
			$stuff = ''
			Global $Check_fps = 4
			Global $Check_fpsinput = ''
		ElseIf $readingline = 'image|0' Then
			$stuff = ''
			Global $Check_image = 4
		ElseIf $readingline = 'maploadinfo|0' Then
			$stuff = ''
			Global $Check_maploadinfo = 4
		ElseIf $readingline = 'mce|0' Then
			$stuff = ''
			Global $Check_mce = 4
		ElseIf $readingline = 'nomusic|0' Then
			$stuff = ''
			Global $Check_nomusic = 4
		ElseIf $readingline = 'noui|0' Then
			$stuff = ''
			Global $Check_noui = 4
		ElseIf $readingline = 'nosound|0' Then
			$stuff = ''
			Global $Check_nosound = 4
		ElseIf $readingline = 'prefreset|0' Then
			$stuff = ''
			Global $Check_prefreset = 4
		ElseIf $readingline = 'sharearchive|0' Then
			$stuff = ''
			Global $Check_sharearchive = 4
		ElseIf $readingline = 'uispanallmonitors|0' Then
			$stuff = ''
			Global $Check_uispanallmonitors = 4
		ElseIf $readingline = 'uninstall|0' Then
			$stuff = ''
			Global $Check_uninstall = 4
		ElseIf $readingline = 'useoldfov|0' Then
			$stuff = ''
			Global $Check_useoldfov = 4
		ElseIf $readingline = 'verify|0' Then
			$stuff = ''
			Global $Check_verify = 4
		ElseIf $readingline = 'windowed|0' Then
			$stuff = ''
			Global $Check_windowed = 4
		ElseIf $readingline = 'umbra|0' Then
			$stuff = ''
			Global $Check_umbra = 4
		EndIf
		$gw2_parameters &= $stuff
	Next
	FileClose($FileHandle)
EndFunc   ;==>ReadSettings

Func MultiClientGO()
;~ @echo off
;~ rem Path to "handle.exe".
;~ set "_Handle=E:\bin\Handle\Handle.exe"
;~ rem Path to "Gw2.exe".
;~ set "_GWPath=F:\GW2-Second\Gw2.exe -maploadinfo"
;~ rem Windows user name.
;~ set "_User=GW2-Second"
;~ echo.GW2 Multi Launcher by Zygi4s.
;~ rem Find GW2 Mutex and kill it.
;~ for /f "tokens=3,6 delims=: " %%I in (’%_Handle% -accepteula -a "AN-Mutex-Window-Guild Wars 2"’) do if not "%%J" == "" %_Handle% -accepteula -c %%J -y -p %%I
;~ rem Delay to be safe.
;~ ping -n 2 127.0.0.1 &gt; nul
;~ rem Run GW2 as _User. Ask for password on first run.
;~ runas /savecred /user:"%_User%" "%_GWPath%"
;~ :EoF
;~ FileOpen(@ScriptDir & "\handle.exe"
EndFunc   ;==>MultiClientGO
