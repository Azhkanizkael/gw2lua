# Guild Wars 2 Login Utility Application
### Setup
Run gw2lua.exe as found in the exe folder

Once the application has loaded, you're going to want to select "Launcher Settings" then select "find" in the new window and navigate through the dialogue box to find your gw2.exe or gw2-64.exe based on if you're 32 or 64 bit. Once this step has been completed it will save the data to %appdata%\gw2lua\settings.gw2lua for reference later. This can be changed any time by going through this step again.

Now you need to add your account(s). This can be done by selecting the "Create New Account" option. This will pop up a new dialogue box where you need to enter in your account email and password. Make sure these are 100% correct as Guild Wars 2 will fail to launch and just sit at a blank screen unless they are correct. Once your account(s) have been created, they will be saved to %appdata%\gw2lua\hash.gw2lua where the email will be in plain text, but the password will be encrypted for security.

### Options
Now that you're set up, you can select any of the options. You can delete individual accounts, delete all accounts, update gw2, repair gw2, or log in to gw2 with the selected account.

Deleting an account will delete the currently selected account from the hash.gw2lua file. Deleting all accounts clears the hash.gw2lua file of all account entries and leaves it blank. These will display confirmation dialogues to confirm that you want to perform the action you requested.

Updating Guild Wars 2 will just launch the Guild Wars 2 launcher normally with no parameters.

Repairing Guild Wars 2 will launch Guild Wars 2 with the -repair parameter. This will display a confirmation dialogue to confirm that this is the action you want to perform.

Logging in will log you in to Guild Wars 2 with the selected account in the dropdown menu. It takes the account provided and matches the password from the hash.gw2lua file then decrypts the password and passes it to a command line to run the game with the parameters required to run the game while bypassing the launcher and going straight to the character select screen.

### Help
If you have any requests for help or assistance, please leave me feedback on twitter or twitch.

Twitter: [@Azhkanizkael](https://twitter.com/azhkanizkael)

Twitch: [Twitch.tv/Azhkanizkael](https://www.twitch.tv/azhkanizkael)

### Legality of Multiclient
https://en-forum.guildwars2.com/discussion/65546/policy-dual-or-multi-boxing

A player may own and operate several accounts, but they may do so only when they play and control each account independently of any other account. This means that:
* Each account must be attended at all times.
* Each account must be operated independently of each other.
* Accounts must not be operated simultaneously using macros or bots.
* One keystroke should translate to one action on one account.

Here's what you should keep in mind if you plan to run multiple clients:
* You may use more than one account at the same time.
* You may use more than one computer at the same time.
* You must be actively playing on each account.
* You may NOT program your keyboard to perform functions on more than one account at a time. For example, if you press [W] on your keyboard to move forward, a single character on a single account should move forward. The keystroke or mouse click should not perform functions on more than one account.
* You may not use a macro to activate the skills of a character or multiple characters on more than one account.
* You may not use third-party botting tools to manage and play any number of characters, or to engage in unattended gameplay.

As a final note:
* Multi-boxing may ONLY be used in PvE areas. You are not permitted to run multiple accounts simultaneously in PvP, WvW, activities, or in other competitive environments.
* Note: We make an exception for the use of multiple accounts in custom arenas, but encourage anyone hosting a custom arena to, as a courtesy to all participants, specify that multi-boxing is allowed in that arena.

#### Conduct Breaches & Outcomes
Failing to observe the above guidelines may result in the suspension or termination of any/all associated accounts. To differentiate between bots, each actively playing character must also be responsive to GM inquiries, if contacted.

In addition to this, any behavior that violates the Guild Wars 2 User Agreement or the Guild Wars 2 Rules of Conduct may result in further disciplinary action as determined by the ArenaNet team.
