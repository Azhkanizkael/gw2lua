# Guild Wars 2 Login Utility Application
###Setup
If you're running 64bit Windows, run gw2lua-64.exe, if you're running 32bit Windows, run gw2lua.exe

Once the application has loaded, you're going to want to select "Guild Wars 2 Location" and navigate through the dialogue box to find your gw2.exe or gw2-64.exe based on if you're 32 or 64 bit. Once this step has been completed it will save the data to %appdata%\gw2lua\settings.gw2lua for reference later. This can be changed any time by going through this step again.

Now you need to add your account(s). This can be done by selecting the "Create New Account" option. This will pop up a new dialogue box where you need to enter in your account email and password. Make sure these are 100% correct as Guild Wars 2 will fail to launch and just sit at a blank screen unless they are correct. Once your account(s) have been created, they will be saved to %appdata%\gw2lua\hash.gw2lua where the email will be in plain text, but the password will be encrypted for security.

###Options
Now that you're set up, you can select any of the options. You can delete individual accounts, delete all accounts, update gw2, repair gw2, or log in to gw2 with the selected account.

Deleting an account will delete the currently selected account from the hash.gw2lua file. This will work for deleting account unless there is only 1 account in which case you need to select "Delete All Accounts" in order to delete it. Deleting all accounts clears the hash.gw2lua file of all account entries and leaves it blank. These will display confirmation dialogues to confirm that you want to perform the action you requested.

Updating Guild Wars 2 will just launch the Guild Wars 2 launcher normally with no parameters.

Repairing Guild Wars 2 will launch Guild Wars 2 with the -repair parameter. This will display a confirmation dialogue to confirm that this is the action you want to perform.

Logging in will log you in to Guild Wars 2 with the selected account in the dropdown menu. It takes the account provided and matches the password from the hash.gw2lua file then decrypts the password and passes it to a command line to run the game with the parameters required to run the game while bypassing the launcher and going straight to the character select screen.

###Help
If you have any requests for help or assistance, please leave me feedback on twitter or twitch.

Twitter: @Azhkanizkael

Twitch: Twitch.tv/Azhkanizkael
